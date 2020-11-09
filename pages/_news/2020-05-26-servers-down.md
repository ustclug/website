---
title: 近期部分服务中断通知（已修复）
author: taoky
date: "2020-05-26 23:00:00 +0800"
categories:
  - LUG服务器
tags: []
---

**2020-06-05 10:27 Update 5**

ESXi 主机所在网段网络不稳定的原因已经查明，与网段内 ARP 包相关。目前已经修复。

此外，反向代理于 2 日进行了一些调整，详情见 <https://github.com/ustclug/discussions/issues/325#issuecomment-637319675>。

**2020-05-31 22:45 Update 4**

间歇性的网络问题仍然存在，我们将继续排查问题。

**2020-05-31 14:09 Update 3**

在校园网路由清空了内部转发表后，目前 ESXi 主机已经运行 7 小时而未出现网络问题。我们仍在监测问题是否已经解决。

**2020-05-30 16:15 Update 2**

我们注意到 ESXi 主机再次出现了间歇性的网络问题。包括 `git.lug.ustc.edu.cn` 在内的服务受到影响。我们正在尝试排查问题。

**2020-05-26 23:10 Update 1**

`git.lug.ustc.edu.cn` 目前已经恢复。

---

近期 USTCLUG 的一部分网络服务出现中断，具体情况如下：

- `*.proxy.ustclug.org`（开源软件反向代理）与 `servers.ustclug.org`（服务器新闻站）的校外访问，24 日晚由于服务器月流量超额而暂停，具体情况见 <https://github.com/ustclug/discussions/issues/325>。在 6 月份服务恢复后，我们将对反代服务进行调整。
- `git.lug.ustc.edu.cn` 于今日晚 22:24 由于 ESXi 主机的未知故障而下线。我们正在尝试修复。

2020-05-26 23:00:00
