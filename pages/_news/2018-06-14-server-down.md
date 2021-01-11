---
title: 服务器宕机通知
image: https://ftp.lug.ustc.edu.cn/wp-content/uploads/2018-06-14-server-down.png
author: hejiyan
date: "2018-06-14 01:10:50 +0800"
categories:
  - LUG服务器
tags: []
---

**2018-06-16 UPDATE3**:

目前以下服务已经恢复正常：

- 主页 (wiki)：[https://lug.ustc.edu.cn/](https://lug.ustc.edu.cn/) （已恢复）
- 代码托管平台：[https://git.ustclug.org/](https://git.ustclug.org/) （已恢复，建议用户切换新地址：git.lug.ustc.edu.cn）
- LUG FTP：[https://ftp.lug.ustc.edu.cn/](https://ftp.lug.ustc.edu.cn/) （已恢复）
- 反向代理：\*.proxy.ustclug.org （已恢复）

如果您使用上述服务时遇到问题，请向我们反馈。

**2018-06-15 UPDATE2**:

目前以下服务已经恢复正常：

- 主页 (wiki)：[https://lug.ustc.edu.cn/](https://lug.ustc.edu.cn/) （已恢复）
- 代码托管平台：[https://git.ustclug.org/](https://git.ustclug.org/) （已恢复，建议用户切换新地址：git.lug.ustc.edu.cn）
- LUG FTP：[https://ftp.lug.ustc.edu.cn/](https://ftp.lug.ustc.edu.cn/) （已恢复）

由于网络架构的变化，部分服务需要您的 DNS 缓存过期后得到新的解析结果才能生效，这依赖于您的网络环境，您也可以尝试手动刷新缓存。维护期间服务的稳定性有下降，这是正常现象，如果您在使用中持续遇到问题，请联系我们。

从数据备份中恢复数据并没有计划中的这么一帆风顺，我们仍在努力恢复受影响的各项服务，接下来的工作计划是按照以下顺序继续恢复服务：

- 反向代理：\*.proxy.ustclug.org
- 网络加速服务
- VPN 在线申请系统
- 轻量级网络加速服务

给您带来的不便敬请谅解。

**2018-06-14 UPDATE1**:

初步的调查结果显示，此次宕机事件原因是虚拟机宿主机 3 号节点上的一块年代久远的硬盘因为老化或其他原因出现问题，导致该节点上运行的虚拟机全部宕机，并且导致该节点也无法被虚拟机集群控制，其上运行的虚拟机亦无法直接的迁移。

目前的修复方案是从我们的数据备份中恢复重要的服务到没有受影响的节点上重新运行，恢复备份和重建原有的网络环境还需要一段时间，给您带来的不便敬请谅解。

---

今天早些时候（2018-06-14 00:40 左右），由于我们的虚拟机宿主机 3 号节点的某些问题，LUG 内网包括网关与统一认证在内的部分关键服务器宕机，进而导致一部分服务不能正常提供，我们已经知悉并且开始处理这些问题。

以下服务因为此事件暂时不能正常运行，正在抢修中：

- 代码托管平台：[https://git.ustclug.org/](https://git.ustclug.org/) （已恢复）
- 网络加速服务
- 防污染 DNS
- 主页 (wiki)：[https://lug.ustc.edu.cn/](https://lug.ustc.edu.cn/) （已恢复）
- 反向代理：\*.proxy.ustclug.org （已恢复）
- VPN 在线申请系统
- 轻量级网络加速服务
- 服务器统一认证：ldap.ustclug.org
- 内网 VPN
- LUG FTP：[https://ftp.lug.ustc.edu.cn/](https://ftp.lug.ustc.edu.cn/) （已恢复）
- Ganglia 监控：[https://status.ustclug.org/](https://status.ustclug.org/)
- LDAP 配置管理系统（GOSA2）

以下服务暂不受此次事件影响：

- 开源镜像站（HTTP 访问）：[https://mirrors.ustc.edu.cn/](https://mirrors.ustc.edu.cn/)
- 开源镜像站（定时同步；rsync、FTP 访问；帮助页面）：[https://mirrors.ustc.edu.cn/](https://mirrors.ustc.edu.cn/)
- 权威 DNS：ns-a.ustclug.org. ns-b.ustclug.org. ns-c.ustclug.org.
- 网络启动：pxe.ustc.edu.cn
- 图书馆透明计算系统
- PGP 密钥同步：[https://pgp.ustc.edu.cn/](https://pgp.ustc.edu.cn/)

受影响服务的恢复时间有待我们进一步查明事件原因后给出，给您带来的不便敬请谅解！

USTCLUG

2018-06-14 01:10:50
