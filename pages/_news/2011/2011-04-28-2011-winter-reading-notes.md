---
title: "Fwd: 读书笔记：关于维护服务器的一些技巧"
author: sNullp
date: "2011-04-28 18:15:09 +0800"
categories:
  - 读书笔记
tags:
  - nginx
  - linux server
  - php
  - mysql
  - reading notes
comments: []
---

寒假读了三本书《[LINUX SERVER HACKS 卷二](http://book.douban.com/subject/2006913/)》《[实战 Nginx：取代 Apache 的高性能 Web 服务器](http://book.douban.com/subject/4251875/)》《[Linux 服务器性能调整](http://book.douban.com/subject/4027746/)》，简单地了解了些 linux 服务器维护和管理上的技巧。现在就分别简要谈谈我在读这三本书时的感受吧。

### 一：《LINUX SERVER HACKS 卷二》

首先，这不是一本工具书，而是一本经验集。书内都是很巧妙的一节一节的 linux 服务器维护技巧，主要目的是提高维护 linux 是的速度和鲁棒性。说实话，我不是很习惯这种模式的书，因为如果带着问题去读这本书，读完后还是问题，而本不是关心的部分，读完后也很快就忘了。

简言之，我懂这本书里得到的信息有：

一：linux 非常灵活，特别是结合 NFS 以及远程终端，可以做非常有想象力的事情。

二：在复杂的连线环境中记得使用 screen

三：脚本可以做几乎任何维护性质的事，而且事情的解决方案往往比你想得简单。

四：注意 uid，gid 重用可能带来的问题

五：Google 万岁

### 二：《Linux 服务器性能调整》

这本书翻译的不是很好，文法晦涩，而且介绍的东西偏深，很多是探讨内核级的优化。感觉看得不是很明白，简单写写吧。

一：关于服务器文件系统的选择：ReiserFS 鲁棒性很好，而且对小文件有最佳性能。XFS 针对大型文件有最佳性能。

二：一块硬盘上读取外侧磁道的速度要快于内侧磁道，所以分区是可以考虑这点将序号小的分区分配给经常读写的目录。譬如分区时第一个为 swap，第二个/var，再者/usr，最后才是根和/home

三：mount 文件系统时带上 noatime 可以提高一些性能。

四：文件系统在创建的时候可以调教一些参数优化性能

五：各类监控/tweak 工具：hdparam, iostats, top, vmstat

### 三：《实战 Nginx：取代 Apache 的高性能 Web 服务器》

这本书灌水的内容比较多，内容实际上也就是作者博客上的一些应用技巧的整理，可以总结的不多，因为按部就班的做就行了。

从书中看，nginx 的性能优于 apache，而且在反向代理方面特别有优势，这是它的亮点。Nginx 虽然支持 rewrite，自我感觉还是蛮好用的，但是不兼容 apache 的.htaccess，使用时需注意。

Nginx 的组件高度模块化，可定制性比较强，具体可在使用时疯狂 google。

对于使用 php+mysql 的场合，注意 php 使用 fastcgi 的方式启动，性能貌似比传统 cgi 要高不少，估计和 apache 的 module 差不多

书中没有提到什么值得一提的优化，具体实践的时候多 google 好了。对于硬件环境不好的服务器，减少 nginx 工作进程，打开 gzip 压缩和缓存，为 php 安装加速器并为低配置环境优化，数据库（例如 mysql）在配置时减少内存占用上限。选择 myisam 而不是 innodb。

简言之，这本书最大的作用就是让 nginx 变得平易近人大家都可尝试了。
