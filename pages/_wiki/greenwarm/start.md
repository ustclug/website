---
permalink: /wiki/greenwarm/
---

# 引导技术浅析

计算机从来不是聪明的“电脑”，它只是在硬件设计者和程序员的设计下按部就班地运行。 

当计算机启动的时候它就需要这样的指示：“我现在该干嘛”。它不会主动地启动一个用户想要的系统，而是需要有个家伙，我们称之为loader来告诉它完成这件事情，这个过程就叫boot（引导）。 

计算机需要从存有程序数据的媒介里获取这个loader，这个时候它开始访问CMOS芯片里的指定的媒介，从中寻找loader。对于不同的媒介，可以在各自的某段地址里找到最初的引导代码，这段地址就称为引导区。引导区的代码载入之后，计算机就有了文件访问等更强大的功能，便开始进行下一步的引导。 

通常引导区的引导代码里指定了下一步的引导文件的位置和名称，于是计算机便据此载入引导文件，引导文件载入后的计算机更加强大，能够接收用户输入，并能交互地回显用户操作。 

接下来计算机开始寻找操作系统的内核，开始正式的系统启动过程。这时就不在我们讨论范围内了。 

载入了loader的计算机通常是如上所说地引导操作系统内核，然而也可以再更换性地载入另一个loader，将计算机的上下文环境变为另一个loader。很多时候我们会需要这种强大的功能满足我们的需求。 

grub，全称为GRand Unified Bootloader，就是一个功能十分强大的loader，它提供了多种引导方式，同时有很好的交互界面，能够方便设置各种引导环境和参数。 

# GRUB4DOS快速入门

## 为什么是grub4dos

grub4dos可以看作是grub的衍生版本，又从syslinux里吸取了一些东西。 grub4dos的优势大致如下： 

  1. 精简，非常适合U盘使用，其程序文件只有一个，外加一个用于配置的menu.lst；

  2. 引导扇区里的引导代码对主程序的寻找是自动的，也就是说当你安装好引导扇区里的引导代码后可以任意改变引导程序的位置（只要还是在根目录）；

  3. 支持ntfs，且与Windows的loader可以完美地互相引导。鉴于现行的PC基本上都是Windows PC，经常有需要用的地方；

  4. 方便的使用光盘/软盘镜像

  5. 国内研究较多，各种系统论坛都有相关的讨论和文档。

grub4dos也有一些缺点： 

  1. 可扩充性差，只支持固定的几种文件系统：fat32, ntfs, ext2/ext3/ext4；

  2. 兼容性下降，某些机型可能引导不起来。这也是功能增加的必然结果。

## 安装grub4dos

可以从grub4dos的主页<http://download.gna.org/grub4dos/>获取grub4dos，解压后获取后面操作需要的文件。 

grub4dos仅由两部分组成：处于任意一个可访问分区根目录的grldr主程序文件，用来引导扇区的引导代码。另外还有一个可选的配置文件menu.lst。 

首先是安装引导代码： 

  + Windows：可使用grubinst_gui，可从<http://download.gna.org/grubutil/>下载。

[![](../_media/greenwarm/grub4dos-installer.html)](../_detail/greenwarm/grub4dos-installerf38c?id=greenwarm%3Astart "greenwarm:grub4dos-installer.png")

  + Linux: 

    
    
    bootlace.com /dev/sdx（sdx为你的盘符）

接下来就是拷贝文件了，大家都会，一切搞定，就这么简单。 

如果你用的是自己的主机，已经装了别的系统，有自己的loader，你也可以用系统的loader来引导grub4dos。这一步取代了引导代码的安装。 

  + grub引导

  + grub2引导

  + XP（ntldr）引导

  + Windows 7（bootmgr）引导

## 使用grub4dos

学习grub4dos最好的方法就是看人家的menu.lst，menu.lst里的每条title实际上就是一系列的grub引导命令。 

下面贴一下我移动硬盘里的grub4dos的menu.lst： 

    
    
    # GRUB boot loader configuration.
    #
    
    # By default, boot the first entry.
    default 0
    
    # Boot automatically after 20 secs.
    timeout 20
    
    # Change the colors.
    color yellow/brown light-green/black
    
    title WinPE
    root		(hd0,0)
    chainloader /ldrxpe
    
    title Win7 PE
    root		(hd0,0)
    chainloader /bootmgr
    
    # map软盘的内存镜像
    title 1KEY GHOST
    root		(hd0,0)
    map --mem /ghos/ghost.img (fd0)
    map --hook
    rootnoverify (fd0)
    chainloader (fd0)+1
    
    # 沿用syslinux的方式
    title 1KEY GHOST(2nd way)
    root		(hd0,0)
    kernel /ghos/memdisk c=11520 h=4 s=36 floppy
    initrd /ghos/ghost.img
    
    # 只有kernel和initrd和Live系统
    title SliTaz GNU/Linux
    kernel /slitaz/bzimage root=/dev/null vga=771 autologin 
    initrd /slitaz/rootfs.gz
    
    # 会自动挂载别的文件作为根文件系统镜像，Ubuntu还可以指定路径
    title Try Ubuntu without installing
    kernel /ubuntu/vmlinuz boot=casper iso-scan/filename=/ubuntu/ubuntu-10.04.1-desktop-i386.iso ro quiet splash
    initrd /ubuntu/initrd.lz
    
    # 加载其他menu文件
    title BackTrack Linux
    root		(hd0,2)
    configurefile /boot/grub/menu.lst
    
    
    title Boot Local System:
    root
    
    title Boot From 1st Harddisk Patition
    map             (hd0) (hd1)
    map             (hd1) (hd0)
    rootnoverify    (hd1,0)
    makeactive
    chainloader     +1
    
    title Boot XP/2000/2003
    map             (hd0) (hd1)
    map             (hd1) (hd0)
    find --set-root /ntldr
    chainloader /ntldr
    
    title Boot Vista/WIN7
    map             (hd0) (hd1)
    map             (hd1) (hd0)
    find --set-root /bootmgr
    makeactive
    chainloader     +1
    
    title Boot bootmgr
    map             (hd0) (hd1)
    map             (hd1) (hd0)
    find --set-root /bootmgr
    chainloader /bootmgr
