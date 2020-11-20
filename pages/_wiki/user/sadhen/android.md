---
---

# 使用 chroot 编译 android

请直接参考参考资料

## 安装 dchroot 和 debootstrap

    $ sudo aptitude install dchroot debootstrap

## 更改配置文件

    $ sudo tee -a /etc/schroot/schroot.conf <<EOF
    [lucid]
    description=Ubuntu 10.04 LTS (Lucid Lynx)
    location=/var/chroot/lucid
    priority=3
    users=pdecat
    groups=pdecat
    root-groups=root
    EOF

## 安装 Ubuntu10.04

    $ sudo debootstrap --variant=buildd --arch amd64 lucid /var/chroot/lucid http://mirrors.ustc.edu.cn/ubuntu/

## 参考资料

<http://blog.decat.org/aosp-step-by-step-instructions-for-setting-up-a-chrooted-ubuntu-10-04-64bit-build-environment-on-ubuntu-11-10-and-12-04-hosts/>  
[图书馆查询机系统的制作与启动过程](http://lug.ustc.edu.cn/~guo/doc/library_query_os.pdf "http://lug.ustc.edu.cn/~guo/doc/library_query_os.pdf")
