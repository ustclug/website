---
title: 「开源软件供应链点亮计划——暑期 2022」USTCLUG 项目提案
author: totoroyyw
date: "2022-05-07 1:00:00 +0800"
categories: ""
tags: ""
---

「开源软件供应链点亮计划」是由中国科学院软件研究所发起并长期支持一项活动，旨在解决基础开源软件面临的许可、质量、维护和技术支持等问题，进而影响整个软件产业的供应链。而[「开源软件供应链点亮计划——暑期 2022」](https://summer-ospp.ac.cn/#/homepage)是由中科院软件所与 openEuler 社区共同举办的一项面向高校学生的暑期活动，旨在鼓励在校学生积极参与开源软件的开发维护，促进国内优秀开源软件社区的蓬勃发展。

<!--more-->

此活动与 GSoC (Google Summer of Code) 的模式类似：开源项目/社区提供项目需求与导师 (mentor)；学生申请项目通过后利用暑期的时间进行开发，将成果贡献给社区；主办方（中科院软件所与 openEuler 社区）根据评估结果给学生发放奖金。所有参与的社区列表可查看 <https://summer-ospp.ac.cn/#/org>。

今年夏天，USTCLUG (中科大学生 Linux 用户协会) 计划以社区身份加入此暑期活动。以下是我们计划的项目提案，也欢迎社团的各位同学提出建议。

**在报名前，请先阅读由主办方提供的[学生指南](https://summer-ospp.ac.cn/help/student/)。**

## 网络测量系统

项目描述：在校园网管理中，很多时候我们需要看某个网站/服务器在学校不同地点、不同运营商网络出口下的访问质量，分别到不同机器上手工测试并汇总常常会带来巨大的人工成本，在 <https://ping.chinaz.com/> 或者类似的网站上我们可以很方便的看网站/服务器在全国各地访问的情况，但是可惜网站的主体和客户端都不是开源的。本项目计划建设一个可自己搭建的分布式网络测量系统，架构为控制端 + 多个测量 agent。

项目难度：基础

LICENSE：自选开源协议

项目社区导师：totoroyyw

导师联系方式：totoroyyw AT ustclug.org

项目产出要求：建设一个可自己搭建的分布式网络测量系统，控制端 + 多个测量 agent：

- 控制端
  - 控制端提供 Web 界面，接收测试指令、发给测量 agent、收集并展现测量结果
  - 对不同级别的用户有权限控制（比如普通用户不能开放 TCP 端口扫描功能）
- 测量 agent
  - 启动后连接到控制端，接收测试指令、进行测试、返回测试结果
  - 隶属于多个组，可以按照组选择运行测量指令
  - docker 封装部署，预计数量在 N\*10 量级
- 测量功能包含多节点 ping、DNS 解析、http/https get、TCP 端口连接测试、TCP 端口扫描、traceroute，具体可以参考相关网站的功能
  - 测量功能方便扩展

项目技术要求：

- 掌握网络编程语言
- 拥有 Web 开发能力

相关网站：

- <https://www.17ce.com/>
- <https://ping.pe/>
- <https://ping.sx/ping>
- <https://ping.chinaz.com/>

## 网盘睿客网的 SDK 及 Rclone plugin 开发

项目描述：中科大校内有一套网盘系统睿客网（英文指代暂规定为 recdrive），此系统目前仅有网页界面而没有命令行接口，因而无法轻松地将睿客网提供的云存储整合到其他系统中。我们计划在此次项目中，为睿客网实现一套 SDK，支持基础的文件 CURD 操作，然后将此 SDK 整合到云存储命令行工具 Rclone 中，提供给用户一份 Rclone plugin 或是直接合并至 Rclone 上游。

项目难度：进阶

LICENSE：可自选开源协议，但推荐 Apache 2.0

项目社区导师：myl7

导师联系方式：myl AT ustclug.org

项目产出要求：

- 基础：提供一套 SDK 支持睿客网网盘文件的 CURD
  - 需要保证 Go 中可用以满足下一阶段的条件
  - 除 Go 外，可以使用 Rust/C/C++ 编写，只须提供 Go 中调用的方案即可
  - 由我们提供测试帐号
- 进阶：对接 Rclone，提供一份睿客网的 Rclone plugin
  - Rclone 的各种子功能，如 cache 等，可以酬情对接，以可用为第一要义
  - 开发者可以尝试将此功能提交到 Rclone 上游进行合并

项目技术要求：

- 掌握 Go 语言，或是掌握 Go 语言 FFI 并掌握另一门可 Go FFI 的语言
- 能理解文件系统语义，对 FUSE 等类似部件有一定了解
- 能阅读以 Rclone 为例的大型 Go 开源项目的源码并分析出扩展时需要对接的部分

相关网站：

- 睿客网：<https://rec.ustc.edu.cn/>
- Rclone：官网：<https://rclone.org/> 源码：<https://github.com/rclone/rclone>
- 一个参考性质的半成品：<https://github.com/myl7/recdrive>
