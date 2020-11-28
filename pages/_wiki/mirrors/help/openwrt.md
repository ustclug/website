---
---

# openwrt 镜像存档使用说明

此处的帮助文档已经废弃，新的内容请访问 <https://mirrors.ustc.edu.cn/help/>

---

## 说明

由于 OpenWrt 上游不提供 rsync 服务, 而且用 lftp 与上游进行同步的时候总是会出现文件下载不完整的情况, 所以 USTC Mirrors 目前改为对 [http://downloads.openwrt.org](http://downloads.openwrt.org/ "http://downloads.openwrt.org") 做反向代理.

同步的地址由原来的 <http://mirrors.ustc.edu.cn/openwrt> 改为 [http://openwrt.mirrors.ustc.edu.cn](http://openwrt.mirrors.ustc.edu.cn/ "http://openwrt.mirrors.ustc.edu.cn")

原来的地址目前仍会保留, 以后将择日删除.
