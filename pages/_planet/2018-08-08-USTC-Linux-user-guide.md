---
title: "USTC Linux 用户生存指南"
author: mk
categories:
  - Experience
tags:
  - Courses
---

本指南指导中科大 Linux 用户如何使用 Linux 完成各门课程。

**注意：本指南目前仅包含部分计算机专业本科课程。**欢迎其他同学贡献更多内容！

## 程序设计

程序设计课程主要讲授 C 语言知识，而 C 语言本身就是用来 UNIX 的原生语言，所以不会有任何障碍。

建议使用 GCC 或 Clang 作为编译器，使用 GDB 作为调试器。可以选用任意一款文本编辑器（Vim、Emacs、Sublime、Atom、VSCode、gedit、Kate 等）或集成开发环境（如 CLion、Geany、KDevelop）。

兼容性：★★★★★

## 数据结构

主要讲授数据结构及其 C 语言实现。和程序设计一样没有任何问题。

课本（严蔚敏版数据结构）分光盘版和无盘版。光盘内容为算法和数据结构的演示程序，仅支持 MS-DOS 和 Windows，其功能可完全由 VisuAlgo 替代。所以建议购买无盘版。

兼容性：★★★★★

## 模拟与数字电路

旧开发板：Digilent Nexys 2 和 3 均有 Linux 工具，Xilinx ISE 也有 Linux 版本。笔者经验是 Xilinx ISE 可以正常使用。

新开发板：Xilinx Vivado 有 Linux 版本。新开发板唯烧录器只有 Windows 版本。解决方案：安装 Windows 虚拟机或在实验室电脑上烧录。

注：除了烧录 FPGA，可以完全使用自由软件替代。仿真可以使用 Icarus Verilog 和 GTKWave。

兼容性：★★★☆☆

## 计算机系统概论（H）

LC3 Tools 提供 Linux 版本。作业和 Lab 只需提交 PDF 版本。教学资源、课程要求见课本官网或课程官网：http://acsa.ustc.edu.cn/ics/。

唯一的缺憾是 Linux 版本的模拟器不支持中断，会导致最后一次实验遇到困难。

兼容性：★★★★☆

## 计算机组成原理

实验主要为仿真，FPGA 开发板使用较少。部分仿真实验使用 Xilinx ISE 较为方便。最后的大作业可选烧录到 FPGA 上。

注意，本课程可能必须使用 Xilinx ISE 进行仿真，因为只有 ISE 支持以直观方式查看「内存」的内容。

兼容性：★★★☆☆

## 操作系统原理与设计

操作系统课不可能绕过 Linux！就算是 Windows 用户也会被迫安装 Linux 虚拟机。所以 Linux 用户不会遇到任何问题。

兼容性：★★★★★

## 编译原理与技术

本课程会大量使用开源/自由软件，如 Flex、Bison、ANTLR、LLVM 等。作为 Linux 用户，当然 Feel at home~

兼容性：★★★★★

## 计算机网络

使用 Wireshark，支持 Linux。

兼容性：★★★★★

## 微机原理与系统

需要用到 MASM。大概使用 DOSBox 就能应付（？）

兼容性：★★★☆☆

## 算法基础

和数据结构差不多，写一些与平台无关的算法代码。

兼容性：★★★★★

## 数据库系统及应用

PowerDesigner?! 看起来只能 Wine / 虚拟机 了。

兼容性：★★☆☆☆

## 人工智能基础

实验与操作系统关系不是很大~

兼容性：★★★★★

## 计算机体系结构

写模拟程序，可以使用任何语言，所以问题不大。

兼容性：★★★★★
