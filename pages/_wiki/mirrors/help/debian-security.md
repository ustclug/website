---
---

# Debian Security 镜像使用帮助

此处的帮助文档已经废弃，新的内容请访问 <https://mirrors.ustc.edu.cn/help/>

---

### 收录架构

- i386

- amd64

- source

### 收录版本

- stable

- testing

### 使用说明

操作前请做好相应备份

一般情况下，更改 /etc/apt/sources.list 文件中 Debian Security 默认的源地址 <http://security.debian.org/> 为 <https://mirrors.ustc.edu.cn/debian-security> 即可。

可以使用如下命令：

    sudo sed -i 's/security.debian.org/mirrors.ustc.edu.cn\/debian-security/g' /etc/apt/sources.list

以 Jessie 为例, 编辑/etc/apt/sources.list 文件, 在文件最前面添加以下条目(操作前请做好相应备份)

sources.list:

    deb http://mirrors.ustc.edu.cn/debian-security/ jessie/updates main non-free contrib
    deb-src http://mirrors.ustc.edu.cn/debian-security/ jessie/updates main non-free contrib

### 相关链接

- 官方主页: <http://www.debian.org/>

- 邮件列表: <http://www.debian.org/support#mail_lists>

- Wiki: <http://wiki.debian.org/>

- 文档: <http://www.debian.org/doc/>

- 镜像列表: <http://www.debian.org/mirror/list>
