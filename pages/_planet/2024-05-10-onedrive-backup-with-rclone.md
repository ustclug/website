---
title: "使用 Rclone 备份 OneDrive 内容"
author: "tiankaima"
categories:
  - Tech Tutorial
tags:
  - rclone
  - OneDrive
---

本文用于介绍如何使用 Rclone 备份 OneDrive 内容。

## Rclone 简介

Rclone 是一个命令行工具，用于同步文件和目录到和从云存储服务。它支持 Google Drive、Amazon S3、Dropbox、Microsoft OneDrive、Yandex Disk、Box 和其他一些云存储服务。Rclone 是一个 Go 程序，可以在 Windows、macOS、Linux 和其他操作系统上运行。

## 安装 Rclone

Rclone 官方的下载链接在 [这里](https://rclone.org/downloads/)。你可以根据自己的操作系统下载对应的版本。

部分常见的包管理工具也提供了 Rclone 的安装方式，例如：

- 在 Windows 上，你可以使用 Chocolatey 安装 Rclone：

  ```bash
  choco install rclone
  ```

- 在 Windows 上，你也可以使用 Winget 安装 Rclone：

  ```bash
  winget install Rclone.Rclone
  ```

- 在 macOS 上，你可以使用 Homebrew 安装 Rclone：

  ```bash
  brew install rclone
  ```

- 在 Ubuntu 上，你可以使用 apt 安装 Rclone：

  ```bash
  sudo apt install rclone
  ```

- 更多包管理器的安装方法可以参考 [Rclone 官方文档](https://rclone.org/install/#package-manager)。

运行 `rclone --version` 来检查 Rclone 是否安装成功，如果正常，你应该类似看到如下输出：

```console
$ rclone --version
rclone v1.66.0
- os/version: darwin 14.5 (64 bit)
- os/kernel: 23.5.0 (arm64)
- os/type: darwin
- os/arch: arm64 (ARMv8 compatible)
- go/version: go1.22.1
- go/linking: dynamic
- go/tags: none
```

## 配置 Rclone

我们在这里以 `mail.ustc.edu.cn` 为例，做一个 step-by-step 的教程：

```bash
rclone config
```

```console
No remotes found, make a new one?
n) New remote
s) Set configuration password
q) Quit config
n/s/q>
```

输入 `n`，然后回车。

```console
Enter name for new remote.
name>
```

输入一个名字，这里我们输入 `onedrive`，然后回车。

```console
Option Storage.
Type of storage to configure.
Choose a number from below, or type in your own value.
 1 / 1Fichier
   \ (fichier)
 2 / Akamai NetStorage
   \ (netstorage)
 3 / Alias for an existing remote
   \ (alias)
 4 / Amazon S3 Compliant Storage Providers including AWS, Alibaba, ArvanCloud, Ceph, ChinaMobile, Cloudflare, DigitalOcean, Dreamhost, GCS, HuaweiOBS, IBMCOS, IDrive, IONOS, LyveCloud, Leviia, Liara, Linode, Minio, Netease, Petabox, RackCorp, Rclone, Scaleway, SeaweedFS, StackPath, Storj, Synology, TencentCOS, Wasabi, Qiniu and others
   \ (s3)

...

33 / Microsoft OneDrive
   \ (onedrive)

...

Storage>
```

输入 `onedrive`，然后回车。

```console
Option client_id.
OAuth Client Id.
Leave blank normally.
Enter a value. Press Enter to leave empty.
client_id>

Option client_secret.
OAuth Client Secret.
Leave blank normally.
Enter a value. Press Enter to leave empty.
client_secret>

Option region.
Choose national cloud region for OneDrive.
Choose a number from below, or type in your own string value.
Press Enter for the default (global).
 1 / Microsoft Cloud Global
   \ (global)
 2 / Microsoft Cloud for US Government
   \ (us)
 3 / Microsoft Cloud Germany
   \ (de)
 4 / Azure and Office 365 operated by Vnet Group in China
   \ (cn)
region>

Edit advanced config?
y) Yes
n) No (default)
y/n>

Use web browser to automatically authenticate rclone with remote?
 * Say Y if the machine running rclone has a web browser you can use
 * Say N if running rclone on a (remote) machine without web browser access
If not sure try Y. If Y failed, try N.

y) Yes (default)
n) No
y/n>
```

这里我们都直接回车，不输入任何内容。(五次回车)

在这其中会弹出一个网页，让你登录你的 OneDrive 账号，然后授权 Rclone 访问你的 OneDrive 账号。

```console
Option config_type.
Type of connection
Choose a number from below, or type in an existing string value.
Press Enter for the default (onedrive).
 1 / OneDrive Personal or Business
   \ (onedrive)
 2 / Root Sharepoint site
   \ (sharepoint)
   / Sharepoint site name or URL
 3 | E.g. mysite or https://contoso.sharepoint.com/sites/mysite
   \ (url)
 4 / Search for a Sharepoint site
   \ (search)
 5 / Type in driveID (advanced)
   \ (driveid)
 6 / Type in SiteID (advanced)
   \ (siteid)
   / Sharepoint server-relative path (advanced)
 7 | E.g. /teams/hr
   \ (path)
config_type>
```

这里我们直接回车，不输入任何内容。

```console
Option config_driveid.
Select drive you want to use
Choose a number from below, or type in your own string value.
Press Enter for the default (b!****************************************************************).
 1 / OneDrive (business)
   \ (b!****************************************************************)
config_driveid>

Drive OK?

Found drive "root" of type "business"
URL: https://mailustceducn-my.sharepoint.com/personal/tiankaima_mail_ustc_edu_cn/Documents

y) Yes (default)
n) No
y/n>

Configuration complete.
Options:
- type: onedrive
- token:
***
- drive_id: b!****************************************************************
- drive_type: business
Keep this "onedrive" remote?
y) Yes this is OK (default)
e) Edit this remote
d) Delete this remote
y/e/d>
```

依旧是直接回车，不输入任何内容。

```console
Current remotes:

Name                 Type
====                 ====
onedrive             onedrive

e) Edit existing remote
n) New remote
d) Delete remote
r) Rename remote
c) Copy remote
s) Set configuration password
q) Quit config
e/n/d/r/c/s/q>
```

输入 `q`，然后回车。现在我们已经配置好了 Rclone。

## 将文件从 OneDrive 备份到本地

```console
rclone copy onedrive: /path/to/local/folder -P
```

## 总结

Rclone 是个非常强大的工具，支持的云存储服务也非常多，你可以通过 `rclone config` 来配置其他的云存储服务。

限于篇幅和时间关系，本文只介绍了 Rclone 的基本使用方法，更多的功能和用法请参考 [Rclone 官方文档](https://rclone.org/docs/)。

如果您对这篇内容有任何问题或建议，欢迎 [联系我们](/wiki/lug/contact/)。
