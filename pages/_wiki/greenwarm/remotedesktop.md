---
---

# 认识 Linux 远程桌面控制

X window 比 MS windows 先进的地方是, X window 是个基于网络的的图形视窗系统, 本身就具有远程控制的强大功能. 用户在远程系统上登录执行 X 应用程序, 并将 Xclients 执行的结果传回本地主机. 这就是我下面要介绍的 Remote X.

这里我要说的不是 telnet, rsh 之类的远程控制工具, 而是指远程控制桌面应用.

X window 比 MS windows 先进的地方是, X window 是个基于网络的的图形视窗系统, 本身就具有远程控制的强大功能. 用户在远程系统上登录执行 X 应用程序, 并将 Xclients 执行的结果传回本地主机. 这就是我下面要介绍的 Remote X

## 一、Remote X

假设本地主机 ip 为 172.16.1.1, 远程的主机 ip 为 172.16.1.2

第一步, 在本地主机上的任意一个 xterm 中执行 xhost, 用来允许远程的其它主机可以和本地主机的 X server 联网:

    　　xhost + 172.16.1.2

如果不指定任何 ip 地址, 则表示权限完全放开, 这会带来安全问题, 要小心!

第二步, 确认本地主机的 xfs 是运行的. 用 ps 检查一下进程.

第三步, 从本地主机(172.16.1.1)上通过网络登录到远程主机 172.16.1.2 上, 你用 telnet, ssh, rsh 都可以. 设置 DISPLAY 变量.

    　　export DISPLAY=172.16.1.1:0

第四步, 现在可以使用远程主机上的 X 应用程序了.

这么样, 很方便吧, 但是你还不能掌控整个桌面环境, 这个工作就交给 vnc 吧! Remote X 在局域网上运行效果很不错, 普通的电话拨号就不用试了, 速度太慢了。

## 二、vnc

我相信有不少人在 windows 环境用过 pcanywhere, 但你想不想用一个免费的, 可以在 linux, win9x/nt 上都可以使用的 pcanywhere, 这就是 vnc.

vnc 就是 vitual network computing 的缩写, 它支持许多操作平台, 甚至可在浏览器中操作.

我主要介绍 vncviewer 的用法, 以及用 linux 远程控制 linux 或 nt.

vnc client 通过架构在 tcp/ip 上的 vnc 协议与 vnc server 沟通, 通过认证后, 把 X server 的桌面环境, 输入设备, 和 X 资源交给 vncserver 掌控, vnc server 将桌面环境通过 vnc 协议送给 vnc client 端. 让 vnc client 来操纵 vnc server 桌面环境和输入设备.

首先下载到 vnc 的 linux 版本和 windows 版本.

当前的 linux 版本是 vnc-3.3.3r1 _x86_ linux_2.0.tgz

当前的 windows 版本是 vnc-3.3.3r7 _x86_ win32.zip

### 1. 安装 linux 版的 vnc

(1)安装

    　　tar zxvf vnc-3.3.3r1_x86_linux_2.0.tgz

    　　cd vnc_x86_linux_2.0

    　　cp *vnc* /usr/local/bin/

    　　mkdir /usr/local/vnc

    　　cp -r classes/ /usr/local/vnc/

(2)设置 vnc server 的访问密码

    　　vncpasswd

(3)启动 vnc server

    　　vncserver

注意运行后显示的信息, 记下所用的端口号, 一般从 1 开始, 因为 0 被 x server 占用了. 现在, 你就能提供 vnc 服务了.vnc client 的用法等会介绍.

### 2、安装 nt 版的 vnc

1)安装

解开 vnc-3.3.3r7 _x86_ win32.zip 包后, 会产生 winvnc 和 vncviewer 两个目录.winvnc 目录中是 vnc server 的安装程序, vncviewer 目录中是 vnc client 的安装序. 我只关心 vnc server, 在 winvnc 目录中执行 setup 即可.

2)设置

首先执行 install default registry settings.

run winvnc(app mode)就是执行 vnc server

这时可看到 winvnc 运行的小图标, 用鼠标右键点击图标, 在 properties/incoming connections 中设定密码. 默认配置即可.

现在, 你的 nt 就能提供 vnc 服务了.

### 3、使用 vncviewer

vnc server 启动成功后, 你就可用 vncviewer 来远程控制桌面了.

vncviewer xxx.xxx.xxx.xxx:display number

例如, vncviewer 172.16.1.2:1

按要求输入密码就可以看到远程的桌面了.

注意:viewers 需要在 16 位色的显示模式下工作，如果您的操作系统中没上 16 位色，那么请您及时的调整您计算机的显示模式。不然 vncviewer 无法正常工作。

### 4、linux 版 vnc server 的改进.

linux 上的 vnc server 内定的桌面管理环境是 twm, 实在是太简陋了.

修改\$HOME/.vnc/xstartup 这个文件.

把所有内容的行前加上#, 再在接尾部份加上:

startkde &

你当然可用你喜好的桌面代替. 我这是用 kde 来代替 twm, 速度会慢少少, 但用起来方便不少.

注意要重新启动 vnc server.

### 5、通过浏览器使用 vnc

通过浏览器使用 vnc, 要注意端口号的变化.

假设 vnc server 是 172.16.1.2:1 的话, 那么, 可用浏览器访问[http://172.16.1.2:5801](http://172.16.1.2:5801/ "http://172.16.1.2:5801")

端口号=display number + 5800

好了, 心动不如行动, just do it !
