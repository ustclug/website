---
redirect_from: /wiki/server/mirrors/
---

# 开源镜像站

**mirrors.ustc.edu.cn**

## 机器域名

- IPv4/v6: mirrors.ustc.edu.cn（能解析出教育网/电信/移动/联通/v6 地址）
- v4-only: ipv4.mirrors.ustc.edu.cn（能解析出教育网/电信/移动/联通地址）
- v6-only: ipv6.mirrors.ustc.edu.cn

在有些地方 DNS 会解析出电信地址，但可能使用教育网地址访问更快，这时可以通过修改 hosts 指定强制使用教育网地址访问。

- 教育网 IP：202.38.95.110 (cernet.mirrors.ustc.edu.cn)
- 电信 IP：202.141.160.110 (chinanet.mirrors.ustc.edu.cn)
- 移动 IP：202.141.176.110 (cmcc.mirrors.ustc.edu.cn)
- 联通 IP：218.104.71.170 (unicom.mirrors.ustc.edu.cn)
- IPv6:2001:da8:d800:95::110

## 访问方式

- [http](http://mirrors.ustc.edu.cn/)
- [https](https://mirrors.ustc.edu.cn/)
- rsync - **部分** [为什么？](https://servers.ustclug.org/2014/08/mirrors-newest-changes/)

## 使用帮助

<https://mirrors.ustc.edu.cn/help/>

详细文档在 [ustclug/mirrorhelp](https://github.com/ustclug/mirrorhelp), 欢迎您协助完善。

## 状态监控

<https://mirrors.ustc.edu.cn/status>

可以查看当前各镜像的同步状态，包括 成功与否/上游源/镜像体积等。

## 镜像站的历史

科大 LUG 自成立起便在 2003 年通过 BBS 网上筹款的方式搭建了当时教育网内极少数的几个 Debian GNU/Linux 的镜像源 [debian.ustc.edu.cn](https://mirrors.ustc.edu.cn)，随后又在其上添加了 Ubuntu Linux 的镜像。2008 年，借助吴峰光师兄捐助的机器，搭建了科大的开源镜像服务器 [oss.ustc.edu.cn](https://mirrors.ustc.edu.cn)，以吸纳更多的开源软件和 Linux 发行版。尽管如此，我们的服务器仍然有些不堪重负，服务供不应求。

2010 年底，在网络中心张焕杰老师的帮助下，我们获得了新的服务器，遂将之前两个镜像站的资源以及张老师自己搭建的 CentOS Linux 镜像整合到一起，形成了“科大镜像站” [mirrors.ustc.edu.cn](https://mirrors.ustc.edu.cn)。新网站正式对外发布时，好评如潮。随后我们又成功申请到了 Debian GNU/Linux 的中国官方镜像资格认证等多个官方镜像资格认证。

我们将一如既往的做好镜像服务器的维护工作，争取为大家提供更新更好的服务，使参与维护的同学得到更好的锻炼。
