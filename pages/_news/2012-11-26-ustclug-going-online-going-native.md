---
title: 科大 LUG Linux User Party 活动成功举行
author: Aenon
date: '2012-11-26 00:21:14 +0800'
categories:

* LUG活动

tags:

* Linux User Party

comments:

* id: 223

  author: moper
  author_email: i@moper.me
  author_url: http://moper.me/
  date: '2012-11-29 22:08:00 +0800'
  date_gmt: '2012-11-29 14:08:00 +0800'
  content: 看起来好精彩~

* id: 224

  author: Aenon SUN
  author_email: s.sn.giraffe@gmail.com
  author_url: http://aenon.me/
  date: '2012-12-16 13:42:00 +0800'
  date_gmt: '2012-12-16 05:42:00 +0800'
  content: 嗯，可惜時間太長了。

* id: 229

  author: moper
  author_email: i@moper.me
  author_url: http://moper.me/
  date: '2013-04-03 18:02:00 +0800'
  date_gmt: '2013-04-03 10:02:00 +0800'
  content: 中科大真好，博客都能看出来了~

* id: 230

  author: Aenon SUN
  author_email: s.sn.giraffe@gmail.com
  author_url: http://aenon.me/
  date: '2013-04-03 20:24:00 +0800'
  date_gmt: '2013-04-03 12:24:00 +0800'
  content: 挖坟啊

* id: 239

  author: riaqn
  author_email: qzs123@gmail.com
  author_url: ''
  date: '2013-11-11 12:44:00 +0800'
  date_gmt: '2013-11-11 04:44:00 +0800'
  content: USTC真好，开源氛围很浓。
---
高速发展的互联网改变着人类的生活方式，而基于Linux的Web技术支撑起了当今互联网的大厦。“Let's Build -- Building the Next-generation Web & Architecture”的大标题投影在东区水上报告厅，2012年11月24日下午，科大LUG以“Going Online, Going Native”为主题的Linux User Party活动举行。Guide to Node.js，Linux高性能计算集群，iptables灵活网络配置，LUG Services项目启动……内容充实的讲座持续了四个小时，从不同角度讲述了Linux在Web Services、科学计算和我们生活中的应用，描绘了LUG Services的美丽蓝图。

首先演讲的是《Node.js开发指南》作者、清华大学开源软件镜像维护者、清华大学学生郭家宝。JavaScript技术的进化伴随着多家互联网企业的兴衰，Node.js是目前最流行的将JavaScript用于后端的框架。以往Web开发常常是前后端在不同的编程语言中重复写同样逻辑的代码，而在Node.js中这样的问题得以缓解。

不同于多数后端技术，Node.js采用了事件驱动的非阻塞编程模型，这使得Node.js可以在单线程中达到其他语言中需要多线程才能达到的CPU利用率。借助V8引擎的执行效率，JavaScript已经成为最快的脚本语言之一；再加上异步并发的编程模型，用Node.js可以实现很高性能的Web服务器，尤其适合需要进行“服务器推”的WebSocket类应用。

Node.js强大的性能背后隐藏着编程和调试的困难，例如通过回调函数来进行控制流传递的编程范式。为此，郭家宝发起了开源项目Continuation.js，通过编译将嵌套的回调函数平面化，简化顺序逻辑在Node.js中的实现。

演讲结束后，同学们提出了“现有系统是否应该换用Node.js”、“为什么现在Web开发用的更多是PHP”、“Node.js是否对系统资源消耗很多，是否对硬件配置有较高要求”等很多有趣的问题，郭家宝一一作答，希望我们以更开放的心态迎接新技术。每位提问的观众都收到了一份Ubuntu的精美礼品。

第二个演讲的是科大超算中心李会民老师。2012年世界排名前500的超级计算机中，运行Linux的占90%以上，只有一两台运行的是Windows系统，Linux在高性能计算领域占据统治地位。这场讲座带领我们从Linux这个自由的集市中寻找到合适的工具，让身边的计算资源发挥作用。

短短的一个小时，李会民老师以较快的语速，全面讲解了高性能计算集群：

各计算节点要共享文件，有NFS网络文件系统；

主机账号信息要集中管理，有NIS网络信息服务；

