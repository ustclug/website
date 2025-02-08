---
title: "Rootless Docker in Docker 在 Hackergame 中的实践"
author: rtxux
categories:
  - "Hackergame"
tags:
  - "Hackergame"
  - "Docker"
  - "Container"
---

本文介绍了 2024 年 USTC Hackergame 中 Rootless Docker in Docker 在 Web 类题目容器隔离中的实践。

## 背景

USTC Hackergame 长期以来使用 Docker 及 Docker Compose 来部署和管理各种题目。对于 `nc` 类题目，我们使用一个[简单的 Python 管理程序](https://github.com/USTC-Hackergame/hackergame-challenge-docker)来为每个已验证的传入连接创建一个单独的题目运行环境容器，以保证选手之间的隔离。为了动态创建容器，我们将 `/var/run/docker.sock` 暴露给这个 Python 程序，以便它可以调用 Docker API 来创建容器。由于这个 Python 程序足够简单，我们认为这样做是安全的。而对于 Web 类题目，我们要求出题人在题目内部做好隔离，然而这样带来了额外的心智负担，而且容易出错，可能导致非预期解或出现能够干扰其他选手的情况。

在 2024 年 Hackergame 中，我们决定实现 Web 类题目的容器隔离方案，北京大学 GeekGame 基于我们的 nc 容器管理方案实现了一个[简单的 Web 类题目容器管理方案](https://github.com/PKU-GeekGame/web-docker-manager)，该方案同样通过透传 Docker Socket 实现对 Web 题目的容器管理。然而，Web 题目的反向代理比 nc 复杂得多，这使得我们对该方案的安全性存在较大的担忧，一旦该管理程序被攻破，攻击者可以直接控制整个服务器。因此，我们需要一个更安全的方案，使得即使 Web 题目的容器管理程序被攻破，攻击者也无法轻易控制整个服务器，这就需要在隔离的、低权限的环境中运行 Docker Daemon。

## Rootless Docker-in-Docker

Rootless Docker 是在低权限环境中运行 Docker 的一种方案。Docker 官方提供了一种 [Rootless Docker in Docker](https://docs.docker.com/engine/security/rootless/#rootless-docker-in-docker) 的方案，只需要一行命令即可启动：

```bash
docker run -d --name dind-rootless --privileged docker:25.0-dind-rootless
```

该方案在容器中以非 `root` 用户（UID 1000）创建用户命名空间，并分离其他命名空间和运行 Docker Daemon。然而，该方案存在一些问题：

1. 该方案需要 `--privileged` 选项，以禁用 seccomp、AppArmor 和 mount masks，但这意味着容器将获得更高的权限，可能导致安全问题。
2. 该方案无法使用 cgroup 来限制容器资源使用，因为 Rootless Docker 需要 systemd 将 cgroup 路径委托给 Docker Daemon 才能执行资源限制。虽然可以用 `rlimit` 等方案来限制资源，但其工作在进程粒度而非容器粒度，而且可以被轻松禁用。由于 Hackergame 需要强制执行容器资源限制，该问题是致命的。

## 基于 Systemd User Instance 的 Rootless Docker-in-Docker

为了解决上述问题，我们采用了一个基于 Systemd User Instance 的 Rootless Docker-in-Docker 方案。该方案在 Systemd User Instance 中运行 Rootless Docker Daemon，以实现资源限制和更好的安全性。

### Systemd in Docker

为了实现该方案，首先需要在容器中运行 `systemd`。systemd 的网站上列出了[在容器中运行 systemd 的要求](https://systemd.io/CONTAINER_INTERFACE/)，对于 Docker 来说，主要有以下几点：

1. 保留 `CAP_SYS_ADMIN` 特权。
2. 启用私有 `cgroup` 命名空间，并将 `/sys/fs/cgroup` 挂载为可写。
3. 将 `/tmp`, `/run`, `/run/lock`, `/var/lib/journal` 挂载为 `tmpfs`。
4. 将 `stop_signal` 设置为 `SIGRTMIN+3`，以便 systemd 可以正确关闭。
5. 禁用 AppArmor 或 SELinux。

我们在 `docker-compose.yml` 中添加了以下内容来实现这些要求：

```yaml
cap_add:
  - SYS_ADMIN
  - NET_ADMIN
cgroup: private
devices:
  - /dev/net/tun:/dev/net/tun
tmpfs:
  - /tmp
  - /run
  - /run/lock
  - /var/lib/journal
stop_signal: SIGRTMIN+3
tty: true
security_opt:
  - seccomp=seccomp.json
  - apparmor=unconfined
  - systempaths=unconfined
```

其中 `seccomp.json` 可以从[这里](https://github.com/USTC-Hackergame/web-docker-manager/raw/refs/heads/main/rootless/seccomp.json)获取，该文件在 Docker [默认 seccomp 配置](https://github.com/moby/moby/raw/refs/heads/master/profiles/seccomp/default.json)的基础上允许了 `keyctl` 和 `pivot_root` 系统调用，这些系统调用是 Docker 所需要的。此外，该配置还一并禁用了 mount masks (`systempaths=unconfined`)，因为 Docker 启动容器时需要重新挂载 `/sys`。此外，我们还保留了 `NET_ADMIN` 特权，因为一些 systemd 的组件需要该特权。

需要注意的是，`cgroup: private` 并不会将 `/sys/fs/cgroup` 挂载为可写，因此我们需要在容器启动时手动处理，可以通过一个自定义的 `entrypoint.sh` 来实现：

```bash
#!/bin/bash

set -euo pipefail

mount --make-rshared /

# Remount cgroup
umount /sys/fs/cgroup
mount -t cgroup2 -o rw,relatime,nsdelegate cgroup2 /sys/fs/cgroup

exec /lib/systemd/systemd
```

### Rootless Docker Daemon in Systemd User Instance

在容器中以非 `root` 身份运行 Docker Daemon 非常简单，只需要在容器中安装带 Rooeless 支持的 Docker：

```dockerfile
RUN apt-get install -y ca-certificates curl && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian bookworm stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin uidmap && \
    systemctl disable docker.service docker.socket containerd.service
```

并创建一个用户，假设名为 `rootless`，然后使用 `machinectl shell rootless@` 切换到该用户，并运行 `dockerd-rootless-setuptool.sh install` 即可安装 Rootless Docker Daemon，安装程序会自动创建 `~/.config/systemd/user/docker.service` 并将其安装到 `default.target`。设置环境变量 `DOCKER_HOST=unix:///run/user/$UID/docker.sock` 即可通过 Docker CLI 工具访问该 Rootless Docker Daemon。`

### Wrapping Up

将 Rootless Docker Daemon 安装脚本生成的 `~/.config/systemd/user/docker.service` 文件复制出来，并创建 `~/.config/systemd/user/default.target.wants` 中的相对路径符号链接，并在 Dockerfile 中添加创建用户和将这些文件到用户目录中的内容，最后通过在 `/var/lib/systemd/linger` 目录下创建名为用户名的空文件来使对应的 Systemd User Instance 自动启动，即可实现自动启动 Rootless Docker Daemon。

该方案最终版本代码位于 [USTC-Hackergame/web-docker-manager](https://github.com/USTC-Hackergame/web-docker-manager) 仓库的 `rootless` 目录，其中添加了一些用于持久化数据和暴露一些目录到主机的内容。

### 安全性分析

Rootless Docker 通过 [RootlessKit](https://github.com/rootless-containers/rootlesskit) 分离用户命名空间，来实现非特权用户的特权操作以创建容器，因此该方案的容器（命名空间）层次结构如下：

```
Host (Full Privilege)
└── systemd in Docker (UID 0, CAP_SYS_ADMIN, CAP_NET_ADMIN)
        └── RootlessKit (UID 0 in inner user namespace, with ALL capabilities; UID 1000 in outer user namespace, with no capabilities)
            └── Manager Container
            └── Web Challenge Container 1
            └── Web Challenge Container 2
```

若管理程序被攻破，则攻击者可以取得 RootlessKit 所创建的用户命名空间中的特权，但由于 RootlessKit 在外层用户命名空间是非特权用户，且运行在容器中，因此攻击者无法直接控制整个服务器，也无法直接访问 Host 的文件系统其他部分。

## 总结

通过基于 Systemd User Instance 的 Rootless Docker in Docker 方案，我们成功地实现了在隔离的、低权限的环境中运行 Docker Daemon，以实现 Web 类题目的容器隔离。该方案强制执行了容器的资源限制，并通过隔离 Docker Daemon 提高了安全性，使得即使 Web 题目的容器管理程序被攻破，攻击者也无法轻易控制整个服务器。该方案已经在 2024 年 USTC Hackergame 中应用于数道 Web 类题目并稳定运行。

尽管如此，该方案仍有改进空间，如当前外层容器仍需 `SYS_ADMIN` 特权，这实际上是相当大的权限，而 [Sysbox](https://github.com/nestybox/sysbox) 容器运行时可以在创建容器时直接分离用户命名空间，提供了一种不需要这些特权的替代方案，是一个可以探索的方向。此外，我们的方案为了方便直接禁用了 AppArmor Profile，但实际上只需要创建自定义的 AppArmor Profile 放松一些限制（如允许 `mount` 和放松一些路径下的限制），而不需要将其完全置于 `unconfined` 状态，这样可以进一步提升安全性，但仍需要进一步探索。
