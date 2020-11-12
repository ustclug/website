---
---

# Raspbian 镜像使用帮助

此处内容可能已过时，最新版本的帮助参见：<https://mirrors.ustc.edu.cn/help/raspbian.html>

## Raspbian 简介

Raspbian 是专门用于 ARM 卡片式计算机 Raspberry Pi®“树莓派”的操作系统。

Raspberry Pi®“树莓派”是 2012 年问世的 ARM 计算机，旨在为儿童和所有的计算机爱好者提供一套廉价的编程学习与硬件 DIY 平台。树莓派基于 ARM，具有 1080P 高清视频解析能力，附带用于硬件开发的 GPIO 接口，使用 Linux 操作系统。售价仅$25~$35。

Raspbian 系统是 Debian 的定制版本。得益于 Debian 从 7.0/wheezy 开始引入的“带硬件浮点加速的 ARM 架构”(armhf)，Debian 7.0 在树莓派上的运行性能有了很大提升。Raspbian 默认使用 LXDE 桌面，内置 C 和 Python 编译器。

Raspbian 是树莓派的开发与维护机构 The Raspbeery Pi Foundation“树莓派基金会”，推荐用于树莓派的首选系统。

由于以下原因，Raspbian 单独组建了自己的软件源：

- Debian 下所有的软件包都需要用 armhf 重新编译。

- 树莓派有部分特有的软件包，例如 Python 的 GPIO 操作库。

- 树莓派用户倾向于探索、尝试最新的软件。这与 Debian 软件源的策略完全不同。

## 使用说明

编辑 `/etc/apt/sources.list` 文件。删除原文件所有内容，用以下内容取代：

    deb http://mirrors.ustc.edu.cn/raspbian/raspbian/ jessie main non-free contrib
    deb-src http://mirrors.ustc.edu.cn/raspbian/raspbian/ jessie main non-free contrib

编辑此文件后，请使用 `sudo apt-get update` 命令，更新软件列表。

## 系统架构

armhf(\*)

## 系统版本

- wheezy

- jessie

- stretch

(即，oldstable, stable, testing)

## 更新频率

每日更新 1 次。

## 声明

Raspbian 是由独立开发者维护的，与树莓派基金会并无直接联系。

## 相关链接

Raspbian 链接

- Raspbian 主页: <http://www.raspbian.org/>

- 文档: <http://www.raspbian.org/RaspbianDocumentation>

- Bug Tracker: <http://www.raspbian.org/RaspbianBugs>

- 镜像列表: <http://www.raspbian.org/RaspbianMirrors>

- Debian 首页: <http://www.debian.org/>

树莓派链接

- 树莓派基金会主页: <http://www.raspberrypi.org/>

- 树莓派基金会论坛 Raspbian 版块: <http://raspberrypi.org/phpBB3/viewforum.php?f=66>

## 关于本文档

本文档内容由 Raspberry Pi 中文社区“树莓爱好者论坛”提供，并经科大 LUG 改编。

按照知识共享署名-非商业性使用 3.0 中国大陆许可协议，授权中国大陆范围内的 Raspbian 镜像站参考使用。

版本 1.2.1
