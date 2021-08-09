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

mk (16 级):

程序设计课程主要讲授 C 语言知识，而 C 语言本身就是用来 UNIX 的原生语言，所以不会有任何障碍。

建议使用 GCC 或 Clang 作为编译器，使用 GDB 作为调试器。可以选用任意一款文本编辑器（Vim、Emacs、Sublime、Atom、VSCode、gedit、Kate 等）或集成开发环境（如 CLion、Geany、KDevelop）。

兼容性：★★★★★

## 数据结构

mk (16 级):

主要讲授数据结构及其 C 语言实现。和程序设计一样没有任何问题。

课本（严蔚敏版数据结构）分光盘版和无盘版。光盘内容为算法和数据结构的演示程序，仅支持 MS-DOS 和 Windows，其功能可完全由 VisuAlgo 替代。所以建议购买无盘版。

taoky (17 级):

补充一点，如果真的要跑光盘的话，用 wine 和 DOSBOX 可以顺利执行。

兼容性：★★★★★

## 模拟与数字电路实验

mk (16 级):

旧开发板：Digilent Nexys 2 和 3 均有 Linux 工具，Xilinx ISE 也有 Linux 版本。笔者经验是 Xilinx ISE 可以正常使用。

新开发板(Digilent Nexys 4 DDR)：Xilinx Vivado 有 Linux 版本。可模拟，综合，实现，烧录。（含串口通讯等 exe 文件的实验可能无法正常开展）

注：除了烧录 FPGA，可以完全使用自由软件替代。仿真可以使用 Icarus Verilog 和 GTKWave。

兼容性：★★★☆☆

taoky (17 级):

我们这一届开始全面用新的开发板 (Nexys 4 DDR)，实验可以完整在 Linux 上完成。（没有见到上面说的串口通讯实验）

兼容性：★★★★★

## 计算机系统概论（H）

mk (16 级):

LC3 Tools 提供 Linux 版本。作业和 Lab 只需提交 PDF 版本。教学资源、课程要求见课本官网或课程官网：http://acsa.ustc.edu.cn/ics/。

[LC3 Tools 二进制文件(.AppImage)](https://github.com/chiragsakhuja/lc3tools/releases)

taoky (17 级):

LC3 Tools Linux version 没有中断的支持。不过我们这一届没有出这个实验。

兼容性：★★★★☆

## 计算机组成原理

mk (16 级):

实验主要为仿真，FPGA 开发板使用较少。部分仿真实验使用 Xilinx ISE 较为方便。最后的大作业可选烧录到 FPGA 上。

注意，本课程可能必须使用 Xilinx ISE 进行仿真，因为只有 ISE 支持以直观方式查看「内存」的内容。

兼容性：★★★☆☆

taoky (17 级):

和数电实验一样。而且我觉得搞 MIPS/RISC-V 的 toolchain Linux 更方便。

兼容性：★★★★★

## 操作系统原理与设计

mk (16 级):

操作系统课不可能绕过 Linux！就算是 Windows 用户也会被迫安装 Linux 虚拟机。所以 Linux 用户不会遇到任何问题。

兼容性：★★★★★

## 编译原理与技术

mk (16 级):

本课程会大量使用开源/自由软件，如 Flex、Bison、ANTLR、LLVM 等。作为 Linux 用户，当然 Feel at home~

兼容性：★★★★★

## 计算机网络

mk (16 级):

使用 Wireshark，支持 Linux。

tky (17 级):

不同班级的实验会不一样，但是基本上都需要使用 Wireshark。有些实验会有 socket 编程相关的内容，兼容性上没有问题。

兼容性：★★★★★

## 微机原理与系统

mk (16 级):

需要用到 MASM。大概使用 DOSBox 就能应付（？）

tky (17 级):

我记得我做微机原理实验的时候，开了个 Windows XP 的 VM，毕竟实模式的 DOS 还是有点麻烦的，如果处理不好，每次都要重开 DOSBOX。而 XP 的好处是可以用 NTVDM 直接跑 MASM，并且大部分实验中编译得到的 .com 文件也可以直接跑，只有少部分实验不得不开 DOSBox。

另一个麻烦的东西是 Emu8086。没有测试过它能不能用 wine 跑起来（感觉应该可以）。

相比于其他依赖 Windows 的实验来说，微机原理比较好的一点是，可以直接开个非常轻量的 Windows XP 虚拟机完成所有实验。不过这门课现在变成选修了。

BTW: 有同学问如何让 DOSBox 在 Linux 下在当前终端处理输入输出。如果有这样的需求（比如说你在用 VSCode Remote 连到某台机器上做实验），可以尝试 <https://github.com/dosemu2/dosemu2>，参考 <https://retrocomputing.stackexchange.com/questions/16173/emulate-a-text-mode-dos-program-using-a-unix-terminal>。

兼容性：★★★☆☆

## 算法基础

mk (16 级):

和数据结构差不多，写一些与平台无关的算法代码。

兼容性：★★★★★

## 数据库系统及应用

mk (16 级):

PowerDesigner?! 看起来只能 Wine / 虚拟机 了。

tky (17 级):

我这届金培权老师班级的实验是：实验一写 SQL，实验二用 PowerDesigner 画图，实验三写使用 MySQL 的小 project。实验一和三都可以在 Linux 下顺利完成，只有实验二需要依赖 Windows。

兼容性：★★☆☆☆

## 人工智能基础

mk (16 级):

实验与操作系统关系不是很大~

兼容性：★★★★★

## 计算机体系结构

mk (16 级):

写模拟程序，可以使用任何语言，所以问题不大。

兼容性：★★★★★

tky (17 级):

目前体系结构实验变成了写 Verilog，跑 Vivado。最后一个实验要求运行多 Cache 一致性和 Tomasulo 模拟器，这两个是 Windows 程序。我用 wine 尝试跑过，发现显示有一些问题。

兼容性：★★★☆☆
