---
title: "C/C++ 下 OpenMP 程序设计介绍"
author: "tiankaima"
header:
  image: https://ftp.lug.ustc.edu.cn/%E6%B4%BB%E5%8A%A8/2024.11.27_%E5%B0%8F%E8%81%9A/3.jpg
date: "2024-11-29 10:00:00 +0800"
categories:
  - LUG 活动
  - LUG 小聚
tags: []
---

2024 年 11 月 27 日，校学生 Linux 用户协会在西区第三教学楼 3A306 教室开展了小聚活动。本次小聚主要是由罗嘉宏同学带来的 C/C++ 下 OpenMP 程序设计介绍。[OpenMP](https://www.openmp.org/) 是广为运用的并行计算处理框架，为 C/C++ 和 Fortran 编程语言提供支持，提供了简单有效的 CPU 并行处理能力。此外，新版本的 OpenMP 还支持 GPU 计算等功能。

![](https://ftp.lug.ustc.edu.cn/%E6%B4%BB%E5%8A%A8/2024.11.27_%E5%B0%8F%E8%81%9A/2.jpg)

小聚过程中，罗嘉宏同学展示了由简单到复杂的一系列 OpenMP 代码示例（使用 C 语言编写），以此对 OpenMP 计算框架的基本用法作出解释说明。这些代码段覆盖了从最简单的 `parallel` 到原子操作等等的主题，并现场展示了运行结果。这使同学们对并行计算中出现的一些问题和相关的解决方式有了初步的认识，也为同学们今后可能会遇到的需要并行计算的问题提供了入门性的解决方式。

![](https://ftp.lug.ustc.edu.cn/%E6%B4%BB%E5%8A%A8/2024.11.27_%E5%B0%8F%E8%81%9A/4.jpg)

值得一提的是，本次小聚使用了 Lichee Pi 4A 作为现场演示设备。该设备上有 RISC-V64 架构的 4 个处理器核心。在活动过程中，该设备状态稳定，展示出了较高的 OpenMP 多线程并行效率。本次小聚使用的案例代码可以在 [LUG GitLab](https://git.lug.ustc.edu.cn/luojh/ompguide) 上获取。

![](https://ftp.lug.ustc.edu.cn/%E6%B4%BB%E5%8A%A8/2024.11.27_%E5%B0%8F%E8%81%9A/1.jpg)
