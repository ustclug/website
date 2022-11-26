---
---

# lug.ustc.edu.cn 系统升级失误

- 时间：（2013 年）10 月 2 日至 11 日
- 性质：人为操作失误
- 影响：
  - lug.ustc.edu.cn 的 web 服务中断。其余服务未知；lug.ustc.edu.cn 域名解析到备份服务器；
  - 下线期间所有服务中断；
  - 由于数据库受到影响，并且监控脚本设置为是错误重连，学校的短信报警平台发出了 7 万条短信，使学校短信平台的余额用完了。

## 事件发生及处理过程

- 10 月 1 日晚，鉴于 lug.ustc.edu.cn 的系统（debian squeeze，而且是 6.0.1）已经很老，估计有不少安全更新，vastuniverse 提出将系统进行升级（dist-upgrade）；
- 在和 lug 以前的维护者沟通，重点关注了三个方面：运行上的进程是否需要保留，是否有其它隐藏服务，服务器上是否有一些只是临时解决、解决方案不能禁受重启或者软件包版本升级的问题；这些疑问解决之后，于第二天（10 月 2 日）开始升级操作；
- 升级过程：
  - 查看/etc/apt/source.list，发现之前 squeeze 和 wheezy 源混用，并且还另加了 dotdeb 第三方源；
  - 删掉重复的 wheezy 源，把 squeeze 源改成 wheezy 源，注释掉其他所有源，只保留 debian 的官方 wheezy 源（mirrors.ustc.edu.cn/debian wheezy .........）；
  - aptitude update 以及 dist-upgrade；升级过程中涉及到服务的自动重启，涉及到本地版本配置文件和新软件包里配置文件的，用 diff 查看之后再决定是否替换；手工比较结果：nginx 配置文件由于本地版本和软件包新版本差异较大，保留了本地版本，而 php 的本地版本和软件包新版本差异不是很大，记住差异了之后用新版本覆盖并且手工修改回去了；
  - 加入 debian-security 源，二次升级；
  - 加回 dotdeb 源，再次升级，配置文件处理原则同上，这次比较结果如何现在忘了；
  - 修改 sudoers 文件，试图恢复升级之前的内容，而且想用新版 sudoers 推荐的方法：不直接修改/etc/sudoers，而是在/etc/sudoers.d/下面新建文件加入内容的方式;就是在这一步出事了。

### 事故发生

由于不是直接修改/etc/sudoers，而是在/etc/sudoers.d/加入文件，脑子里面没有条件反射，没有使用 visudo 而是用了 vim 去加入/修改文件，而在编辑保存的时候，sudoers 出现了语法错误，没有发现就保存了，而 vim 又没有像 visudo 一样的语法检查，造成了 sudo 无法使用；而现在没有人记得 root 用户密码，也就是说现在机器上没有任何人可以进行需要 root 权限的操作。

在 sudo 无法使用之后才发现 web 服务中断（http 502 错误），但是现在必须进入机房，物理接触机器才能维修了。而更严重的是，国庆假期期间，能联系进入西区图书馆机房的人全都不在学校，只能等待国庆假期结束之后才能进入机房维修。这样 web 服务至少停止 6 天。此间 lug.ustc.edu.cn 的域名解析到 blog.ustc.edu.cn 上面。期间对 lug 页面的更改将来在恢复时是个麻烦事。

### 事故处理及解决

10 月 8 日，进入机房之后，重启进入恢复模式。

将有问题的 sudoers.d/下的文件删除了之后，重启进入正常模式，sudo 问题解决。

而为了解决 sudo 问题而重启了机器之后，将 apache 停止，nginx 重启，http 502 错误也同时解决了。

到此为止，服务器算是恢复。

## 尾声

将服务器放到图书馆机房开机之后，发现机器没有活动，后来又上去看了一下，发现竟然是连接的那个机柜背板的网口没有物理连接，连网卡的灯都不亮……8-O

在解决网络问题之后，将 source.list 恢复至相当于原本的内容。详细如下：

```
之前的源列表：
deb     http://mirrors.ustc.edu.cn/debian squeeze main contrib non-free
deb-src http://mirrors.ustc.edu.cn/debian squeeze main contrib non-free

deb     http://mirrors.ustc.edu.cn/debian-security ???squeeze的security源怎么写忘了
deb-src http://mirrors.ustc.edu.cn/debian-security ???

deb     http://mirrors.ustc.edu.cn/dotdeb/packages.dotdeb.org squeeze all
deb-src http://mirrors.ustc.edu.cn/dotdeb/packages.dotdeb.org squeeze all

deb     http://mirrors.ustc.edu.cn/dotdeb/php53.dotdeb.org squeeze all ->这两行从squeeze
deb-src http://mirrors.ustc.edu.cn/dotdeb/php53.dotdeb.org squeeze all ->到wheezy时，源的结构有所变动

升级之后：
deb     http://mirrors.ustc.edu.cn/debian wheezy main contrib non-free
deb-src http://mirrors.ustc.edu.cn/debian wheezy main contrib non-free

deb     http://mirrors.ustc.edu.cn/debian-security wheezy/updates main contrib non-free
deb-src http://mirrors.ustc.edu.cn/debian-security wheezy/updates main contrib non-free

deb     http://mirrors.ustc.edu.cn/dotdeb/packages.dotdeb.org wheezy all
deb-src http://mirrors.ustc.edu.cn/dotdeb/packages.dotdeb.org wheezy all

deb     http://mirrors.ustc.edu.cn/dotdeb/packages.dotdeb.org wheezy-php55 all ->这两行是在“尾声”阶段加上
deb-src http://mirrors.ustc.edu.cn/dotdeb/packages.dotdeb.org wheezy-php55 all ->的，目的是升级前后保持一样
```

之后再次 aptitude update 和 aptitude dist-upgrade。主要更新的是 nginx、apache、php 系列的包。这次 php 的配置文件对比之后发现差别不多，就用新的覆盖了。

机器重启。又 http 502 了。

查阅 nginx 的 error.log 之后（/var/log/nginx/lug.ustc.edu.cn/error.log），修改 php 配置文件/etc/php5/fpm/pool.d/www.conf，把 listen = /var/run/php5-fpm.sock 修改为 127.0.0.1:port，问题彻底解决。

至此，服务完全恢复。文内没有提到的 ftp、ssh 等服务，除了 mysqld 之外就是一直正常。

## 总结和教训

这次升级，之前主要害怕的问题——软件包依赖的版本要求被更新破坏、数据库数据丢失、runtime 新版本不兼容、配置文件新版本不兼容————可以说都没有出现，但是 sudo 被搞坏了之后，服务器一点点小问题都不能修复，只能停止服务。

- 服务器的系统升级之前先要了解运行的服务，先要 pstree 看一下运行的进程，并且查阅文档或者直接联系其他维护者确认服务器上的手工运行的重要进程、重要配置；
- php、nginx 这些软件包，更新相隔时间太长的话，更新的台阶还是挺大的。软件包里带的配置文件和自己用的配置文件已经有很多不同了（不是指自己修改的部分），很多默认配置也改变了；
- 源不要混用，对于 debian 来说前后两个版本的源混用极易带来软件包依赖时候的问题；
- **修改 sudo 相关的文件，''/etc/sudoers''、''/etc/sudoers.d/xxx''的时候，必须，I repeat，必须用 visudo；**
- 一个没有想到的影响：lug.ustc.edu.cn 在服务 down 掉的几天里，由于数据库出了问题，监控脚本不断尝试重连，发送报警短信，致使几天时间内发出了 7 万条短信，把学校短信平台的余额用完了。
