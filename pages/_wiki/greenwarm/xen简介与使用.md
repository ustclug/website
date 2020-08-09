---
---

# 1.2 Xen简介

Xen 是在剑桥大学作为一个研究项目被开发出来的，它已经在开源社区中得到了极大的推动。Xen 是一款 半虚拟化（paravirtualizing） VMM（虚拟机监视器，Virtual Machine Monitor）， 这表示，为了调用系统管理程序，要有选择地修改操作系统，然而却不需要修改操作系统上运行的应用程序。 虽然 VMWare 等其他虚拟化系统实现了完全的虚拟化（它们不必修改使用中的操作系统），但它们仍需要进行实时的机器代码翻译，这会影响性能。 由于 Xen 需要修改操作系统内核，所以您不能直接让当前的 Linux 内核在 Xen 系统管理程序中运行，除非它已经 移植到了 Xen 架构。不过，如果当前系统可以使用新的已经移植到 Xen 架构的 Linux 内核，那么 您就可以不加修改地运行现有的系统。 

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-1.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-182c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-1.jpg") 图 1-1 简单的 Xen 架构 Xen 是一个开放源代码的para-virtualizing虚拟机（VMM）或“管理程序 ”，是为x86架构的机器而设计的。Xen 可以在 一套物理硬件上安全的执行多个虚拟机。 

## 1.2.1 硬件支持

目前运行在x86架构的 机器上，需要P6或更新的处理器（比如 Pentium Pro, Celeron, Pentium II, Pentium III, Pentium IV, Xeon, AMD Athlon, AMD Duron)。支 持多 处理器，并且支持超线程（SMT）。另外对IA64和Power架构的开发也在进行中。 32位Xen支持最大4GB内存。可是Xen 3.0 为Intel处理器物理指令集(PAE)提供支持，这样就能使x86/32架构的机器支持到64GB的物理内存。Xen 3.0也能支持x86/64 平台支持，比如 Intel EM64T 和AMD Opteron能支持1TB的物理 内存以上。 

## 1.2.2 基于Xen的系统架构

基于Xen的操作系统，有多个层，最底层和最高特权层是 Xen程序本身。Xen 可以管理多个客户操作系统，每个操作系统都能在一个安全的虚拟机中实现。在Xen的术语中，Domain由Xen控制，以高效的利用CPU的物理资源。每 个客户操作系统可以管理它自身的应用。这种管理包括每个程序在规定时间内的响应到执行，是通过Xen调度到虚拟机中实现。 当Xen启动运行后，第一个虚拟的操作系统，就是 Xen本身，我们通过xm list，会发现有一个Domain 0的虚拟机。Domain 0 是其它虚拟主机的管理者和控制者，Domain 0 可以构建其它的更多的Domain ，并管理虚拟设备。它还能执行管理任务，比如虚拟机的体眠、唤醒和迁移其它虚拟机。 一个被称为xend的服务器进程通过domain 0来管理系统，Xend 负责管理众多的虚拟主机，并且提供进入这些系统的控制台。命令经一个命令行的工具通过一个HTTP的接口被传送到xend。 

# 1.3 安装Xen

Xen发行版包括三个主要的部件：Xen本身，在Xen上运行Linux和NetBSD的接口，及管理基于Xen的系统的用户工具。 GTES11已经包含了Xen的相关安装包，在安装GTES11操作系统的时候，选择典型安装方式或者完全安装方式即可。 你也可以选择自定义安装方式，然后选择安装虚拟化相关组件。 系统安装成功以后，在GRUB的启动菜单上选择带 有xen支持的选择，这样就可以启动有Xen支持的操作系统了。 用支持Xen的内核启动，看起来有点象 Linux常规引导。第一部份输出的是Xen本身的信息，这些信息是关于Xen自身和底层的硬件的信息。最后的输出是来自于XenLinux。 当XenLinux引导时，您能查看一些错误的信息。对于这些信息没有必要为他们担心，这是因为您的XenLinux和您原来用的没有带有Xen支持的那个之间不同配置而引起的。 当引导完成后，您应该可以登录您的操作系统了。 

