---
---

# 1.2 Xen 简介

Xen 是在剑桥大学作为一个研究项目被开发出来的，它已经在开源社区中得到了极大的推动。Xen 是一款 半虚拟化（paravirtualizing）VMM（虚拟机监视器，Virtual Machine Monitor），这表示，为了调用系统管理程序，要有选择地修改操作系统，然而却不需要修改操作系统上运行的应用程序。虽然 VMWare 等其他虚拟化系统实现了完全的虚拟化（它们不必修改使用中的操作系统），但它们仍需要进行实时的机器代码翻译，这会影响性能。由于 Xen 需要修改操作系统内核，所以您不能直接让当前的 Linux 内核在 Xen 系统管理程序中运行，除非它已经 移植到了 Xen 架构。不过，如果当前系统可以使用新的已经移植到 Xen 架构的 Linux 内核，那么 您就可以不加修改地运行现有的系统。

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-1.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-182c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-1.jpg") 图 1-1 简单的 Xen 架构 Xen 是一个开放源代码的 para-virtualizing 虚拟机（VMM）或“管理程序”，是为 x86 架构的机器而设计的。Xen 可以在 一套物理硬件上安全的执行多个虚拟机。

## 1.2.1 硬件支持

目前运行在 x86 架构的 机器上，需要 P6 或更新的处理器（比如 Pentium Pro, Celeron, Pentium II, Pentium III, Pentium IV, Xeon, AMD Athlon, AMD Duron)。支 持多 处理器，并且支持超线程（SMT）。另外对 IA64 和 Power 架构的开发也在进行中。32 位 Xen 支持最大 4GB 内存。可是 Xen 3.0 为 Intel 处理器物理指令集 (PAE) 提供支持，这样就能使 x86/32 架构的机器支持到 64GB 的物理内存。Xen 3.0 也能支持 x86/64 平台支持，比如 Intel EM64T 和 AMD Opteron 能支持 1TB 的物理 内存以上。

## 1.2.2 基于 Xen 的系统架构

基于 Xen 的操作系统，有多个层，最底层和最高特权层是 Xen 程序本身。Xen 可以管理多个客户操作系统，每个操作系统都能在一个安全的虚拟机中实现。在 Xen 的术语中，Domain 由 Xen 控制，以高效的利用 CPU 的物理资源。每 个客户操作系统可以管理它自身的应用。这种管理包括每个程序在规定时间内的响应到执行，是通过 Xen 调度到虚拟机中实现。当 Xen 启动运行后，第一个虚拟的操作系统，就是 Xen 本身，我们通过 xm list，会发现有一个 Domain 0 的虚拟机。Domain 0 是其它虚拟主机的管理者和控制者，Domain 0 可以构建其它的更多的 Domain，并管理虚拟设备。它还能执行管理任务，比如虚拟机的体眠、唤醒和迁移其它虚拟机。一个被称为 xend 的服务器进程通过 domain 0 来管理系统，Xend 负责管理众多的虚拟主机，并且提供进入这些系统的控制台。命令经一个命令行的工具通过一个 HTTP 的接口被传送到 xend。

# 1.3 安装 Xen

Xen 发行版包括三个主要的部件：Xen 本身，在 Xen 上运行 Linux 和 NetBSD 的接口，及管理基于 Xen 的系统的用户工具。GTES11 已经包含了 Xen 的相关安装包，在安装 GTES11 操作系统的时候，选择典型安装方式或者完全安装方式即可。你也可以选择自定义安装方式，然后选择安装虚拟化相关组件。系统安装成功以后，在 GRUB 的启动菜单上选择带 有 xen 支持的选择，这样就可以启动有 Xen 支持的操作系统了。用支持 Xen 的内核启动，看起来有点象 Linux 常规引导。第一部份输出的是 Xen 本身的信息，这些信息是关于 Xen 自身和底层的硬件的信息。最后的输出是来自于 XenLinux。当 XenLinux 引导时，您能查看一些错误的信息。对于这些信息没有必要为他们担心，这是因为您的 XenLinux 和您原来用的没有带有 Xen 支持的那个之间不同配置而引起的。当引导完成后，您应该可以登录您的操作系统了。

