---
redirect_from: /wiki/server/pxe/
---

# 网络启动服务

中国科学技术大学自 2005 年起，由 USTC LUG 发起，中国科大图书馆、网络中心和 LUG 共同维护，开始对校园网内提供网络启动服务（以下简称 PXE 服务）。校园网内的师生可以设置电脑通过网络引导启动，进行安装 Linux、体验 Linux、维护本机系统等操作，此外，东、西区图书馆的查询机系统亦是通过 PXE 启动引导。PXE 服务为校内师生带来了极大的便利。

随着我校网络设施的不断升级和发展，网络应用在科研工作和日常生活中发挥着日益重要的作用。同时，PXE 相关的技术在这些年中也有了很大的发展，可以为大家提供更多更实用的服务。现在支持引导 Debian、Ubuntu、Arch Linux、CentOS 等常见 Linux/UNIX 发行版安装镜像或 LiveCD，同时还提供 Clonezilla、GParted Live 等实用系统维护工具。

[技术文档](https://docs.ustclug.org/services/pxe/)

~~[中国科学技术大学校园网 PXE 服务 FAQ](pxe-faq.md)~~ 过时信息，仅供参考。

[Planet: 一根网线安装 Linux——PXE 介绍](/planet/2018/10/PXE-intro/)

如果遇到使用问题，请邮件联系 lug AT ustc.edu.cn。

## 新版网络启动服务

基于 GRUB 的新版网络启动服务支持**传统 PXE 模式**和 **UEFI 模式**的网络启动。代码位于 <https://github.com/ustclug/simple-pxe>

校内 DHCP 服务会自动推送网络启动配置，只要在 BIOS 设置中开启网络启动就可以了。

**<i class="fas fa-exclamation-triangle"></i> 注意：**UEFI 模式网络启动不支持安全启动（Secure Boot），需要先行在 UEFI 配置中关闭。
{: .notice--warning }

### 从本地 GRUB2 加载（UEFI）

如果您的机器是 UEFI 模式启动的、UEFI 固件带有网络支持，并已经安装有 GRUB2，则可以在 GRUB 命令行中直接加载网络启动菜单：

```shell
insmod efinet http
net_bootp
configfile (http,202.38.93.94)/boot2/menu/root.menu
```

也可以制作一个 EFI 可执行文件，放在 U 盘中方便部署。在 Linux 系统中，把前面的命令行保存到文件 `grub.cfg` ，然后运行命令：

```shell
grub-mkstandalone --compress=xz -O x86_64-efi --locales= --fonts= --themes= -o grub.efi "boot/grub/grub.cfg=./grub.cfg"
```

生成的 `grub.efi` 文件就可以在 UEFI shell 中直接运行，或者放到 FAT 格式的 U 盘中的 `/EFI/BOOT/bootx64.efi` 路径，使 UEFI 固件自动加载它。

还可以接着用下面命令制作一个 FAT 软盘镜像，有些服务器的 IPMI 支持远程加载软盘镜像，这样就可以方便地远程维护服务器了：

```shell
truncate -s 1474560 floppy.img
mformat -f 1440 :: -i floppy.img
mmd '::/EFI' '::/EFI/BOOT' -i floppy.img
mcopy grub.efi '::/EFI/BOOT/bootx64.efi' -i floppy.img
```

### 从 iPXE 加载（传统 PXE）

用 [iPXE](https://ipxe.org/) 脚本或者命令行模式执行以下命令：

```shell
dhcp
set 210:string http://202.38.93.94/boot/tftp/
# 如果是传统 BIOS 启动，执行以下命令：
chain ${210:string}pxelinux.0
# 否则执行以下命令：
chain ${210:string}bootx64.efi
```

也可以使用我们提供的[打包了 iPXE 脚本的 ISO](https://ftp.lug.ustc.edu.cn/PXE/image/ustc.ipxe.iso)，脚本中会自动判断当前的启动方式，并且执行对应的链式启动镜像。

## 旧版网络启动服务

旧版网络启动服务是吴峰光校友在 2001-2005 年创建的，基于 SYSLINUX。

仅支持传统 PXE 启动，现在已不再更新。

```shell
dhcp //如果已经获取到了地址则请忽略
set 210:string http://202.38.93.94/boot/tftp/
chain ${210:string}lpxelinux.0
```
