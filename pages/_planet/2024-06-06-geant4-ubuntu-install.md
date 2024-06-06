---
title: "关于 Ubuntu 系统中 Geant4 软件包的安装指导"
author: "zyh1206"
categories: [Tech Tutorial]
tags: [Geant4]
---

本文用于分享本人在使用 Ubuntu 系统参与科研工作时，安装 geant4 软件包的经历，希望可以为新学习者提供帮助，更好的入手专业软件的学习与应用。

## 安装 Geant4

首先确保自己有例如 VMware 一类的虚拟机软件，并且确保自己已经成功安装了 Ubuntu 系统，如果没有可以在 <https://cn.ubuntu.com/download> 中下载安装。

1. 进入 Ubuntu 系统，登陆后在桌面上进入终端，修改 apt 源

   ```bash
   sudo sed -i 's/cn.archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list
   ```

   进行更新

   ```bash
   sudo apt update
   ```

   安装工具并重启，便于今后的科研任务

   ```bash
   sudo apt install open-vm-tools-desktop -y
   sudo reboot
   ```

2. 下载并安装
   geant4 的资源可以在 <https://geant4.web.cern.ch/download/11.2.1.html> 中下载得到，如果工具正常安装，可以将 Windows 文件转移到虚拟机中

   1. 转移文件

      ```bash
      sudo mv geant4/ /opt/
      cd /opt/geant4/file/
      ```

   2. 解压 geant4

      ```bash
      sudo mv /opt/geant4/file/geant4-v11.0.0.tar.gz ..
      cd ..
      sudo tar -zxvf geant4.tar.gz
      ```

   3. 安装依赖工具

      ```bash
      sudo apt install curl g++ libgl1-mesa-dev cmake libx11-dev libxext-dev libxtst-dev libxrender-dev libxmu-dev  libxmuu-dev libhdf5-serial-dev hdf5-tools libexpat1 libexpat1-dev build-essential -y
      sudo apt install qt5* -y
      ```

   4. 进一步修改设置

      ```bash
      mkdir geant4-build
      mkdir geant4-install
      cd geant4-build

      sudo cmake -DCMAKE_INSTALL_PREFIX=/opt/geant4/geant4-install \
        -DGEANT4_USE_OPENGL_X11=ON \
        -DGEANT4_USE_RAYTRACER_X11=ON \
        -DGEANT4_USE_QT=ON \
        GEANT4_BUILD_MULTITHREADED=ON \
        /opt/geant4/geant4
      ```

   5. 正式安装 geant4

      ```bash
      sudo make install -j8
      ```

   6. 设置环境

      ```bash
      sudo gedit ~/.bashrc
      ```

   打开文件后在最后一行输入

   ```bash
   source /opt/geant4/geant4-install/bin/geant4.sh
   ```

3. 初始化 geant4 的数据包

   ```bash
   cd /opt/geant4/geant4-install/bin
   sudo ./geant4-config --install-datasets
   cd /opt/geant4/file/
   ```

   考虑网络因素，正式开始下载后按下 `Ctrl` + `C` 的按键，终止下载，因为很慢
   并且提前在 Windows 中下载数据包 Datasets，同样位于 <https://geant4.web.cern.ch/download/11.2.1.html>。

4. 转移并安装。移动数据包到安装目录下

   ```bash
   sudo mv G4*.tar.gz /opt/geant4/geant4-install/share/Geant4/data
   ```

   并执行

   ```bash
   cd /opt/geant4/geant4-install/share/Geant4-11.0.0/data
   sudo ls *.tar.gz | sudo xargs -n1 tar xzvf
   ```

   最后删除数据包

   ```bash
   sudo rm -rf G4*.tar.gz
   ```

以上便是简单的 geant4 的安装流程，geant4 是由欧洲核子研究组织基于 C++ 面向对象技术开发的蒙特卡罗应用软件包，用于模拟粒子在物质中输运的物理过程。
希望以上作为一名初学者的经历对新入门的同学可以起到帮助。