# 1.4 引导 Xen

引导系统进入 Xen 将要带你进入一个特权的 domain 管理，Domain0。在这时，您可以创建客户 domain，并通过 xm create 命令来引导他们。

## 1.4.1 从 Domain0 开始引导

创建一个新的 Domain 的首先要准备一个 root 文件系统，这个文件系统 可以是一个物理分区，一个 LVM 或其它的逻辑卷分区，映像文件，或在一个 NFS 服务器上。最简单的是通过操作系统的安装盘把操作系统安装进另一个物理分区。GTES11 系统中启动支持 Xen 的内核以后，默认启动了 xend 守护进程。你可以通过以下命令进行查看：

    /etc/init.d/xend status

如果 xend 没有默认启动，你可以手动启动 xend 守护进程，请输入如下命令：

    xend start

## 1.4.2 引导客户 Domains ( Booting Guest Domains )

    1.4.2.1	创建一个 Domain 配置文件

在启动一个虚拟的操作系统之前，必须创建 一个引导这个虚拟操作系统的配置文件。我们提供了两个示例文件，这能做为您学习 Xen 虚拟操作系统的一个起点。

    /etc/xen/xmexample1 是引导一个虚 拟操作系统的配置文件示例。
    /etc/xen/xmexample2 是可 以引导多个虚拟操作系统的配置文件；设置xmid的变量的值，这样就可以通过xm 指定vmid对虚拟的操作系统进行管理。

还有其它一些有关 Domain 的配置文件，您可以加以修改应用。

    1.4.2.2	引导客户 Domain

xm 工具为管理 Domain 提供很多指令。用 create 指令来引导新的 Domain。可以基于/etc/xen/xmexample2 创建自己的 Domain 管理配置文件 myvmconf，这样启动一个 Domain 可以通过虚拟机的 ID 来引导。比如 ID 是 1，您应该输入：

    xm create -c myvmconf vmid=1

-c 参数是指后面要接配置文件，意思是通过配置文件引导，vmid=1 是在 myvmconf 中的变量，不同的 Domain，vmid 的值也不一样。然后您应该能看到从新 Domain 的在控制台启动的信息，最后您能登录被虚拟的操作系统。

    1.4.2.3	自动启动/停止 Domain

当系统启动的时候，Domain 也随之启动，并生成一个 dom0 守护进程，当 dom0 关闭系统之前，dom0 上运行的 Domain 都要关闭。可以指定一个 Domain 随系统自动启动，请放配置文件（或建一个 边链接) 文件到/etc/xen/auto 目录下。对于 GTES11 系统，安装 xen 时，会在/etc/init.d 目录下安装 Sys-V 风格初始化脚本。您可以根据需要启用它们。默认情况下，在运行级别是 3、4、5 时，引导时会启动它们。

# 1.5 Xen 的配置和管理

## 1.5.1 Xen 的相关文件存放位置

安装有 xen 的操作系统下的/boot 目录中，存放 xen 本身及支持 xen 的内核文件。内核模块包括虚拟平台支持 xen 的内核 xen0 的模块，及支持虚拟操作系统所用的 xenU 的模块，一般的情况下是在 /lib/modules 下有两个 xen 相关的目录存放。Xen 的配置文件存放于 /etc/xen 目录。比如 xend-config.sxp 是用于配置网络的，不过我们不必更改，用其默认的就能完成我们的需要。xmexample1 xmexample2 是两个示例性的配置文件。我们在配置引导被虚拟的操作系统时，这两个文件可供参考。Xen 的服务器 xend 和 xendomains 启动 脚本，一般是位于/etc/init.d/目录中，也就是/etc/init.d/xend；/etc/init.d/xend 负责启动 xend 服务器，而/etc/init.d/xendomains 负责第一个虚拟的系统及其它的 Domains，也就是 Domain 0。Xen 的可执行命令存放于/usr/sbin 目录。

## 1.5.2 Xen 服务器的启动

Xend 服务器的启动/停止/重启/状态查询，请用下面的命令：

    /etc/init.d/xend start		启动xend，如果 xend没有运行
    /etc/init.d/xend stop		停止xend，如果xend正在运行
    /etc/init.d/xend restart		重启正在运行的 xend，如果xend没有运行，则启动
    /etc/init.d/xend status		查看xend状态

