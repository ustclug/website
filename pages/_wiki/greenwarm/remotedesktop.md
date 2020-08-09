---
---

# 认识Linux远程桌面控制

X window比MS windows先进的地方是, X window是个基于网络的的图形视窗系统, 本身就具有远程控制的强大功能. 用户在远程系统上登录执行X 应用程序, 并将Xclients执行的结果传回本地主机. 这就是我下面要介绍的Remote X. 

这里我要说的不是telnet, rsh之类的远程控制工具, 而是指远程控制桌面应用. 

X window比MS windows先进的地方是, X window是个基于网络的的图形视窗系统, 本身就具有远程控制的强大功能. 用户在远程系统上登录执行X 应用程序, 并将Xclients执行的结果传回本地主机. 这就是我下面要介绍的Remote X 

## 一、Remote X

假设本地主机ip为172.16.1.1, 远程的主机ip为172.16.1.2 

第一步, 在本地主机上的任意一个xterm中执行xhost, 用来允许远程的其它主机可以和本地主机的X server联网: 

    
    
    　　xhost + 172.16.1.2

如果不指定任何ip地址, 则表示权限完全放开, 这会带来安全问题, 要小心! 

第二步, 确认本地主机的xfs是运行的. 用ps检查一下进程. 

第三步, 从本地主机(172.16.1.1)上通过网络登录到远程主机172.16.1.2上, 你用telnet, ssh, rsh都可以. 设置DISPLAY变量. 

    
    
    　　export DISPLAY=172.16.1.1:0

第四步, 现在可以使用远程主机上的X 应用程序了. 

这么样, 很方便吧, 但是你还不能掌控整个桌面环境, 这个工作就交给vnc吧! Remote X 在局域网上运行效果很不错, 普通的电话拨号就不用试了, 速度太慢了。 

## 二、vnc

我相信有不少人在windows环境用过pcanywhere, 但你想不想用一个免费的, 可以在linux, win9x/nt上都可以使用的pcanywhere, 这就是vnc. 

vnc就是vitual network computing的缩写, 它支持许多操作平台, 甚至可在浏览器中操作. 

我主要介绍vncviewer的用法, 以及用linux远程控制linux或nt. 

vnc client通过架构在tcp/ip上的vnc协议与vnc server沟通, 通过认证后, 把X server的桌面环境, 输入设备, 和X 资源交给vncserver掌控, vnc server将桌面环境通过vnc 协议送给vnc client端. 让vnc client来操纵vnc server桌面环境和输入设备. 

首先下载到vnc的linux版本和windows版本. 

当前的linux版本是vnc-3.3.3r1 _x86_ linux_2.0.tgz 

当前的windows版本是vnc-3.3.3r7 _x86_ win32.zip 

### 1. 安装linux版的vnc

(1)安装 

    
    
    　　tar zxvf vnc-3.3.3r1_x86_linux_2.0.tgz
    
    　　cd vnc_x86_linux_2.0
    
    　　cp *vnc* /usr/local/bin/
    
    　　mkdir /usr/local/vnc
    
    　　cp -r classes/ /usr/local/vnc/

(2)设置vnc server的访问密码 

    
    
    　　vncpasswd

(3)启动vnc server 

    
    
    　　vncserver

注意运行后显示的信息, 记下所用的端口号, 一般从1开始, 因为0被x server占用了. 现在, 你就能提供vnc服务了.vnc client的用法等会介绍. 

### 2、安装nt版的vnc

1)安装 

解开vnc-3.3.3r7 _x86_ win32.zip包后, 会产生winvnc和vncviewer两个目录.winvnc目录中是vnc server的安装程序, vncviewer目录中是vnc client的安装序. 我只关心vnc server, 在winvnc目录中执行setup即可. 

2)设置 

首先执行install default registry settings. 

run winvnc(app mode)就是执行vnc server 

这时可看到winvnc运行的小图标, 用鼠标右键点击图标, 在properties/incoming connections中设定密码. 默认配置即可. 

现在, 你的nt就能提供vnc服务了. 

### 3、使用vncviewer

vnc server启动成功后, 你就可用vncviewer来远程控制桌面了. 

vncviewer xxx.xxx.xxx.xxx:display number 

例如, vncviewer 172.16.1.2:1 

按要求输入密码就可以看到远程的桌面了. 

注意:viewers需要在16位色的显示模式下工作，如果您的操作系统中没上16位色，那么请您及时的调整您计算机的显示模式。不然vncviewer无法正常工作。 

### 4、linux版vnc server的改进.

linux上的vnc server内定的桌面管理环境是twm, 实在是太简陋了. 

修改$HOME/.vnc/xstartup这个文件. 

把所有内容的行前加上#, 再在接尾部份加上: 

startkde &

你当然可用你喜好的桌面代替. 我这是用kde来代替twm, 速度会慢少少, 但用起来方便不少. 

注意要重新启动vnc server. 

### 5、通过浏览器使用vnc

通过浏览器使用vnc, 要注意端口号的变化. 

假设vnc server是172.16.1.2:1的话, 那么, 可用浏览器访问[http://172.16.1.2:5801](http://172.16.1.2:5801/ "http://172.16.1.2:5801")

端口号=display number + 5800 

好了, 心动不如行动, just do it ! 
