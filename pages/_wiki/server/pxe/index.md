---
permalink: /wiki/pxe/
---

# 中国科学技术大学网络启动服务

pxe.ustc.edu.cn 由中国科大图书馆、网络中心和学生 Linux 用户协会共同维护，旨在为科大校园网提供各种网络启动服务。现在支持引导 Debian、Ubuntu、Arch Linux、CentOS 等常见 Linux/UNIX 发行版安装镜像或 LiveCD，同时还提供 Clonezilla、GParted Live 等实用系统维护工具。

如果遇到使用问题，请邮件联系 lug AT ustc.edu.cn。

## 新版网络启动服务

基于 GRUB 的新版网络启动服务支持**传统 PXE 模式**和**UEFI 模式**的网络启动。代码位于 https://github.com/ustclug/simple-pxe

校内 DHCP 服务会自动推送网络启动配置，只要在 BIOS 设置中开启网络启动就可以了。

### 从本地 GRUB2 加载（UEFI）

如果您的机器是 UEFI 模式启动的、UEFI 固件带有网络支持，并已经安装有 GRUB2，则可以在 GRUB 命令行中直接加载网络启动菜单：

``` 
insmod efinet http
net_bootp
configfile (http,202.38.93.94)/boot2/menu/root.menu
```

也可以制作一个 EFI 可执行文件，放在U盘中方便部署。在 Linux 系统中，把前面的命令行保存到文件 `grub.cfg` ，然后运行命令：

``` shell
grub-mkstandalone --compress=xz -O x86_64-efi --locales= --fonts= --themes= -o grub.efi "boot/grub/grub.cfg=./grub.cfg"
```

生成的 `grub.efi` 文件就可以在 UEFI shell 中直接运行，或者放到 FAT 格式的U盘中的 `/EFI/BOOT/bootx64.efi` 路径，使 UEFI 固件自动加载它。

还可以接着用下面命令制作一个 FAT 软盘镜像，有些服务器的 IPMI 支持远程加载软盘镜像，这样就可以方便地远程维护服务器了：

``` shell
truncate -s 1474560 floppy.img
mformat -f 1440 :: -i floppy.img
mmd '::/EFI' '::/EFI/BOOT' -i floppy.img
mcopy grub.efi '::/EFI/BOOT/bootx64.efi' -i floppy.img
```

### 从 iPXE 加载（传统 PXE）

用 [iPXE](https://ipxe.org/) 脚本或者命令行模式执行以下命令：

``` 
dhcp
set 210:string http://202.38.93.94/boot/tftp/
chain ${210:string}pxelinux.0
```

## 旧版网络启动服务

旧版网络启动服务是吴峰光校友在 2001-2005 年创建的，基于 SYSLINUX。

仅支持传统 PXE 启动，现在已不再更新。

``` 
dhcp //如果已经获取到了地址则请忽略
set 210:string http://202.38.93.94/boot/tftp/ 
chain ${210:string}lpxelinux.0
```
