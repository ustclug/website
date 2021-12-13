---
title: 桌面美化
header:
author: psi-cmd
date: "2021-12-05 14:30:00 +0800"
categories:
  - LUG活动
tags: []
comments: []
---

2021 年 12 月 5 日，LUG 社团于 3A212 教室开展了本学期第一次小聚分享活动，本次是由诙谐幽默的赵作竑同学为同学们带来 LInux 桌面美化方案的介绍。（顺带狠狠地捧了一把 Arch Linux 发行版）

![](http://ftp.lug.ustc.edu.cn/weekly_party/2021.12.05_Desktop_Show/Photos/20211205_110431324.jpg)

赵作竑同学深知介绍新事物，要从听众所熟悉的内容入手。于是演讲一开始，纯净的蓝天，白絮的闲云便迎面而来，翠绿的草甸勾勒出舒畅的坡形，我的文档、电脑、网上邻居坐落有序 —— 这就是同学们小时候的 XP 啊！

![](http://ftp.lug.ustc.edu.cn/weekly_party/2021.12.05_Desktop_Show/Photos/20211205_110455455.jpg)

界面是那么朴素，年代是那么久远，直到同学们熟悉的命令行的出现，它才褪去了伪装。XP 桌面主题用它的天衣无缝，向同学们证明了 Linux 桌面美化的无限可能。

赵作竑同学借此机会向同学们推荐了演示所用的 [B00merang](https://github.com/B00merang-Project/Windows-XP) 主题, 它可以让同学们的 Linux 桌面风格倒退 20 年，向 Windows XP 看齐，同时建议同学们尝试采用 B00merang 下其他 Windows 版本的主题，以得到形似 Windows 但更加流畅的界面体验。

简单的引入环节后，赵作竑同学向同学们系统地介绍了桌面配置背后的逻辑：

首先将桌面环境的软件分为四类：程序、窗口管理，外设设置（状态栏），桌面常用软件，其他功能。同学们可以从某一类入手，对系统的环境进行调节。

随后赵作竑同学从窗口管理器入手，介绍了平铺式，层叠式和混合式窗口管理器的区别，并举例说明，供大家按喜好选择。顺便推荐了 Arch Wiki 上的窗口管理器页面 [Window manager - ArchWiki](https://wiki.archlinux.org/title/Window_manager)，供同学们参考。

![](http://ftp.lug.ustc.edu.cn/weekly_party/2021.12.05_Desktop_Show/Photos/20211205_112639578.jpg)

接下来是面板和启动器，赵作竑同学推荐了 Rofi + Polybar 的配置，并推荐了 GitHub 上的 adi1090x 用户的配置方案做参考。同时提醒同学们这个方案提供的是外观，如果希望可以在面板上进行调节亮度，连接 wifi 等操作，需要安装对应的软件包，因为对控件的操作本身是对对应命令的调用。

完成了上述过程后，同学们就有了一套属于自己的可控风格的系统，接下来就可以开始对风格进行调整了——赵作竑向同学们推荐了他的经验：根据自己最喜欢的终端配色方案进行各控件的颜色配置。而对 GTK 或 Qt 应用的主题也可以使用对应插件实现。

若希望更进一步的优化，需要细节上的耐心：如工作栏的字体，图标风格等的挑选。

在小聚的最后，赵作竑同学为同学们演示了如何参与社团的开源桌面美化方案投稿：只需要在投稿仓库 [Open-Source-Desktop-Show](https://github.com/ustclug/Open-Source-Desktop-Show) 的 issue 板块中中选择对应的 Template 填写后提交，即可完成投稿。

![](http://ftp.lug.ustc.edu.cn/weekly_party/2021.12.05_Desktop_Show/Photos/20211205_110621229.jpg)

小聚结束后，陶柯宇同学为同学们演示了参与二课的同学如何将自己的学校账号和 GitHub 账号关联起来：首先访问 <htttps://ghauth.ustclug.org>，依次点击 `Authenticate USTC` 和 `Authenticate GitHub` ，最后点击 token 导出密钥，在二课提交时应将密钥附在提交窗口中。

若希望了解小聚的更多细节，可阅读本次讲座的[小聚讲稿](http://ftp.lug.ustc.edu.cn/weekly_party/2021.12.05_Desktop_Show/20211205小聚讲稿.pdf)。