# 1.4 引导Xen

引导系统进入Xen将要带你进入一个特权的 domain管理，Domain0。在这时，您可以创建客户domain，并通过xm create 命令来引导他们。 

## 1.4.1 从Domain0 开始引导

创建一个新的Domain的首先要准备一个 root文件系统，这个文件系统 可以是一个物理分区，一个LVM或其它的逻辑卷分区，映像文件，或在一个NFS 服务器上。最简单的是通过操作系统的安装盘把操作系统安装进另一个物理分区。 GTES11系统中启动支持Xen的内核以后，默认启动了xend守护进程。你可以通过以下命令进行查看： 

    
    
    /etc/init.d/xend status

如果xend没有默认启动，你可以手动启动xend守护进程，请输入如下命令： 

    
    
    xend start

## 1.4.2 引导客户Domains ( Booting Guest Domains )

    
    
    1.4.2.1	创建一个Domain配置文件

在启动一个虚拟的操作系统之前，必须创建 一个引导这个虚拟操作系统的配置文件 。 我们提供了两个示例文件，这能做为您学习Xen虚拟操作系统的一个起点。 

    
    
    /etc/xen/xmexample1 是引导一个虚 拟操作系统的配置文件示例。
    /etc/xen/xmexample2 是可 以引导多个虚拟操作系统的配置文件；设置xmid的变量的值，这样就可以通过xm 指定vmid对虚拟的操作系统进行管理。

还有其它一些有关 Domain的配置文件，您可以加以修改应用。 

    
    
    1.4.2.2	引导客户Domain

xm工具为管理Domain提供很多指令。 用create 指令来引导新的Domain。可以基于/etc/xen/xmexample2 创建自己的Domain管理配置文件myvmconf，这样启动一个Domain可以通过虚拟机的ID来引导。比如ID是1，您应该输入： 

    
    
    xm create -c myvmconf vmid=1

-c 参数是指后面要接配置文件，意思是通过配置文件引导，vmid=1是在myvmconf中的变量，不同的Domain，vmid的值也不一样。 然后您应该能看到从新Domain的在控制台启动的信息，最后您能登录被虚拟的操作系统。 

    
    
    1.4.2.3	自动启动/停止Domain

当系统启动的时候，Domain 也随之启动，并生成一个dom0守护进程，当dom0关闭系统之前，dom0上运行的Domain都要关闭。 可以指定一个Domain随系统自动启动，请放配置文件（或建一个 边链接)文件到/etc/xen/auto目录下。 对于GTES11系统，安装xen时，会在/etc/init.d目录下安装Sys-V风格初始化脚本。您可以根据需要启用它们。 默认情况下, 在运行级别是3、4、5 时, 引导时会启动它们。 

# 1.5 Xen的配置和管理

## 1.5.1 Xen的相关文件存放位置

安装有xen的操作系统下的/boot目录中，存放xen本身及支持xen的内核文件。 内核模块包括虚拟平台支持xen的内核xen0的模块，及支持虚拟操作系统所用的xenU的模块，一般的情况下是在 /lib/modules下有两个xen相关的目录存放。 Xen的配置文件存放于 /etc/xen目录。 比如 xend-config.sxp是用于配置网络的，不过我们不必更改，用其默认的就能完成我们的需要。xmexample1 xmexample2是两个示例性的配置文件。我们在配置引导被虚拟的操作系统时，这两个文件可供参考。 Xen的服务器xend和xendomains启动 脚本，一般是位于/etc/init.d/目录中，也就是/etc/init.d/xend ；/etc/init.d/xend负责启动xend服务器，而/etc/init.d/xendomains负责第一个虚拟的系统及其它的 Domains，也就是Domain 0。 Xen的可执行命令存放于/usr/sbin目录。 

## 1.5.2 Xen服务器的启动

Xend服务器的启动/停止/重启/状态查询，请用下面的命令: 

    
    
    /etc/init.d/xend start		启动xend，如果 xend没有运行
    /etc/init.d/xend stop		停止xend，如果xend正在运行
    /etc/init.d/xend restart		重启正在运行的 xend，如果xend没有运行，则启动
    /etc/init.d/xend status		查看xend状态

