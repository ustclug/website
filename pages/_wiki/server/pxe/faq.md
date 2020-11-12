---
permalink: /wiki/server/pxe/faq/
---

# 中国科学技术大学校园网 PXE 服务 FAQ

## 一般用户

### 什么是 PXE

PXE(Pre-boot Execution Environment)是由 Intel 设计的协议，它可以使计算机通过网络启动。协议分为 client 和 server 两端，PXE client 在网卡的 ROM 中，当计算机引导时，BIOS 把 PXE client 调入内存执行，并显示出命令菜单，经用户选择后，PXE client 将放置在远端的操作系统通过网络下载到本地运行。 — 摘自 [IBM 中国](http://www-900.ibm.com/developerWorks/cn/linux/l-tip-prompt/l-pex/index.shtml#2)

In the mid-90's, Compaq, Dell, HP, Intel, and Microsoft jointly released a system design guide for building Net PC systems. The guide describes a method of booting the operating system from a network server. This method eventually became known as the Preboot Execution Environment (PXE). Several manufacturers have created implementations of the PXE specification, and include a PXE compliant BootROM on their network cards. Most computer motherboards with embedded network interfaces include PXE in the BIOS.

PXE is designed to load a small (32kb or less) image called a Network Bootstrap Program (NBP). The NBP is then responsible for loading the operating system image. When using PXE to boot an LTSP workstation, the choices for an NBP are PXELINUX and Etherboot. — 摘自 [LTSP](http://wiki.ltsp.org/twiki/bin/view/Ltsp/PXE#Introduction_to_PXE)

### PXE.USTC 有什么用处？

用途举例：

- 安装新系统 – 安装 Linux/Windows，但是电脑没有软驱/光驱，有没有 USB 启动功能；
- 修复老系统 – 电脑因为病毒/引导程序损坏等原因，无法启动了；
- 学习 Linux – 试用 GNU/Linux，跳过安装/配置门槛；
- Cluster – 快速部署和简单管理；
- 教学实验 – 在公共机房中创建 UNIX/C/C++/Java/Matlab 等的教学实验平台。

### PXE.USTC 提供了哪些系统/工具？

| linux                      | 一个 Debian GNU/Linux 系统，主要用于学习目的，目前只提供命令行界面                                                                                                                          |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| knoppix                    | 一个基于 Debian 的 LiveCD，主要用于桌面 如果您的网卡不被支持，可以试试 allnic，其中包含了所有网卡驱动，副作用是 initrd 加载会慢一些                                                         |
| debian/redhat/mandrake     | Debian/Fedora/Mandrake 网络安装程序                                                                                                                                                         |
| rip                        | Recovery Is Possible, 基于 Linux 的小型急救系统(http://www.tux.org/pub/people/kent-robotti/looplinux/rip/)                                                                                  |
| pxes                       | 一个微型的 Linux 终端系统(http://pxes.sourceforge.net/)                                                                                                                                     |
| stresslinux                | 用于对硬件系统进行高负荷性能及稳定性测试(http://www.stresslinux.org/)                                                                                                                       |
| mcafee/fprot/antivir/avast | 几个病毒检测程序，个人版，同时包含在 dosnet 的 N:盘上病毒库每月更新                                                                                                                         |
| freedos                    | FreeDOS, 兼容 MSDOS 的自由 DOS。不要试图在 FreeDOS 中安装 Windows                                                                                                                           |
| dos                        | 一个 8MB 的虚拟软盘，提供了很多工具                                                                                                                                                         |
| dosnet                     | 一个支持 TCP/IP 网络的 FreeDOS 虚拟软盘，它的 MSLAN 网络驱动器 N: 上的程序是 dos 的超集。如果它启动时无法自动加载网卡驱动，可以试试手动选择网卡列表中最后的 UNDIS/UNDIS3C 两种 PXE 网卡驱动 |

其中的很多系统工具有很大的危险性，在使用之前请仔细阅读它们的文档并小心操作。使用这些工具而造成的任何损害，均由使用者本人负全部责任。

各类系统工具的主要来源是:

- [Ultimate Boot CD](http://ubcd.sourceforge.net/index.html)，这里存有部分[本地文档](http://pxe.ustc.edu.cn/ubcd/index.html)。
  Ultimate Boot CD contains close to 100 tools that are extremely useful when setting up or maintaining a PC.

另外以下站点还有很多不错的软件资源：

- [UTILITIES FOR 16 BIT DOS](http://www.undercoverdesign.com/dosghost/dos/utildos.htm) [DOS 之家软件站](http://doshome.net/soft/)

dosnet 是由以下工具整合而成：

- [Bart's Network Boot Disk](http://www.nu2.nu/bootdisk/network/)
  A highly professional network boot disk for connecting to a network share on a Windows 9x/ME/NT4/2000/XP or Linux Samba machine.
  Modular design - based on [modboot](http://www.nu2.nu/bootdisk/modboot/) . This means you can customize the bootdisk yourself by adding only the modules you need.
- [Universal TCP/IP Network Bootdisk](http://www.netbootdisk.com/)
  A DOS bootdisk that provides TCP/IP networking support.
- Intel PXE PDK 2.0

### 享受 PXE.USTC 服务需要什么软硬件环境？

您的电脑最好内置有 PXE Boot Agent，并且已经[激活](https://lug.ustc.edu.cn/wiki/server/pxe/faq#如何激活我电脑中的_pxe_boot_agent)；没有现成支持的话，有[几种解决办法](https://lug.ustc.edu.cn/wiki/server/pxe/faq#我的电脑没有内置_pxe_boot_agent_我该怎么做)。
您所在的网段最好有能提供正确的 PXE 信息的 DHCP 服务器，以及可以通过 TFTP 数据包的网关；没有的话可以请管理员加以[设置](https://lug.ustc.edu.cn/wiki/server/pxe/faq#我们实验室有自己的网关和dhcp服务器_该如何设置以便子网内的计算机能够访问pxe服务)，或自己动手[把网络启动系统加入 GRUB/LILO 菜单](https://lug.ustc.edu.cn/wiki/server/pxe/faq#如何把某个_pxeustc_上的网络启动系统直接加入_grublilo_的启动菜单)。
如果您所在实验室用地址转换/伪装技术建立了自己的子网，则需要[配置](https://lug.ustc.edu.cn/wiki/server/pxe/faq#我们实验室有自己的网关和dhcp服务器_该如何设置以便子网内的计算机能够访问pxe服务)。

### 如何激活我电脑中的 PXE Boot Agent？

目前有不少主板内部已经集成了 PXE 启动代码，一般的判别准则是：集成了网卡芯片的主板通常都会在 BIOS 中包含 PXE Boot Agent。
很多主板内置了 PXE Boot Agent 但是没有激活它，激活标志通常是：在电脑启动自检后在屏幕上会出现 PXE 字样。
为了激活 PXE Boot Agent，需要修改一到两处 BIOS 设置。具体的方法各个主板不尽相同，一般需要检查如下两项：

- 把 Onboard LAN 和 Onboard LAN Boot ROM (或类似的选项)设为 Enabled。
- 把 LAN (或类似的设备)设成第一启动设备 （如果你的电脑在启动时显示 “Press XX to boot from LAN” 字样，则可省略这一步）

升技 NF7 系列主板的设置：

```
Integrated Peripherals->OnChip PCI Device->
        LAN Controller          [Enabled]
        - LAN Boot ROM          [Enabled]

Advanced BIOS Features->
        First Boot Device       [LAN]
```

微星 NEO 2 主板设置：

```
Integrated Peripherals->
        Onboard LAN             [Enabled]
        Load onboard LAN BIOS   [Enabled]

Boot Device Prioty:
        LAN
```

有些主板还包含更多的设置选项。比如 Intel Boot Agent 的 [激活](http://pxe.ustc.edu.cn/images/boot-device-pxe.gif) 及 [设定](http://pxe.ustc.edu.cn/images/intel-boot-agent-setup.gif)； Realtek Boot Agent 的[设定](http://pxe.ustc.edu.cn/images/realtek-boot-agent-setup.gif)。

## 高级用户

### 我的电脑没有内置 PXE Boot Agent，我该怎么做？

可以自己制作包含 PXE Boot Agent 的[启动软盘](https://lug.ustc.edu.cn/wiki/server/pxe/faq#如何制作_pxe_启动软盘)/[EEPROM](https://lug.ustc.edu.cn/wiki/server/pxe/faq#如何制作_pxe_eeprom)，也可以把它加入引导程序的[启动菜单](https://lug.ustc.edu.cn/wiki/server/pxe/faq#如何把_pxe_boot_agent_加入_grublilo_的启动菜单)。

### 如何制作 PXE 启动软盘？

1. 打开 [ROM-o-matic.net](http://rom-o-matic.net/) 网站
2. 单击 Etherboot 5.3.12 或以上的版本
3. 在 “1. Choose NIC/ROM type:” 中选择你的网卡类型
4. 单击网页第四项中的 “Get ROM” 按钮下载它帮你动态生成的启动文件
5. 插入一个空白软盘，运行网页第六项中提示的命令。(在 Windows 下的话就用 rawwrite 程序写软盘。)

### 如何制作 PXE EEPROM？

1. 打开 [ROM-o-matic.net](http://rom-o-matic.net/) 网站
2. 单击 Etherboot 5.3.12 或以上的版本
3. 在 “1. Choose NIC/ROM type:” 中选择你的网卡类型
4. 在 “2. Choose ROM output format:” 中选择 “Binary ROM Image(.zrom)”
5. 单击网页第四项中的 “Get ROM” 按钮下载它帮你动态生成的启动文件
6. 带上此文件前去步瑞祺二楼，那里有卖 EEPROM 的公司，让他们帮你把文件烧刻进 EEPROM。
7. 把做好的 EEPROM [插入网卡](http://pxe.ustc.edu.cn/images/8139_NIC_PXE.jpg)。

在做 EEPROM 之前请注意：

- 先做一张 PXE 启动软盘，确认[运行无误](http://pxe.ustc.edu.cn/images/etherboot-screen.gif)。
- 确保网卡的 PCI ID 与第三步中所选的类型相匹配，否则 BIOS 不会调用它(虽然它的软盘版本可以正确运行)。
- 有的网卡用的是 [28 pin EEPROM](http://pxe.ustc.edu.cn/images/8139_28pin_bootrom.jpg)， 有的是 [32 pin EEPROM](http://pxe.ustc.edu.cn/images/8139_32pin_bootrom.jpg)。

### 如何把 PXE Boot Agent 加入 GRUB/LILO 的启动菜单？

以我的系统为例：

1. 打开 [ROM-o-matic.net](http://rom-o-matic.net/) 网站
2. 单击 Etherboot 5.3.12 或较新的版本
3. 在 “1. Choose NIC/ROM type:” 中选择你的网卡类型
4. 在 “2. Choose ROM output format:” 中选择 “LILO/GRUB/SYSLINUX loadable kernel format (.zlilo)”
5. 单击网页第四项中的 “Get ROM” 按钮下载它帮你动态生成的启动文件
6. 将此文件放入 /boot 目录，并加入 GRUB 配置如下：

```
# cat>>/boot/grub/menu.lst<<EOF
title           etherboot
root            (hd0,2)
kernel          /boot/eb-5.3.12-forcedeth.zlilo
savedefault
boot
EOF
```

Windows 9x/XP/NT 用户需要下载安装 [WINGRUB](http://sourceforge.net/projects/grub4dos/) ，并阅读它提供的[文档](http://grub4dos.sourceforge.net/wingrub.html) 和[示例](http://grub4dos.sourceforge.net/wingrub_examples.html) 。 强烈推荐 [Linuxeden 的 GRUB 专区](http://grub.linuxeden.com/)，这里可以找到中文文档及最新版本。

### 如何把某个 PXE.USTC 上的网络启动系统直接加入 GRUB/LILO 的启动菜单？

以我的系统为例：

```
# aptitude install tftp
# mkdir /boot/knoppix ; cd /boot/knoppix
# tftp pxe.ustc.edu.cn
tftp> get /tftpboot/knoppix/vmlinuz /tftpboot/knoppix/miniroot.gz
tftp> quit
# cat>>/boot/grub/menu.lst<<EOF
title           KNOPPIX on NFS
root            (hd0,2)
kernel          /boot/knoppix/vmlinuz nfsdir=pxe.ustc.edu.cn:/pub/pub knoppix_dir=KNOPPIX501 \
                nodhcp lang=us ramdisk_size=100000 init=/etc/init apm=power-off nomce noeject quiet
initrd          /boot/knoppix/miniroot.gz
savedefault
boot
EOF
```

请把上面的(hd0,2)替换为您所使用的分区。

Windows 9x/XP/NT 用户需要下载安装 [GRUB4DOS](http://sourceforge.net/projects/grub4dos/) 。为了方便起见，我们做了一个可直接使用的 GRUB4DOS 启动包，用法如下：

1. 下载 [ftp://pxe.ustc.edu.cn/linux/GRUB4DOS/C/](ftp://pxe.ustc.edu.cn/linux/GRUB4DOS/C/)\* 到 C:\

2. 将如下一行拷贝到 C:\boot.ini 文件中去（一般是作为它的最后一行）：

   ```
   C:\GRLDR="GRUB for DOS"
   ```

3. 重启，在 Windows 启动菜单中选择 “GRUB for DOS”

此方法适用于 Windows XP/NT 操作系统, C:文件系统为 NTFS/FAT32 均可.
目前它包含了如下一些启动项目，欢迎使用：

- Debian GNU/Linux for Education
- Debian GNU/Linux for Education (Secure)
- KNOPPIX Live Linux-on-CD
- Debian Sarge Installer
- Mandrake Installer
- Redhat Fedora Core Installer
- Etherboot (for rtl8139)
- Etherboot (for nforce2)
- Etherboot (for via-rhine)
- memtest86+

### 如何直接把 Knoppix Live CD 的 iso 文件安装到本地硬盘？

下面的 linux 命令序列可以把 knoppix 3.7 安装到 /dev/hda2(空闲空间>700MB)：

```
# wget ftp://202.38.64.123/pub/linux/iso/Knoppix-3.7/KNOPPIX_V3.7-2004-12-08-EN.iso
# mkdir /mnt/knoppix-iso
# mount -o loop KNOPPIX_V3.7-2004-12-08-EN.iso /mnt/knoppix-iso
# mkdir /boot/knoppix
# cp /mnt/knoppix-iso/boot/isolinux/{linux26,minirt26.gz} /boot/knoppix/
# cp -a /mnt/knoppix-iso/KNOPPIX /
# umount /mnt/knoppix-iso
# rmdir /mnt/knoppix-iso
# cat>>/boot/grub/menu.lst<<EOF
title           Debian GNU/Linux, KNOPPIX 3.7
root            (hd0,1)
kernel          /boot/knoppix/linux26 ramdisk_size=100000 init=/etc/init fromhd=/dev/hda2
initrd          /boot/knoppix/minirt26.gz
savedefault
boot
EOF
```

上面的硬盘分区号 /dev/hda2 及 (hd0,1) 请调整为您实际使用的分区。
Windows 9x/XP/NT 用户需要下载安装 [WINGRUB](http://sourceforge.net/projects/grub4dos/) 。

## 管理员

### 出于管理的需要，我们机房希望只为内部网络提供受限的 PXE 服务，或加以密码保护

您有两种选择：

- 自己动手，设置网关、 DHCP、TFTP 服务器，提供自己的启动菜单。
- 申请网络中心为你们的 MAC 地址或 IP 地址提供特殊服务。

### 我们实验室有自己的网关和 DHCP 服务器，该如何设置以便子网内的计算机能够访问 PXE 服务？

需要做两个方面的设置：

- 网关: 允许 tftp 数据包顺利通过

  ```
  # modprobe ip_nat_tftp ip_conntrack_tftp
  ```

  可以在系统启动的时候自动加载这两个内核模块：

  ```
  # echo ip_nat_tftp >> /etc/modules
  # echo ip_conntrack_tftp >> /etc/modules
  ```

- DHCP 服务: 为 PXELinux/Etherboot 提供必要的信息
  以安装有 dhcp3-server 的 debian 系统为例：

  ```
  # cd /etc/dhcp3
  # wget http://pxe.ustc.edu.cn/dhcpd.pxe.conf
  # echo 'include "/etc/dhcp3/dhcpd.pxe.conf";' >> dhcpd.conf
  # /etc/init.d/dhcp3-server restart
  ```

  如果只有较老版本的 ISC DHCP Server，或者其他 DHCP 服务程序，则只需加入以下两项配置信息，一般情况下都不会有问题：

  ```
  next-server  pxe.ustc.edu.cn;
  filename     "pxelinux.0";
  ```

### 可以进一步建立自己的 TFTP 服务器，所需的文件可以从我们这里取得

```
# aptitude install tftpd-hpa
# mount pxe.ustc.edu.cn:/tftpboot /tftpboot
# cp /tftpboot/tftpd-hpa /etc/default
```

## 开发者

### PXE 的加载过程？

这里是 LTSP 的 [Booting with pxelinux.0](http://wiki.ltsp.org/twiki/bin/view/Ltsp/PXE#Booting_with_pxelinux_0)；

<!-- 下面是摘自IBM中国的图解：
[![img](https://lug.ustc.edu.cn/wiki/_media/server/pxe/pxe-boot-process.gif)](https://lug.ustc.edu.cn/wiki/_detail/server/pxe/pxe-boot-process.gif?id=server%3Apxe%3Afaq) -->

### 受限和密码保护的 PXE 菜单系统是如何实现的？

缺省的菜单系统是用 PXELinux 实现的，受限的菜单可以用定制的 PXELinux 菜单程序实现，而 MD5 加密的口令保护目前只有 pxegrub 能够支持。

1. 准备好 MD5 加密的口令

   ```
   # grub-md5-crypt
   Password:
   Retype password:
   $1$NcP8o0$DrDhZlUX36Rt6Yzl2RavM/
   ```

2. 准备好一个 menu.lst

   ```
   # cat /tftpboot/restricted/menu.lst
   password --md5 $1$NcP8o0$DrDhZlUX36Rt6Yzl2RavM/
   dhcp
   root (nd)
   color light-gray/blue black/light-gray
   title *=*=*=*=*=*=*=*=*=* Welcome to PXE.USTC *=*=*=*=*=*=*=*=*=*

   title linux
     kernel /tftpboot/linux/bzImage root=/dev/nfs nfsroot=202.38.73.198:/croot,rsize=8192,wsize=8192,tcp,flags=nolock,intr,v3 ip=dhcp
   title knoppix
     kernel /tftpboot/knoppix/vmlinuz nfsdir=202.38.73.198:/croot nodhcp lang=us ramdisk_size=100000 init=/etc/init apm=power-off nomce vga=791 quiet secure BOOT_IMAGE=knoppix
     initrd /tftpboot/knoppix/miniroot.gz
   title dos
     kernel /tftpboot/images/memdisk floppy c=8 s=32 h=64
     initrd=/tftpboot/images/dos.igz
     lock
   ```

3. 编译

   ```
   # ./configure --disable-auto-linux-mem-opt --enable-preset-menu=/tftpboot/restricted/menu.lst --enable-diskless --enable-via-rhine
   # make
   # cp netboot/pxegrub /tftpboot/restricted/pxegrub.0
   ```

遗憾的是 pxegrub 已经有些年没更新了，不支持包括 nForce 在内的一些新网卡。 另外还有更严重的[稳定性问题](http://wiki.ltsp.org/twiki/bin/view/Ltsp/PXE#PXEGRUB)，估计是至少某些网卡会存在这种问题。

### XXX 很不错，能不能把它也加入 PXE.USTC ？

只要版权没有问题，肯定是可以的。不过，请你务必提供直接可以网络启动的新系统，因为我们时间有限，将着重于维护现有的系统。
所提供的系统或者是一个可启动的软盘映像文件，或者是 kernel, initrd, 以及 pxelinux.cfg 配置文件。必要的话还可以给出 NFS-ROOT 系统。

### 如何把一张 Linux/BSD 的 Live CD 做成可网络启动？

可以参考 knoppix Live CD 中的 /usr/sbin/knoppix-terminal-server 脚本，以及它所创建出来的 initrd。
大体上需要对原有系统的 initrd 做如下两个修改：

1. 创建一个更大的 initrd，并将原 initrd 中的全部内容，以及各种网卡驱动内核模块、NFS 网络驱动模块、静态链接的 ifconfig/pump 等网络配置程序拷贝进去；
2. 修改其中 /linuxrc (或类似文件)， 把其中 mount cdrom 的命令改写为 mount nfs 的命令，并在这之前加入加载驱动模块，配置网络的命令。

对于 BSD 系统，其中的内核模块不妨交由 loader 来加载。

### 如何把一个安装在服务器硬盘上的 Linux 系统做成可网络启动？

可以仍然使用用 initrd：

- [LTSP](http://www.ltsp.org/) 项目提供了相关的支持工具；
- Etherboot 的 contrib/initrd 目录下包含的 mkinitrd-net 工具也可参考使用；
- Debian 还提供了工具包 initrd-netboot-tools (http://www.lessdisks.net/)。

或者可以直接使用 NFS-ROOT 方案。基本思路是：

- 服务端：

1. 在服务器上运行 NFS Server，把此系统所在目录共享；
2. 在此系统中放一个 tmpfs 的处理脚本，动态的在内存文件系统中加载 /etc, /var, /root, /home 目录。
   可参考 (NFS)pxe.ustc.edu.cn:/croot/etc/rcS.d/S03nfsboot.sh 脚本。

- 客户端：

1. 定制编译一个包含所有必要的网卡驱动，以及如下选项：

   ```
   # Networking options
   # Under "Device Drivers ---> Networking support ---> Networking options"

   #  Kernel level IP autoconfiguration
   CONFIG_IP_PNP=y
   #  DHCP support
   CONFIG_IP_PNP_DHCP=y

   # File systems
   # Under "File systems --> Pseudo filesystems"

   #  Virtual memory file system support
   CONFIG_TMPFS=y
   # #  /dev file system support
   # CONFIG_DEVFS_FS=y
   # # Automatically mount devfs at boot time
   # CONFIG_DEVFS_MOUNT=y

   # Network File Systems
   # Under "File systems --> Network File Systems"

   #  NFS file system support
   CONFIG_NFS_FS=y
   #  Provide NFSv3 client support
   CONFIG_NFS_V3=y
   #  Root file system on NFS
   CONFIG_ROOT_NFS=y
   ```

2. 启动此内核时使用参数：

   ```
   root=/dev/nfs nfsroot=202.38.73.198:/croot,rsize=8192,wsize=8192,tcp ip=dhcp
   ```

## 相关链接

Etherboot
Homepage
http://www.etherboot.org/
Wiki
http://wiki.etherboot.org/

Diskless Linux
http://frank.harvard.edu/~coldwell/diskless/
PXE Documentation Version 1.0
HOWTO setup a PXE 2.x server under Linux
http://clic.mandrakesoft.com/documentation/pxe/
Linux Boot
http://www.linux-boot.net/

基于 NFS*ROOT 的 [Gentoo Linux 的 PXE 安装方法](http://www.gentoo.org.tw/doc/altinstall.xml#doc_chap5)
Diskless Nodes with Gentoo
http://www.gentoo.org/doc/en/diskless-howto.xml
FreeBSD Diskless Clients
http://the-labs.com/FreeBSD/Diskless/
Network Booting i386 Unix Variants
http://www.munts.com/diskless/netboot.html
Booting FreeBSD via PXE
http://www.tnpi.biz/computing/freebsd/pxe-netboot.shtml
[Remote Network Boot via PXE](http://www.kegel.com/linux/pxe.html)
[Index of /tweaks/dhcp3](http://debian.jones.dk/tweaks/dhcp3/)
[如何远程安装 Linux](http://www-900.ibm.com/developerWorks/cn/linux/l-tip-prompt/l-pex/index.shtml)
[Diskless Linux](http://frank.harvard.edu/~coldwell/diskless/)
[Etherboot Wiki - Main.HomePage](http://wiki.etherboot.org/)
[PXE Documentation Version 1.0](http://clic.mandrakesoft.com/documentation/pxe/)
[Ultimate Boot CD - Overview](http://ubcd.sourceforge.net/index.html)
[Bootable CD Utilities by reanimatolog - Образы загрузочных дискет и жестких дисков](http://bootcd.narod.ru/images.htm)
[All-drivers Etherboot floppy & how to install etherboot to a hard disk](http://etherboot.anadex.de/)
[ROM-o-matic.net](http://rom-o-matic.net/)
[:: ThinStation - a light, full-featured thin client OS ::](http://thinstation.sourceforge.net/wiki/index.php/ThIndex)
[Index of /debian/dists/unstable/main/installer-i386/current/images/netboot](http://ftp.us.debian.org/debian/dists/unstable/main/installer-i386/current/images/netboot/)
[YAGI - [Deep Space DaN\]](http://dan.deam.org/yagi.php)
[Linux-Boot.net](http://www.linux-boot.net/InitRD/Howto/)
[Pollix LiveCD](http://moe.tnc.edu.tw/~kendrew/pollix/)
[Bart's Network Boot Disk](http://www.nu2.nu/bootdisk/network/)
[Universal TCP/IP Network Bootdisk for M\$ Networks](http://www.netbootdisk.com/download.htm)
[DOS and W31 utilities for MSDOS, DRDOS, FreeDOS, PCDOS, OpenDOS, and PTSDOS 16 bit DOS versions.](http://www.undercoverdesign.com/dosghost/dos/utildos.htm)
[Install GNU/Linux without any CD, floppy, USB-key, nor any other removable media](http://marc.herbert.free.fr/linux/win2linstall.html#grub-for-nt)
[Boosting the power of a DOS image](http://people.cs.uchicago.edu/~gmurali/gui/isodos.html)
[GRUB4DOS and WINGRUB Project Homepage](http://grub4dos.sourceforge.net/)
[UBCD for Windows](http://www.ubcd4win.com/downloads.htm)
[The Labs: FreeBSD Diskless](http://the-labs.com/FreeBSD/Diskless/)
[Gentoo Linux Documentation -- Diskless Nodes with Gentoo](http://www.gentoo.org/doc/en/diskless-howto.xml)
[Network Booting Unix Variants](http://www.munts.com/diskless/netboot.html)
[The Network People, Inc. - FreeBSD 5 PXE boot recipe](http://www.tnpi.biz/computing/freebsd/pxe-netboot.shtml)
[MorphixWiki! - Qemu](http://am.xs4all.nl/phpwiki/index.php/Qemu)
[Index of /qemu/utilities/QEMU-HD-Mounter](http://dad-answers.com/qemu/utilities/QEMU-HD-Mounter/)
[DistroWatch.com: clusterKNOPPIX](http://distrowatch.com/table.php?distribution=clusterknoppix)
[[Wolves\] using GNU Screen to join two terminals?](http://mailman.lug.org.uk/pipermail/wolves/2004-November/010482.html)
[Linuxeden 的 GRUB 专区 : 首页](http://grub.linuxeden.com/wakka.php?wakka=%CA%D7%D2%B3)
[ParallelKnoppix: Bootable CD to Create a Linux Cluster in 15 Minutes](http://pareto.uab.es/mcreel/ParallelKnoppix/)
[PXE 網路開機實作](http://cha.homeip.net/blog/archives/2006/08/pxe.html)*
