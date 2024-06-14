---
---

# Linux 用户管理

提示：Linux 101 中有与本文内容相关的章节，点击[这里](https://101.lug.ustc.edu.cn/Ch05/)来跳转到这一章节。

### Linux 用户管理涉及的文件

#### /etc/passwd

查看 passwd 的内容，每一行代表了一个用户例如第一行：

    root:x:0:0:root:/root:/bin/bash

各个域的含义依次如下：用户名，密码，UID，GID，用户描述，home 目录，shell。

出于安全考虑，用户的密码被加密之后保存在/etc/shadow 中，参见对 shadow 文件的描述。因此，在 passwd 文件中，密码均为 x。

详细参见 man 5 passwd

#### /etc/shadow

这个文件为 root 所有，只有属于 root 组或者使用 sudo 权限才能读取此文件的内容。该文件中的内容不应该泄漏给他人，以防止破解。各个域的含义如下：

<用户名>:<加密之后的密码>:<最后一次修改日期>:<密码最小生存期>:<密码最长生存期>:<警告期>:<密码非活动期>:<密码失效日期>:<保留>

详细参见 man shadow

#### /etc/group

第一行内容示例：

    root:x:0:

各个域的含义如下: 组名，组密码，组 ID，用户列表。

详细参见 man group

### Linux 用户管理命令

#### adduser

通常使用 adduser 来直接创建用户账户。

    adduser [-u uid] [-g gid] [-d home] [-s shell] username

参数解释如下：

- -u 直接给出 UID

- -g 直接给出 GID

- -d 直接将 home 目录设置为已经存在的目录

- -s 定义 shell 详细参见 man adduser

#### useradd

useradd 命令提供一种更低级也是更灵活的创建用户的命令。例如，创建一个用户，拥有 home 目录，shell 为 bash，具有普通用户权限，并且具有查看日志的权限，可以使用如下的命令

    sudo useradd -c "User Information"  -G adm -m -s /bin/bash  username

- -c 添加描述

- -G 此命令创建的用户属于与其用户名同名的组，同时添加用户到 adm 组，使其具有读取日志的权限

- -m 创建默认方式的 home 目录

- -s 设置 shell

详细参见 man useradd

#### passwd

passwd 命令用于设置和更新密码。示例：

    passwd username

这条命令为 username 修改密码。如果略去 username，则是给当前用户修改密码。

新版本的 Ubuntu 默认没有 root 密码，可以使用 sudo passwd 来设置 root 密码

示例：

    passwd -e username

这条命令使得 username 的密码失效，当 username 下一次登录的时候，输入自己的密码之后，系统强制要求更换密码。这条命令很适合于管理员给新用户创建账户时使用。

更多内容，参见 man passwd

#### userdel

userdel 用于删除用户。示例：

    userdel -r username

这条命令将删除 username 用户，-r 参数表示同时删除该用户的 home 目录及 home 目录下的内容。如果有邮件池(/var/mail/username)，则也一并删掉。

更多内容，参见 man userdel

#### 后记

用户管理命令对系统的影响重大，使用时需要相当谨慎。

### 来源声明

blog/user_adm.txt · 最后更改: 2013/04/29 08:04 (外部编辑)
