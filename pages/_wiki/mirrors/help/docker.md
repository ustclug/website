---
---

# Docker 镜像使用帮助

此处的帮助文档已经废弃，新的内容请访问 <https://mirrors.ustc.edu.cn/help/>

由于带宽等各种条件限制，Docker Hub 源目前仅为科大校园网用户提供。

---

## 使用说明

新版的 Docker 使用 /etc/docker/daemon.json（Linux） 或者 %programdata%\docker\config\daemon.json（Windows） 来配置 Daemon。

请在该配置文件中加入（没有该文件的话，请先建一个）：

    {
      "registry-mirrors": ["https://docker.mirrors.ustc.edu.cn"]
    }

Docker Daemon configuration file 文档： <https://docs.docker.com/engine/reference/commandline/dockerd/#/daemon-configuration-file>

Docker for Windows 文档: <https://docs.docker.com/docker-for-windows/#/docker-daemon>

---

以下是一些过时的配置方法

在 Docker 的启动参数中加入:

    --registry-mirror=https://docker.mirrors.ustc.edu.cn

Ubuntu 用户（包括使用 systemd 的 Ubuntu 15.04）可以修改 /etc/default/docker 文件，加入如下参数：

    DOCKER_OPTS="--registry-mirror=https://docker.mirrors.ustc.edu.cn"

其他 systemd 用户可以通过执行 sudo systemctl edit docker.service 来修改设置, 覆盖默认的启动参数:

    [Service]
    ExecStart=
    ExecStart=/usr/bin/docker -d -H fd:// --registry-mirror=https://docker.mirrors.ustc.edu.cn
