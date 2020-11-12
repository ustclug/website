---
---

## FreeBSD 镜像使用方法

此页面已过期。请移步 <https://mirrors.ustc.edu.cn/help/freebsd.html>

关于 FreeBSD pkgng 源，根据[官方说明](https://www.freebsd.org/doc/en/articles/hubs/mirror-howto.html#mirror-pkgs "https://www.freebsd.org/doc/en/articles/hubs/mirror-howto.html#mirror-pkgs")， FreeBSD 不允许同步软件包，我们尊重 FreeBSD 的选择，不提供 pkgng 镜像。

    Due to very high requirements of bandwidth, storage and adminstration the FreeBSD Project has decided not to allow public mirrors of packages.

FreeBSD 项目[暂时不再接受新站点成为官方镜像源](https://www.freebsd.org/doc/en/articles/hubs/mirror-official.html#mirror-official-become "https://www.freebsd.org/doc/en/articles/hubs/mirror-official.html#mirror-official-become")，且不向第三方镜像站点提供 pkgng 同步接口。因此，我们无法及时可靠地从官方站点同步数据。

目前我们仍会同步 FreeBSD 部分内容，但不包含 pkgng 中的软件包。

鉴于以上原因，我们不建议您使用科大镜像站提供的内容。建议您使用官方支持的镜像源。您可以在 <https://www.freebsd.org/doc/handbook/eresources-web.html> 找到官方镜像站的列表。

我们并非 FreeBSD 的官方源，所同步的文件受到非官方上游的限制。使用请自行承担风险。

### 使用说明

以下使用说明已过期，请自行鉴别。

最新版的 FreeBSD 使用 pkgng 管理软件包，请查阅相关资料了解详情。

#### Packages 使用方法

以 FreeBSD 8.1 i386 为例, 在终端下执行以下命令(操作前请做好相应备份)

    setenv PACKAGESITE http://mirrors.ustc.edu.cn/freebsd/releases/i386/8.1-RELEASE/packages/Latest/
    pkg_add -r package #package为要安装的软件名

#### Ports 使用方法

以安装 firefox 为例, 编辑/etc/make.conf 文件, 修改 MASTER _SITE_ BACKUP 字段(操作前请做好相应备份)

    MASTER_SITE_BACKUP?=http://mirrors.ustc.edu.cn/freebsd/distfiles/${DIST_SUBDIR}/
    MASTER_SITE_OVERRIDE?=${MASTER_SITE_BACKUP}

然后在/usr/ports/www/firefox 目录下执行以下命令(要先安装 ports)

    make
    make install

### 相关链接

- 官方主页: <http://www.freebsd.org/>

- 邮件列表: <http://www.freebsd.org/community/mailinglists.html>

- 论坛: <http://forums.freebsd.org/>

- 手册: <http://www.freebsd.org/doc/zh_CN/books/handbook/>