## 1.5.3 Xen 管理工具 xm

列出所有正在运行的虚拟操作系统，请执行以下命令：

    /usr/sbin/xm list

通过配置文件来引导被虚拟的操作系统，请执行以下命令：

    /usr/sbin/xmcreate -c 虚拟操作系统的启动配置文件

例如我们要启动被虚拟的操作系统 GTES11，我们要写一个启动 GTES11 的配置文件，比如是 gtes11vm.cfg。然后就可以通过下面的命令来引导 GTES11 了。

    /usr/sbin/xmcreate -c gtes11vm.cfg

从终端或控制台登录正在运行的虚拟操作系统，可以执行以下命令：

    /usr/sbin/xm console 正在运行的虚拟操作系统的Name或ID

存储正在运行的虚拟操作系统的状态及唤醒虚拟操作系统，可以执行以下命令：

    /usr/sbin/xm save
    /usr/sbin/xm restore

停止正在运行的虚拟操作系统/激活停止的虚拟操作系统，可以执行以下命令：

    /usr/sbin/xm pause
    /usr/sbin/xm unpause

调整虚拟平台/虚拟操作系统的占用内存，可以执行以下命令：

    /usr/sbin/xm mem-set

关闭被虚拟的系统，可以执行以下命令：

    /usr/sbin/xm shutdown虚拟操作系统的Name或DomID
    /usr/sbin/xm destroy

调整虚拟平台及虚拟操作系统的虚拟 CPU 个数，可以执行以下命令：

    /usr/sbin/xm vcpu-set

查看虚拟系统运行的状态，可以执行以下命令：

    /usr/sbin/xm top
    /usr/sbin/xentop

# 1.6 存储和文件管理

虚拟的系统应该有一个存储的地方，也就是文件系统。被虚拟的系统能安装和运行在一个实际的物理分区上，一个映像文件中，或 NFS 等网络文件系统中。最常用的，最简单的方法是以物理块设备（一个硬盘或分区）做为虚拟系统的块设备。也可以用一个映像文件或已经分割的文件系统映像为做为虚拟系统的块设备。标准的网络存储协议支持的文件系统，比如 NBD，iSCSI，NFS 等，也能做为虚拟系统的存储系统。

## 1.6.1 以物理硬盘作为虚拟块设备

以实际物理硬盘分区做为虚拟操作系统的文件系统，要经过硬盘分区，创建文件系统流程。一个简单的配置就是直接把有效的物理分区做为虚拟块设备。在您的 domain 配置文件中，通过用 phy: 来指定。比如类似下面的一行：

    disk = ['phy:hda3,sda1,w']

指定物理分区/dev/hda3 虚拟为/dev/sda1，并且被虚拟 的系统所用的文件系统位于/dev/sda1。块设备作为典型的配置在 Domain 中是只读的，否则 Linux 内核的文件系统由于 Domain 文件系统多次改变而变得混乱（相同的 ext3 分区以 rw 读 写方式挂载两次的解决办法会导致崩溃的危险！）。Xend 通过检查设备没有以 rw 可写读模式被挂载于 Domain0 上，并且检查同一个块设备没有以读写的方式应用于另外一个 Domain 上。

## 1.6.2 以文件作为虚拟块设备

以映像文件做为虚拟操作系统的文件系统，这种方法是比较常用。也是比较方便和易于操作的，也就是说被虚拟的操作系统是放在了一个文件中。例如，创建一个 2G 的文件，（文件的块的大小为 1KB）

    dd if=/dev/zero of=gtes11vm.img bs=1k seek=2048k count=1

您可以调整上面命令参数的大小来创建您想要的体积大小的映像文件。在映像文件上创建文件系 统：

    mkfs.ext3 gtes11vm.img

(当有提示确认时，请输入'y') 移植文件系统，比如持目前您正在应用的 Linux 文件系统中拷贝：

    mount -o loop gtes11vm.img /mnt
    cp -ax /{root,dev,var,etc,usr,bin,sbin,lib} /mnt
    mkdir /mnt/{proc,sys,home,tmp}