集群要快速安装Linux，以PXE网络启动为基础的kickstart网络安装工具很实用；

集群之间时间要同步，有NTP时间服务器；

集群节点之间要通信，SSH可以用key无密码登录；

要同时管理多台机器，有pdsh这个并行shell和交互式脚本语言expect；

要自动化运行复杂任务，有作业调度系统TORQUE；

要监控系统性能，有集群监控软件Ganglia；

内网服务器要访问外网，有iptables。

并行计算的基本原理，MPI和OpenMP编程框架、GPGPU计算；

还有磁盘配额、编译环境的配置……

接下来又是一个很多人争着举手发言的互动问答环节。针对一台机器能不能部署高性能计算的疑问，李会民老师说，除了kickstart网络安装之外，上述工具都可以在单台机器上使用，而且其中涉及的技术在日常Linux使用和运维中也是有用的。

利用五分钟的中场休息时间，李喵喵介绍了Linux Deepin这个对新手友好的Linux发行版，并现场发放Linux Deepin赠送的安装光盘。

第三个演讲的是科大Linux用户协会CTO郭家华同学。

科大网络通是什么原理？同学们好奇地抬起了头，”数据包传送过程“显得不再枯燥了。

想与同桌共享网络通？用iptables进行数据包转发；

那么与整个机房共享网络通呢？有网络地址转换（NAT）；

让外网访问内网端口提供的服务，可以用端口映射；

要端口映射到任意计算机，SNAT和DNAT可以配合使用。

特别值得一提的是，演讲所用slides中的网络拓扑结构图是用graphviz画的，图形清晰明了。

活动的压轴环节是LUG网络服务系统介绍与展望。

李喵喵首先介绍了即将发布的USTC Blog服务。尽管社会化媒体层出不穷，但博客仍然是信噪比最高的内容发布平台。在博客中，我们可以发表个人心情，可以制作图片展，可以彰显技术经验，可以作为推广媒体，博客的形式永不过时。USTC Blog作为LUG提供的Wordpress博客托管服务，与其他博客服务相比，拥有科大域名（blog.ustc.edu.cn）的权威性和高权重，继承了Wordpress插件和主题的高度可定制性，还拥有校内服务的稳定性和安全性。随后USTC Blog开发团队李博杰同学介绍了跨博客内容整合和沙盒技术两个后续开发方向，演示了blog的注册流程和后台操作。

接下来科大LUG李博杰同学介绍了mirrors升级计划。mirrors作为国内教育网访问量最大的开源软件镜像，将成为一个开源项目，发展更多周边产品，提高曝光度和用户参与度。Mirrors Maintainer和Mirrors Developer的开发团队结构让在座的同学们感到耳目一新，期待着在Mirrors Lab上一起参与开发与测试。Mirrors还将增加编程语言的镜像，对访问日志进行统计分析得出热度排行榜和热度趋势。

查找和选择软件包一直困扰着新手，KISS是LUG Services的终极目标。有的软件包不在官方源里，科大LUG张光宇同学受到AUR的启发，发起了Yet Another Debian User Repository（YADUR）项目。在YADUR中上传包，只需注册账号，然后用浏览器或我们的客户端上传软件包；使用YADUR源就像用Ubuntu PPA一样简单。针对Debian打包困难的问题，YADUR将提供一个打包教程。YADUR将成为一个开源项目，它本身就是YADUR中的第一个软件包。

YADUR将解决软件包的来源，而Linux Software Store将让Linux软件包变得不再神秘难寻。软件分类推荐和搜索让我们找到软件包，软件包详情和用户评论让我们了解软件包，到mirrors的链接让我们方便地下载软件包，社会化分享和评论让我们围绕着软件包展开社交。最后，李喵喵为LUG Services发出了“We need you”的号召。

整场活动由李喵喵制作的简洁雅致的slides贯穿，尽管已经到了饭点但不少同学坚持到了最后。会后，14名感兴趣的同学在大雅楼参与了Linux User Dinner（LUD），时而谈起清华与科大的学习生活，时而聊到开源世界的奇闻逸事。高潮迭起的LUD持续到了晚上九点，2012年Linux User Party活动在依依惜别中圆满结束。