## 1.5.3 Xen管理工具xm

列出所有正在运行的虚拟操作系统，请执行以下命令： 

    
    
    /usr/sbin/xm list

通过配置文件来引导被虚拟的操作系统，请执行以下命令： 

    
    
    /usr/sbin/xmcreate -c 虚拟操作系统的启动配置文件

例如我们要启动被虚拟的操作系统GTES11 ，我们要写一个启动GTES11的配置文件，比如是gtes11vm.cfg。然后就可以通过下面的命令来引导GTES11了。 

    
    
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

调整虚拟平台及虚拟操作系统的虚拟CPU个数，可以执行以下命令： 

    
    
    /usr/sbin/xm vcpu-set

查看虚拟系统运行的状态，可以执行以下命令： 

    
    
    /usr/sbin/xm top
    /usr/sbin/xentop

# 1.6 存储和文件管理

虚拟的系统应该有一个存储的地方，也就是文件系统。 被虚拟的系统能安装和运行在一个实际的物理分区上，一个映像文件中，或NFS等网络文件系统中。 最常用的，最简单的方法是以物理块设备（一个硬盘或分区）做为虚拟系统的块设备。 也可以用一个映像文件或已经分割的文件系统映像为做为虚拟系统的块设备。 标准的网络存储协议支持的文件系统，比如NBD，iSCSI，NFS等，也能做为虚拟系统的存储系统。 

## 1.6.1 以物理硬盘作为虚拟块设备

以实际物理硬盘分区做为虚拟操作系统的文件系统，要经过硬盘分区，创建文件系统流程。 一个简单的配置就是直接把有效的物理分区做为虚拟块设备。在您的 domain配置文件中，通过用phy: 来指定。比如类似下面的一行： 

    
    
    disk = ['phy:hda3,sda1,w']

指定物理分区/dev/hda3虚拟为/dev/sda1，并且被虚拟 的系统所用的文件系统位于/dev/sda1。 块设备作为典型的配置在Domain中是只读的，否则Linux内核的文件系统由于Domain文件系统多次改变而变得混乱（相同的ext3分区以rw读 写方式挂载两次的解决办法会导致崩溃的危险！）。Xend通过检查设备没有以rw可写读模式被挂载于Domain0 上，并且检查同一个块设备没有以读写的方式应用于另外一个Domain上。 

## 1.6.2 以文件作为虚拟块设备

以映像文件做为虚拟操作系统的文件系统，这种方法是比较常用。也是比较方便和易于操作的，也就是说被虚拟的操作系统是放在了一个文件中。 例如，创建一个2G的文件，（文件的块的大小为1KB） 

    
    
    dd if=/dev/zero of=gtes11vm.img bs=1k seek=2048k count=1 

您可以调整上面命令参数的大小来创建您想要的体积大小的映像文件。 在映像文件上创建文件系 统： 

    
    
    mkfs.ext3 gtes11vm.img

(当有提示确认时，请输入'y') 移植文件系统，比如持目前您正在应用的Linux文件系统中拷贝： 

    
    
    mount -o loop gtes11vm.img /mnt
    cp -ax /{root,dev,var,etc,usr,bin,sbin,lib} /mnt
    mkdir /mnt/{proc,sys,home,tmp}

然后应该编辑/etc/fstab，/etc/hostname等。不要忘记是 在被mount的文件系统中更改这些，而不是您的 domain 0的文件系统。比如您应该编辑 /mnt/etc/fstab，而不是/etc/fstab。例如在/mnt/etc/fstab中添加一行 /dev/sda1。 卸载文件系统 

    
    
    umount /mnt

在配置文件中的设置： 

    
    
    disk = ['file:/full/path/to/gtes11vm.img,sda1,w']

