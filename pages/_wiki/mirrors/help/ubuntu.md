---
---

# Ubuntu 镜像使用帮助

## 收录架构

ALL

## 收录版本

所有 Ubuntu 当前支持的版本，包括开发版，具体版本见 <https://wiki.ubuntu.com/Releases>

对于 Ubuntu 不再支持的版本，请参考 [Ubuntu Old Release](ubuntu-old-release "mirrors:help:ubuntu-old-release")，<https://mirrors.ustc.edu.cn/ubuntu-old-releases/>

## 使用说明

### 软件包管理中心（推荐）

在软件包管理中心“软件源”中选择“中国的服务器”下 mirrors.ustc.edu.cn 即可自动使用。

### 手动更改配置文件

操作前请做好相应备份

一般情况下，更改 /etc/apt/sources.list 文件中 Ubuntu 默认的源地址 <http://archive.ubuntu.com/> 为 [http://mirrors.ustc.edu.cn](http://mirrors.ustc.edu.cn/ "http://mirrors.ustc.edu.cn") 即可。

可以使用如下命令：

    sudo sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

当然直接编辑 /etc/apt/sources.list 文件（需要使用 sudo）也可以，以 Ubuntu 16.04 为例，在文件最前面添加以下条目：

[sources.list](/wiki/_export/code/mirrors/help/sources435f-4.list?codeblock=0 "下载片段")

    # 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
    deb https://mirrors.ustc.edu.cn/ubuntu/ xenial main restricted universe multiverse
    # deb-src https://mirrors.ustc.edu.cn/ubuntu/ xenial main main restricted universe multiverse
    deb https://mirrors.ustc.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse
    # deb-src https://mirrors.ustc.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse
    deb https://mirrors.ustc.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
    # deb-src https://mirrors.ustc.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
    deb https://mirrors.ustc.edu.cn/ubuntu/ xenial-security main restricted universe multiverse
    # deb-src https://mirrors.ustc.edu.cn/ubuntu/ xenial-security main restricted universe multiverse
     
    # 预发布软件源，不建议启用
    # deb https://mirrors.ustc.edu.cn/ubuntu/ xenial-proposed main restricted universe multiverse
    # deb-src https://mirrors.ustc.edu.cn/ubuntu/ xenial-proposed main restricted universe multiverse

另外，也可以 snullp 大叔开发的 **[配置生成器](https://mirrors.ustc.edu.cn/repogen/ "https://mirrors.ustc.edu.cn/repogen/")**

## 相关链接

官方主页: <https://ubuntu.com/>  
文档: <https://help.ubuntu.com/>  
Wiki: <https://wiki.ubuntu.com/>  
提问：<https://askubuntu.com/>  
邮件列表: <https://ubuntu.com/support/community/mailinglists>  
论坛: <https://ubuntuforums.org/>  
中文论坛: <https://forum.ubuntu.org.cn/>
