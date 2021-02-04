---
title: mirrors.ustc.edu.cn开张啦！
author: Stephen
date: "2011-04-14 01:55:12 +0800"
categories:
  - LUG活动
tags:
  - LUG
  - mirrors.ustc.edu.cn
comments:
  - id: 36
    author: 我是一块月饼
    author_email: yezigao0427@163.com
    author_url: ""
    date: "2011-12-03 00:05:50 +0800"
    date_gmt: "2011-12-02 16:05:50 +0800"
    content:
      "请问mirrors.ustc.edu是什么?\r\n\r\n为什么我下载firefox的时候会出现firefox setup 8.0.1 exe.
      from mirrors.ustc.edu.cn?\r\n\r\n谢谢你的解答"
  - id: 37
    author: redsky0802
    author_email: redsky0802@gmail.com
    author_url: ""
    date: "2011-12-03 01:10:56 +0800"
    date_gmt: "2011-12-02 17:10:56 +0800"
    content: 你好，mirrors.ustc.edu.cn是科大开源软件镜像站，这里有包括firefox在内的大量开源软件的镜像。你下载firefox的时候，有可能会从多个镜像中选择一个最近或者最快的镜像站点下载。
  - id: 48
    author: Aenon
    author_email: s.sn.giraffe@gmail.com
    author_url: http://aenon.co.cc
    date: "2011-12-19 10:10:50 +0800"
    date_gmt: "2011-12-19 02:10:50 +0800"
    content:
      "你好，mirrors.ustc.edu.cn 是中科大Linux用户组维护的开源软件镜像，其中包括了 Mozilla 的软件源。\r\n\r\nFirefox
      会根据你的ip自动选择最近的镜像站点，所以你可能会从这里下载到firefox. 无论从哪个镜像下载，下载下来的文件内容是一样的。"
---

经过大半周的迁移和新脚本的测试，现在 mirrors.ustc.edu.cn 已经基本稳定了。

新机器的域名：

```
IPv4/v6: mirrors.ustc.edu.cn  （能解析出教育网/电信/v6地址）
v4only:  mirrors4.ustc.edu.cn （能解析出教育网/电信地址）
v6only:  mirrors6.ustc.edu.cn
```

有些地方（比如我测试的合肥长宽），DNS 会解析出电信地址，但使用教育网地址访问更快，这时可以通过修改 hosts 指定强制使用教育网地址访问。

```
教育网ip：202.38.95.110
电  信ip：202.141.160.110
v6  地址：2001:da8:d800:95::110
```

## 支持的访问方式：

http/ftp/rsync

## 提供的服务：

原 debian.ustc.edu.cn 和 oss.ustc.edu.cn 提供的镜像服务基本上都迁移过来了，除 fedora/ubuntu-partner 外。fedora 正在进行同步，ubuntu-partner 也会在近几天同步过来。

原 centos.ustc.edu.cn 提供的 centos/epel/linux-2.6.git 也已经迁移过来了。

## 需要注意的修改：

debian.ustc.edu.cn 和 oss.ustc.edu.cn 两个域名已经设置为 mirrors.ustc.edu.cn 的别名，大多数镜像的相对地址没有改变，所以大家基本上不需要对原有设置进行修改（如 sources.list），可以继续正常使用。但是以下镜像用户请注意：

1.  gentoo 用户，原 portage 地址： rsync://oss.ustc.edu.cn/pub/gentoo-portage  已经调整为： rsync://mirrors.ustc.edu.cn/gentoo-portage
1.  cygwin 用户，原 cygwin 源地址： [http://oss.ustc.edu.cn/cygwin/cygwin/](http://oss.ustc.edu.cn/cygwin/cygwin/) 已经调整为： [http://mirrors.ustc.edu.cn/cygwin/](http://mirrors.ustc.edu.cn/cygwin/)
1.  原 ubuntu cdimage 地址： [http://debian.ustc.edu.cn/ubuntu-cd](http://debian.ustc.edu.cn/ubuntu-cd) 已经调整为： [http://mirrors.ustc.edu.cn/ubuntu-releases](http://mirrors.ustc.edu.cn/ubuntu-releases)
1.  原 fedora linux 地址： [http://oss.ustc.edu.cn/fedora/](http://oss.ustc.edu.cn/fedora/) 已经调整为： [http://mirrors.ustc.edu.cn/fedora/linux/](http://mirrors.ustc.edu.cn/fedora/linux/)
1.  centos.ustc 用户，请修改自己的 CentOS-Base.repo 和 epel.repo，将文件中的域名 centos.ustc.edu.cn  修改为  mirrors.ustc.edu.cn
1.  linux-2.6.git 用户，请修改 origin 地址： git remote set-url origin git://mirrors.ustc.edu.cn/linux-2.6.git

## 使用帮助：

大多数镜像的使用帮助已经完成，大家在对应的目录下，如： [http://mirrors.ustc.edu.cn/ubuntu/](http://mirrors.ustc.edu.cn/ubuntu/) 点击页面上方（标题下方）的使用说明链接，可以打开其对应的帮助信息，如如何设置 sources.list 文件。或者也可以直接打开 http://mirrors.ustc.edu.cn/mirror-help/<archive-name>.html 在首页上点击使用说明链接，点击其中对应的源的链接，也可以跳转查看相应的帮助。

由于人手不够，有些源还没有使用帮助信息，也欢迎大家帮忙写了，发送给我们。

## 状态监控：

在首页点击页面上方的同步状态链接，可以查看当前各镜像的同步状态，包括成功与否/上游源/镜像体积等。大家如果知道更好（更新、更快）的上游源，请联系我们。

如果同步出现故障，服务器的管理员会收到邮件通知，以尽快处理，所以大家看到状态监控页面中有显示同步失败的条目时，无需联系我们。

如果同步状态上显示同步正常，但实际使用过程中发现镜像有问题，请联系我们。

## 联系方式：

我们的邮箱：mirrors@ustc.edu.cn

## 鸣谢：

感谢中国科学技术大学、网络信息中心的支持，特别感谢 jameszhang 老师为我们提供服务器！
