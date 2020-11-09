---
title: Debian中国官方镜像：ftp.cn.debian.org
author: Stephen
date: "2011-05-05 02:03:26 +0800"
categories:
  - LUG活动
tags:
  - mirrors.ustc.edu.cn
  - debian
  - ftp.cn.debian.org
comments:
  - id: 227
    author: OpenWares | Open Source and Free Matters &raquo; 搭建debian源镜像服务器
    author_email: ""
    author_url: http://openwares.net/linux/setup_debian_archive_mirror.html
    date: "2013-01-30 09:16:13 +0800"
    date_gmt: "2013-01-30 01:16:13 +0800"
    content:
      "[...] TO=&#8221;/srv/mirrors/debian/&#8221; ##镜像源存放位置 RSYNC_HOST=&#8221;ftp.cn.debian.org&#8221;
      ##镜像自哪个外部源,debian中国官方源镜像是最佳选择，当然ftp.tw.debian.org,ftp.kr.debian.org和ftp.jp.debian.org速度也很快，中国官方源镜像由中国科技大学维护
      ARCH_EXCLUDE=&#8221;alpha arm armel armhf hppa hurd-i386 i386 ia64 kfreebsd-amd64
      kfreebsd-i386 m68k mipsel mips powerpc s390 s390x sh sparc source&#8221; ##排除的架构，此处只保留amd64源，source源也排除，只镜像必要的，尽量节省硬盘空间。
      [...]"
  - id: 1319
    author: 教你如何升级 UBUNTU/DEBIAN 系统版本和更新补丁 | VoBe
    author_email: ""
    author_url: https://www.vobe.io/303
    date: "2015-09-01 16:30:52 +0800"
    date_gmt: "2015-09-01 08:30:52 +0800"
    content: "[&#8230;] 更多的国内外优秀的源： Ubuntu Debian [&#8230;]"
---

祝贺 mirrors.ustc.edu.cn 成为 Debian 中国官方镜像！此前，中国大陆 debian 镜像与主镜像延迟达 24 小时以上，现在，ftp.cn.debian.org 直接从 syncproxy.wna.debian.org 接受推送更新，其延迟降到 6 小时以内。此外，另一国内主力镜像 anheng.com 从 ftp.cn.debian.org 接受推送，延迟也在 10 小时以内。mirrors.sohu.com 亦开始从 ftp.cn.debian.org 同步。

## Debian 用户使用帮助

使用当前稳定版 Debian Squeeze 的用户，请使用以下内容替换`/etc/apt/sources.list`

```
deb http://ftp.cn.debian.org/debian squeeze main
deb-src http://ftp.cn.debian.org/debian squeeze main
deb http://ftp.cn.debian.org/debian squeeze-updates main
deb-src http://ftp.cn.debian.org/debian squeeze-updates main
deb http://mirrors.ustc.edu.cn/debian-security/ squeeze/updates main
deb-src http://mirrors.ustc.edu.cn/debian-security/ squeeze/updates main
```

其他版本用户请参考[Debian 使用帮助](http://mirrors.ustc.edu.cn/debian-security/)。

## 镜像同步帮助

### Debian Archive

请使用官方推荐的[ftpsync](http://mirrors.ustc.edu.cn/debian/project/ftpsync/ftpsync-current.tar.gz)脚本进行同步，脚本中有很详细的注释说明。如果有问题，请联系我们。

### Debian CD

如果您已经同步了 Debain Archive，那么推荐您使用[jigdo](http://atterer.org/jigdo/)来同步，这可以节省很多流量和时间，平均每个 CD 的 ISO 仅需不到 1 分钟。[这里](http://www.debian.org/CD/jigdo-cd/)有使用说明，同步脚本在[这里](http://ftp.mgts.by/debian-mirror/cdimage/)可以下载到。

### 推送同步

为了尽可能减少与 Debian 主服务器的延迟，推荐您接受我们的推送。每次 ftp.cn.debian.org 同步完成后，会主动告知下游源，激活下游源的同步脚本。要接受推送同步，请下载我们的 pubkey，并保存到运行同步脚本的用户的`~/.ssh/authorized_keys`中：

```
wget -O- http://mirrors.ustc.edu.cn/~stephen/debianpush.pub >> ~/.ssh/authorized_keys
```

然后发邮件告知您的服务器地址、ssh 端口以及用户。

## 联系方式

如果您对我们的服务器有任何建议或者意见，以及使用中碰到任何问题，都可以联系我们，我们的邮箱是：mirrors AT ustc.edu.cn.