就象虚拟机写入自己的硬盘，所以要设置映像文件所处的位置、虚拟硬盘、可读可写。 Linux支持最多８个虚拟文件系统，如果想解除这个设置，请用 max _loop的参数来配置，当然您所用的虚拟平台dom0内核已经 编译了 CONFIG_ BLK _DEV_ LOOP 这个选项。您可以在系统启动时，在boot选择中设置max_loop=n。 

## 1.6.3 以LVM作为虚拟块设备

您还可以用LVM卷作为虚拟机的文件系统。 初始化一个分区到LVM卷： 

    
    
    pvcreate /dev/sda10

创建一个卷组名'vg'在物理分区上： 

    
    
    vgcreate vg /dev/sda10

创建一个逻辑卷大小为４Ｇ，名字为'gtesvmdisk1'： 

    
    
    lvcreate -L4096M -n gtesvmdisk1 vg

现在你能在/dev/vg/gtesvmdisk1中创建一个文件系统，然后挂载它，并且构建虚拟系统： 

    
    
    mkfs -t ext3 /dev/vg/gtesvmdisk1
    mount /dev/vg/gtesvmdisk1 /mnt
    cp -ax / /mnt
    umount /mnt

现在对您的VM做如下配置: 

    
    
    disk = [ 'phy:vg/gtesvmdisk1,sda1,w' ]

LVM能让您调节逻辑卷的体积，你可以调整适合文件系统的体积大 小以便于有效的利用空闲空间。一些文件系统（比如ext3）支持在线调 整，请看 LVM手册，以获取更多的信息。 您也可以通过copy-on-write(CoW)来创建LVM 卷的克隆（在LVM术语的通称是可写的持续快照）。这个工具在最早出现在Linux 2.6.8的内核中，因此他不可能象希望的那样稳定。特别注意的是，大量应用CoW LVM 硬盘会占用很多dom0的内存，并且有错误情况发生，例如超出硬盘空间的不能被处理。希望这个特性在未来有所提升。 

## 1.6.4 以NFS做为虚拟系统的文件系统

您还可以用NFS服务器提供的文件系统做为虚拟系统的文件系统。 首先我们要通过修改/etc/exports文件来配置一个可用的NFS服务器。 然后配置虚拟机所用的NFS root。当然要指定NFS服务器的IP地址，应该确保有如下的参数，在虚拟系统引导的配置文件中： 

    
    
    root = '/dev/nfs'
    nfs_server = '2.3.4.5'		# NFS 服务器IP地址
    nfs_root = '/path/to/root'	# NFS服务器文件系统路径

# 1.7 安装GTES11虚拟机

## 1.7.1 使用“virt-install”安装虚拟机

使用“virt-install”来安装GTES11虚拟机，请执行以下命令： 

    
    
    /usr/sbin/virt-install

然后会依次出现一些关于将要安装的GTES11系统的问题需要回答。 你还可以通过-x ks=options参数来实现kickstart自动安装的各种方式。关于virt-install命令的详细用法，可以通过—help参数来查看。关于kickstart安装，请参阅相关文档。 问题1：What is the name of your virtual machine? 

    
    
          输入要安装的虚拟机名字，例如：gtes11vm

问题2：How much RAM should be allocated (in megabytes)? 

    
    
          输入要安装的虚拟机所需内存大小，以兆为单位，例如：512

（不小于256兆） 问题3：What would you like to use as the disk (path)? 

    
    
          输入虚拟机的安装路径，例如：/home/test/gtes11

问题４：How large would you like the disk (/home/test/gtes11) to be (in gigabytes)? 

    
    
          输入要安装的虚拟机大小，以G为单位，例如：10

问题５：Would you like to enable graphics support? (yes or no) 

    
    
          要安装的虚拟机需要图形支持吗？例如：yes

问题6：What is the install location? 

    
    
          输入要安装的虚拟机的源文件路径，GTES11目前支持NFS, FTP和HTTP三种方式。例如：
     nfs:my.nfs.server.com:/path/to/test/gtes11vm
     ftp://my.ftp.server.com/path/to/test/gtes11vm
     http://my.http.server.com/path/to/test/gtes11vm