然后应该编辑/etc/fstab，/etc/hostname 等。不要忘记是 在被 mount 的文件系统中更改这些，而不是您的 domain 0 的文件系统。比如您应该编辑 /mnt/etc/fstab，而不是/etc/fstab。例如在/mnt/etc/fstab 中添加一行 /dev/sda1。卸载文件系统

    umount /mnt

在配置文件中的设置：

    disk = ['file:/full/path/to/gtes11vm.img,sda1,w']

就象虚拟机写入自己的硬盘，所以要设置映像文件所处的位置、虚拟硬盘、可读可写。Linux 支持最多 8 个虚拟文件系统，如果想解除这个设置，请用 max _loop 的参数来配置，当然您所用的虚拟平台 dom0 内核已经 编译了 CONFIG_ BLK _DEV_ LOOP 这个选项。您可以在系统启动时，在 boot 选择中设置 max_loop=n。

## 1.6.3 以 LVM 作为虚拟块设备

您还可以用 LVM 卷作为虚拟机的文件系统。初始化一个分区到 LVM 卷：

    pvcreate /dev/sda10

创建一个卷组名'vg'在物理分区上：

    vgcreate vg /dev/sda10

创建一个逻辑卷大小为 4G，名字为'gtesvmdisk1'：

    lvcreate -L4096M -n gtesvmdisk1 vg

现在你能在/dev/vg/gtesvmdisk1 中创建一个文件系统，然后挂载它，并且构建虚拟系统：

    mkfs -t ext3 /dev/vg/gtesvmdisk1
    mount /dev/vg/gtesvmdisk1 /mnt
    cp -ax / /mnt
    umount /mnt

现在对您的 VM 做如下配置：

    disk = [ 'phy:vg/gtesvmdisk1,sda1,w' ]

LVM 能让您调节逻辑卷的体积，你可以调整适合文件系统的体积大 小以便于有效的利用空闲空间。一些文件系统（比如 ext3）支持在线调 整，请看 LVM 手册，以获取更多的信息。您也可以通过 copy-on-write(CoW) 来创建 LVM 卷的克隆（在 LVM 术语的通称是可写的持续快照）。这个工具在最早出现在 Linux 2.6.8 的内核中，因此他不可能象希望的那样稳定。特别注意的是，大量应用 CoW LVM 硬盘会占用很多 dom0 的内存，并且有错误情况发生，例如超出硬盘空间的不能被处理。希望这个特性在未来有所提升。

## 1.6.4 以 NFS 做为虚拟系统的文件系统

您还可以用 NFS 服务器提供的文件系统做为虚拟系统的文件系统。首先我们要通过修改/etc/exports 文件来配置一个可用的 NFS 服务器。然后配置虚拟机所用的 NFS root。当然要指定 NFS 服务器的 IP 地址，应该确保有如下的参数，在虚拟系统引导的配置文件中：

    root = '/dev/nfs'
    nfs_server = '2.3.4.5'		# NFS 服务器IP地址
    nfs_root = '/path/to/root'	# NFS服务器文件系统路径

# 1.7 安装 GTES11 虚拟机

## 1.7.1 使用“virt-install”安装虚拟机

使用“virt-install”来安装 GTES11 虚拟机，请执行以下命令：

    /usr/sbin/virt-install

然后会依次出现一些关于将要安装的 GTES11 系统的问题需要回答。你还可以通过-x ks=options 参数来实现 kickstart 自动安装的各种方式。关于 virt-install 命令的详细用法，可以通过—help 参数来查看。关于 kickstart 安装，请参阅相关文档。问题 1：What is the name of your virtual machine?

          输入要安装的虚拟机名字，例如：gtes11vm

问题 2：How much RAM should be allocated (in megabytes)?

          输入要安装的虚拟机所需内存大小，以兆为单位，例如：512

（不小于 256 兆）问题 3：What would you like to use as the disk (path)?

          输入虚拟机的安装路径，例如：/home/test/gtes11

问题 4：How large would you like the disk (/home/test/gtes11) to be (in gigabytes)?

          输入要安装的虚拟机大小，以G为单位，例如：10

问题 5：Would you like to enable graphics support? (yes or no)

          要安装的虚拟机需要图形支持吗？例如：yes

