---
title: "新网站上线啦"
author: "iBug"
categories:
  - LUG网站
tags: []
---

经过多位成员连续多日的努力，Linux 用户协会的网站焕然一新。现在你所看到的页面正是我们新网站上线后的第一篇新闻。

新的网站采用 [Jekyll](https://jekyllrb.com/) 静态网站方案，基于 [minimal-mistakes](https://github.com/mmistakes/minimal-mistakes) 修改的主题，并使用 [GitHub Actions](https://github.com/features/actions) 自动构建，利用 webhook 通知服务器自动部署。

重新设计的网站架构带来了多方面的好处：

- 首先是更美观了：我们选用的主题既适用于首页等展示性页面，又适用于 wiki、文档、文章等内容性页面，同时还采用了响应式设计 (responsive design)，使得同一个页面在不同大小的屏幕上都能获得较好的显示效果
- 功能方面，我们终于将 wiki（即本网站）、news（社团新闻）和 planet（社团博客）合并到了一起，一定程度上解决了社团网站太多、内容过于分散、账号系统混乱的问题
- 基于 Git 的版本管理和协作更加方便：如同我们的[旧新闻站](https://github.com/ustclug/news)，现在我们所有修改都有完整的历史记录，同时也能以 Pull Request 的形式接受投稿及修改建议
- 更易于维护及部署：纯静态的网站不需要维护数据库及 PHP 运行环境等，只需要一个能提供静态文件的服务器即可运行。我们采用了 OpenResty 作为 HTTP 服务器，在使用 Nginx 的同时还能通过 Lua 代码提供 webhook 相关功能

本网站的源码位于 [ustclug/website](https://github.com/ustclug/website)，以 Creative Commons Attribution-NonCommercial-ShareAlike (BY-NC-SA) 4.0 协议开源。

原来的网站（wiki）已移动至 <https://lug.ustc.edu.cn/oldwiki>，旧新闻站仍保留在 <https://news.ustclug.org/>，其内容不再维护，留作存档。