对以上问题作出相应的回答以后，接下来的GTES11虚拟机安装就变得很容易了。如果选择支持图形方式，一个VNC窗口就会弹出来，如下图所示。 

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-2.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-282c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-2.jpg") 图 1-2 图形方式下选择安装语言 然后和普通图形安装方式类似，对语言，网络等配置以后，就会出现一个欢迎界面。如下图所示。 

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-3.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-382c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-3.jpg") 1-3 图形方式下欢迎界面 如果没有选择图形方式，就是标准的文本安装GTES11。如下图所示。 

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-4.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-482c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-4.jpg") 图 1-4 文本方式下选择安装语言 然后和普通安装文本方式类似，对语言，网络等配置以后，就会出现一个欢迎界面。如下图所示。 

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-5.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-582c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-5.jpg") 1-5 文本方式下欢迎界面 接下来的GTES11虚拟机安装跟普通文本方式安装GTES11没有什么两样。 

## 1.7.2 使用“virt-manager”安装虚拟机

使用“virt-manager”来安装GTES11虚拟机，请执行以下命令： /usr/sbin/virt-manager 或者通过“应用程序→系统工具”来选择“Virtual Machine Manager”。 

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-6.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-682c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-6.jpg") 1-6 连接到本地Xen宿主 点击“连接”按钮，出现虚拟系统管理主窗口。如下图所示。 

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-7.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-782c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-7.jpg") 1-7 虚拟系统管理 点击“新建”按钮，出现创建新的虚拟系统主窗口。如下图所示。 

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-8.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-882c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-8.jpg") 1-8 创建新的虚拟系统主窗口 点击“前进”按钮。 

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-9.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-982c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-9.jpg") 1-9 为虚拟系统命名 命名新的虚拟机，然后点击“前进”按钮。 

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-10.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-1082c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-10.jpg") 1-10 选择虚拟化方式 选择虚拟化方式，然后点击“前进”按钮。 

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-11.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-1182c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-11.jpg") 1-11 定位安装介质 指定GTES11安装镜像所在位置，支持NFS, HTTP, FTP三种方式。 还可以指定Kickstart文件位置。 然后点击“前进”按钮。 

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-12.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-1282c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-12.jpg") 1-12 分配存储空间 为新的GTES11虚拟机分配存储空间，可以选择物理磁盘分区或者文件。 然后点击“前进”按钮。 

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-13.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-1382c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-13.jpg") 1-13 分配内存大小及CPU个数 为新的GTES11虚拟机分配内存大小以及CPU个数。 然后点击“前进”按钮。 

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-14.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-1482c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-14.jpg") 1-14 虚拟机配置 确认配置无误后，点击“结束”按钮。 

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-15.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-1582c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-15.jpg") 1-15 创建虚拟机 等虚拟机所需文件或者物理空间创建完毕以后，接下来的GTES11虚拟机安装跟普通图形方式安装GTES11类似。 

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-16.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-1682c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-16.jpg") 1-16 选择安装语言 然后和普通图形安装方式类似，对语言，网络等配置以后，就会出现一个欢迎界面。 接下来的GTES11虚拟机安装就变得很容易了。 

## 1.7.3 使用“virt-manager”管理虚拟机

使用“virt-manager”来管理GTES11虚拟机，请执行以下命令： /usr/sbin/virt-manager 或者通过“应用程序→系统工具”来选择“Virtual Machine Manager”。 

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-17.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-1782c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-17.jpg") 1-17 连接到本地Xen宿主 点击“连接”按钮，出现虚拟系统管理主窗口。如下图所示。 

[![](/wiki/_media/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-18.html)](/wiki/_detail/%e7%b3%bb%e7%bb%9f%e7%ae%a1%e7%90%86/xen-1882c6?id=greenwarm%3Axen%E7%AE%80%E4%BB%8B%E4%B8%8E%E4%BD%BF%E7%94%A8 "系统管理:xen-18.jpg") 1-18 虚拟系统管理 然后就可以在图形方式下对虚拟机进行管理了。关于virt-manager的详细用法，请参阅相关项目文档。 