问题 6：What is the install location?

          输入要安装的虚拟机的源文件路径，GTES11目前支持NFS, FTP和HTTP三种方式。例如：
     nfs:my.nfs.example.com:/path/to/test/gtes11vm
     ftp://my.ftp.example.com/path/to/test/gtes11vm
     http://my.http.example.com/path/to/test/gtes11vm

对以上问题作出相应的回答以后，接下来的 GTES11 虚拟机安装就变得很容易了。如果选择支持图形方式，一个 VNC 窗口就会弹出来，如下图所示。

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-2.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-282c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-2.jpg") 图 1-2 图形方式下选择安装语言 然后和普通图形安装方式类似，对语言，网络等配置以后，就会出现一个欢迎界面。如下图所示。

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-3.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-382c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-3.jpg") 1-3 图形方式下欢迎界面 如果没有选择图形方式，就是标准的文本安装 GTES11。如下图所示。

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-4.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-482c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-4.jpg") 图 1-4 文本方式下选择安装语言 然后和普通安装文本方式类似，对语言，网络等配置以后，就会出现一个欢迎界面。如下图所示。

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-5.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-582c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-5.jpg") 1-5 文本方式下欢迎界面 接下来的 GTES11 虚拟机安装跟普通文本方式安装 GTES11 没有什么两样。

## 1.7.2 使用“virt-manager”安装虚拟机

使用“virt-manager”来安装 GTES11 虚拟机，请执行以下命令： /usr/sbin/virt-manager 或者通过“应用程序 → 系统工具”来选择“Virtual Machine Manager”。

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-6.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-682c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-6.jpg") 1-6 连接到本地 Xen 宿主 点击“连接”按钮，出现虚拟系统管理主窗口。如下图所示。

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-7.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-782c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-7.jpg") 1-7 虚拟系统管理 点击“新建”按钮，出现创建新的虚拟系统主窗口。如下图所示。

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-8.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-882c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-8.jpg") 1-8 创建新的虚拟系统主窗口 点击“前进”按钮。

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-9.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-982c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-9.jpg") 1-9 为虚拟系统命名 命名新的虚拟机，然后点击“前进”按钮。

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-10.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-1082c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-10.jpg") 1-10 选择虚拟化方式 选择虚拟化方式，然后点击“前进”按钮。

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-11.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-1182c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-11.jpg") 1-11 定位安装介质 指定 GTES11 安装镜像所在位置，支持 NFS, HTTP, FTP 三种方式。还可以指定 Kickstart 文件位置。然后点击“前进”按钮。

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-12.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-1282c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-12.jpg") 1-12 分配存储空间 为新的 GTES11 虚拟机分配存储空间，可以选择物理磁盘分区或者文件。然后点击“前进”按钮。

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-13.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-1382c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-13.jpg") 1-13 分配内存大小及 CPU 个数 为新的 GTES11 虚拟机分配内存大小以及 CPU 个数。然后点击“前进”按钮。

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-14.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-1482c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-14.jpg") 1-14 虚拟机配置 确认配置无误后，点击“结束”按钮。

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-15.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-1582c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-15.jpg") 1-15 创建虚拟机 等虚拟机所需文件或者物理空间创建完毕以后，接下来的 GTES11 虚拟机安装跟普通图形方式安装 GTES11 类似。

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-16.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-1682c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-16.jpg") 1-16 选择安装语言 然后和普通图形安装方式类似，对语言，网络等配置以后，就会出现一个欢迎界面。接下来的 GTES11 虚拟机安装就变得很容易了。

## 1.7.3 使用“virt-manager”管理虚拟机

使用“virt-manager”来管理 GTES11 虚拟机，请执行以下命令： /usr/sbin/virt-manager 或者通过“应用程序 → 系统工具”来选择“Virtual Machine Manager”。

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-17.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-1782c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-17.jpg") 1-17 连接到本地 Xen 宿主 点击“连接”按钮，出现虚拟系统管理主窗口。如下图所示。

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-18.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-1882c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-18.jpg") 1-18 虚拟系统管理 然后就可以在图形方式下对虚拟机进行管理了。关于 virt-manager 的详细用法，请参阅相关项目文档。
