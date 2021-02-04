---
title: 定制PXE Live系统
author: Stephen
date: "2011-05-24 02:03:48 +0800"
categories:
  - 经验分享
  - USTC网络启动服务
tags:
  - PXE
  - deepin
  - live
comments:
  - id: 211
    author: moper
    author_email: i@moper.me
    author_url: ""
    date: "2012-07-20 02:10:00 +0800"
    date_gmt: "2012-07-19 18:10:00 +0800"
    content: 这个蛮不错，不知道怎样才能与你们交流？有qq群什么的吗？
  - id: 213
    author: copper
    author_email: worldwar@mail.ustc.edu.cn
    author_url: ""
    date: "2012-08-16 17:20:00 +0800"
    date_gmt: "2012-08-16 09:20:00 +0800"
    content: 邮件列表。不适用qq
  - id: 214
    author: moper
    author_email: i@moper.me
    author_url: ""
    date: "2012-08-17 00:01:00 +0800"
    date_gmt: "2012-08-16 16:01:00 +0800"
    content: 怎样才能添加呢？
---

现在已经有上百中 Linux 发行版，很多发行版都提供了通过 PXE 启动的 Live 系统。在科大校园网网络启动服务上，我们部署了很多发行版的 Live 系统，例如 Ubuntu、Debian、Deepin、BackTrack、Knoppix 等，既给一些需要维护系统的同学带来了极大的便利，也使得那些未接触过 Linux 的同学可以“无痛”体验各发行版，并决定哪一款发行版更符合自己的口味。然而，随着校园网的发展，大家的需求也变得更加多样化。各发行版的 Linux 系统已经不能满足大家的需求，因此我们需要自己定制一些系统，以满足在学校中各个场合的需求。

## 发行版 Live 系统的限制

发行版提供的 Live 系统具有这些限制：

1.  数据易失。Live 系统启动后所有的修改都保存在内存中，重启系统后所有修改都丢失了。
1.  预装软件少。Live 系统只预装了很少的软件，不足以日常办公的需求，即使作为体验系统也偏少

## 各使用场合的需求

目前在校园网中，大家对系统的需求有这些：

1.  体验系统。对于 Linux 新手，要决定是否使用一个系统，一次体验是不够的，需要长期的使用，因此需要能够保存一些对系统的修改，如新装的软件、修改的配置文件、一些用户数据
1.  公共机房的系统，需要安装所有常用的软件
1.  个人移动办公使用的系统，需要能够将一些个人数据存放在网络上

因此，我们希望能够定自己定制 Live 系统，以满足各使用场合的需求。

## 使用 Debian Live 定制系统

在各发行版中，Debian 提供了定制 Live 系统的工具，[Debian Live](http://live.debian.net/)。[Debian Live 的文档](http://live.debian.net/manual/en/html/live-manual.html)中有非常详细的介绍。简化后的步骤为：

```
sudo apt-get install live-build
mkdir live-system && cd live-system
lb config
sudo lb build
```

其中，在 config 前可以自己修改 config 脚本来对 Live 系统的一些属性进行定制，例如 Live 的类型（ISO/PXE/HDD 等）、Live 系统使用的源、安装的软件等。在 build 系统之后也可以`chroot`到目标系统中进行进一步的定制。[这篇文章](http://onebitbug.me/use-debian-live-to-create-customized-pxe-live-debian)中有一个稍微详细的定制步骤。使用 live build 可以定制 debian，也可以定制 ubuntu。

然而，这个方法仍然比较麻烦，定制者需要完全从头定制一个系统，并且不能复用一些其他人已经定制过的系统。因此我们推荐选择一个最接近使用需求的系统，在这个系统的基础之上进行进一步定制，而定制步骤也会简洁很多。

## 基于 Linux Deepin 定制 Live 系统

通过观察容易发现，Ubuntu, Deepin, BackTrack 等 Live 系统都使用相似的方法进行封装，因此基于这些系统进行定制的方法基本相同。而 Deepin 的中国本地化做的最好，也最接近校园网中的各种需求，因此我们选择基于该系统进行定制。

首先观察一下这个 Live 系统的结构：

```
$ ls -R
.:
casper  DeepWin.exe  isolinux  md5sum.txt  preseed  README.diskdefines

./casper:
filesystem.manifest  filesystem.manifest-desktop  filesystem.size  filesystem.squashfs  initrd.lz  vmlinuz

./isolinux:
back.jpg  boot.cat  deepin  gfxboot.cfg  isolinux.bin  isolinux.cfg  menu.cfg  stdmenu.cfg  text.cfg

./preseed:
deepin.seed
```

其中最重要的三个文件是位于`casper`目录下的`vmlinuz`、`initrd.lz`、`filesystem.squashfs`。`vmlinuz`和`initrd.lz`分别是启动是使用的内核和`initrd`文件，在系统启动之后，会通过 NFS 挂载位于服务器上的这个 ISO 的根目录，然后挂载`filesystem.squashfs`，接着使用`aufs`将`filesystem.squashfs`一段内存挂载为根目录，这段内存空间做为`aufs`的写分支。

由此可知，我们要定制系统，只需要对这个 filesystem.squashfs 修改并重新打包即可。下面就开始对这个文件修改并打包。

首先挂载这个文件系统，复制一份，并`chroot`到这个系统环境中：

```
sudo mount -o loop -t squashfs filesystem.squashfs /mnt/
sudo cp -ar /mnt/ ~/filesystem/
sudo umount /mnt/
sudo mount -o bind /dev/ ~/filesystem/dev/
sudo mount -t proc procfs ~/filesystem/proc/
sudo cp /etc/resolv.conf ~/filesystem/etc/
sudo chroot ~/filesystem/ /bin/bash
```

此时，我们就已经在这个系统中了，我们可以按照我们的需求对系统进行任意的定制了。注意，直到文中提到退出`chroot`环境前，所有的命令都是在`chroot`中完成的。我们在科大，当然首先将 sources.list 修改为使用科大的源了：

```
sed -i 's/cn.archive.ubuntu.com/debian.ustc.edu.cn/g' /etc/apt/sources.list
sed -i 's#packages.deepin.org#debian.ustc.edu.cn/deepin#g' /etc/apt/sources.list.d/deepin.list
sed -i 's#packages.linuxmint.com#debian.ustc.edu.cn/linuxmint#g' mint.list
apt-get update
```

这篇文章里我们仅做演示用，所以不打算进行太多的定制，仅演示安装一个新的软件：

```
apt-get install vim
```

OK，定制完成啦！我们来重新封装文件系统。首先，退出`chroot`环境，并且卸载`proc`和`dev`文件系统。

```
exit
sudo umount ~/filesystem/proc/
sudo umount ~/filesystem/dev/
```

然后封装 squashfs 文件系统：

```
mv filesystem.squashfs old-filesystem.squashfs
sudo mksquashfs/ filesystem.squashfs
```

将新生成的`filesystem.squashfs`放到原来的位置，并将整个目录通过 NFS 导出。

这篇文章中将不介绍如何通过 PXE 启动这个系统，其方法与 Ubuntu 相同，网上有详细的教程。下一篇文章中，我们将会介绍如何进一步定制这个系统，在开机时，自动挂载科大提供给每个学生的 300M FTP 空间为 HOME 目录，文章中会稍微详细的介绍如何设置 PXE 服务器启动该系统。尽请期待！
