---
title: "USTC Linux 用户生存指南"
author: mk
categories:
  - Experience
tags:
  - Courses
---

本指南指导中科大 Linux 用户如何使用 Linux 完成各门课程。“兼容性”仅代表使用 Linux 完成课程的难易程度，与课程本身质量和难度无关。

**~~注意：本指南目前仅包含部分计算机专业本科课程。~~**欢迎其他同学贡献更多内容！

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

regymm (17 级):

注：如果有串口通信实验，在 Linux 上有 picocom 等工具，不必非要使用专门的 exe 软件。

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

taoky (17 级):

不同班级的实验会不一样，但是基本上都需要使用 Wireshark。有些实验会有 socket 编程相关的内容，兼容性上没有问题。

兼容性：★★★★★

## 微机原理与系统

mk (16 级):

需要用到 MASM。大概使用 DOSBox 就能应付（？）

taoky (17 级):

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

taoky (17 级):

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

taoky (17 级):

目前体系结构实验变成了写 Verilog，跑 Vivado。最后一个实验要求运行多 Cache 一致性和 Tomasulo 模拟器，这两个是 Windows 程序。我用 wine 尝试跑过，发现显示有一些问题。

兼容性：★★★☆☆

## 大学英语听说 I-IV

regymm (17 级):

这门课可能需要随书附带光盘中的练习资料。自带的练习软件无法在 wine 中运行。然而，光盘中的音频和视频文件均可以直接播放（老师可能也会提到这一点）。

同时，二教 8 楼等听力考试的机房似乎也在平时开放供同学使用。

兼容性：★★★☆☆

## 金工实习

regymm (17 级):

需要使用 AutoCAD 和 SolidWorks 完成课后设计作业。*或许*有自由软件替代。这类软件对图形要求较高，VirtualBox 上表现不佳，我只能选择使用 VMWare。这方面似乎 Linux 上确实无太好的解决方案。

虚拟仿真实验需要安装科大平台提供的 Windows 程序并在指定浏览器运行。在 VirtualBox 中使用时图形性能十分低下，不影响完成实验但体验不佳。

如果手头没有性能较好能够在 VMWare 中运行 CAD 软件的机器，可以选择在工院机房完成，那里有性能不错并预装好所需软件的 Windows 机器。

兼容性：★☆☆☆☆

## 大物实验

regymm (17 级):

对于大部分实验，只需要处理数据并绘图。[Origin](#origin) 是”官方推荐“的软件，但是用 [MATLAB](#matlab) 或 Python 等可以胜任。

个别实验似乎会要求用 U 盘拷贝 Origin 文件并课下分析，这就没有办法只能用 Origin 了。而也有个别实验让我觉得 Origin 明显是更加明智的选择。

个别实验需要用（可能是实验室助教自己编写的）基于 MFC 等框架的处理程序，但我遇见的所有情况都是在课上分析完成，并不需要在自己电脑上使用这些程序。

核物理专业实验等需要分析一些专门处理软件（探测器上位机）或示波器导出的数据，但似乎都是纯文本，用 Linux 不会有什么困难。有时也可能使用 [ROOT](#root).

总之，如果你只需要做一级实验，应该不会遇到任何 Linux 无法处理的情况。然而如果你需要做三级甚至更多级，最好为 corner case 做好准备。对于这一系列本就较为繁琐的课程，从节约时间的角度考虑，装上 Origin 以备不时之需也是应该的，即使是在偶有问题的 wine 上。

兼容性：★★★★☆（一级二级），★★★☆☆（三级至五十三级）

## 计算物理

regymm (17 级):

除了 C、C++、Fortran 等编程外，可能用到 [MATLAB](#matlab)、[Mathematica](#mathematica)、[Origin ](#origin) 等，但没有任何一个是必须的。可以根据个人喜好或兼容性选择。

兼容性：★★★★★

## 计算方法

regymm (17 级):

除了基本程序设计软件之外，可能会用到 [MATLAB](#matlab).

兼容性：★★★★★

## 托福

regymm (17 级):

小站托福可以在 Crossover 中较好的运行，有 bug 但并不会在做题过程中出现。不建议在虚拟机中使用，因为音频可能质量下降。

兼容性：★★★★☆

## 实验报告/文书编写

regymm (17 级):

无论是 LaTeX、LyX、Texmacs 还是 IDE 如 TexStudio，都有 Linux 版本，甚至可能安装更加容易。

Word 或 Excel 等格式的文件主要是社团/学生会/班级的填报表格等，WPS for Linux 可以胜任。如果不放心，可以在手机上的 Office 软件中 double check. 另外，我在 Crossover 中安装的 Office 2010 套装运行良好（而 Office 2013 和 Office 2016 经常出现各种问题）。

兼容性：★★★★☆

## 申请出国

regymm (17 级):

文书可以用 TeX，填写各种申请表也只需要一个 modern 的浏览器。需要在 PDF 中添加注释，或在 Word 文档中编辑的情况很少但确实存在。Linux 上的 Foxit Reader 是不错的 PDF 编辑器，但在这种事情上我还是选择了虚拟机中的福昕企业版（科大正版软件有提供）和较新的 Office 套装。

兼容性：★★★★★

## MATLAB

regymm (17 级):

专利软件 MATLAB 是有 Linux 版的，并且科大正版软件有所提供。本人在用 MATLAB 完成计算、绘图、网络编程、Simulink 等任务时均未遇到任何问题。

然而，如果要使用一些第三方厂商提供的模块和/或进行硬件控制，可能会遇到 Linux 上无法正常使用的情况。

兼容性：★★★★☆

## Mathematica

regymm (17 级):

专利软件 Mathematica 是有 Linux 版的，并且科大正版软件有所提供。尽管界面相比 Windows 版稍丑（个人看法），未遇到任何功能问题。

兼容性：★★★★★

## Origin

regymm (17 级):

专利软件 Origin 是交互式科学绘图和数据分析工具，没有 Linux 版。在 Origin 2017 / Origin 最新版 / wine 32 位 Win10 模式 / wine 64 位 Win10 模式的组合中，大部分可以正常安装运行。

然而，需要注意的是，尽管大部分功能能正常运行，一些个别功能可能会 fail silently，如果遇到某一操作无法执行，除了自己操作错误外，也可能是其本身的问题。这可能耽误很多时间。

VirtualBox 可以正常运行。

可以考虑 QtiPlot、gnuplot、甚至 [ROOT](#root) 完成绘图。

兼容性：★★☆☆☆

## ROOT

regymm (17 级):

CERN 的 ROOT 同样有原生 Linux 支持。课程提供的程序文件中只可能有个别地方，如文件路径格式等，需要修改。

兼容性：★★★★★
