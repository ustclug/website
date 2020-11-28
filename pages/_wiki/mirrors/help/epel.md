---
---

# EPEL 镜像使用帮助

此处的帮助文档已经废弃，新的内容请访问 <https://mirrors.ustc.edu.cn/help/>

---

### 收录架构

- i386

- amd64

- SRPMS

- ppc64

### 使用说明

此源适用于 Red Hat, CentOS, Scientific Linux 版本 5 和 6

若存在则先备份/etc/yum.repos.d/epel.repo 和/etc/yum.repos.d/epel-testing.repo

下载下面的两个文件到/etc/yum.repos.d/

epel.repo:

    [epel]
    name=Extra Packages for Enterprise Linux 6 - $basearch
    baseurl=http://mirrors.ustc.edu.cn/epel/6/$basearch
    #mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=$basearch
    failovermethod=priority
    enabled=1
    gpgcheck=1
    gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
     
    [epel-debuginfo]
    name=Extra Packages for Enterprise Linux 6 - $basearch - Debug
    baseurl=http://mirrors.ustc.edu.cn/epel/6/$basearch/debug
    #mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-debug-6&arch=$basearch
    failovermethod=priority
    enabled=0
    gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
    gpgcheck=1
     
    [epel-source]
    name=Extra Packages for Enterprise Linux 6 - $basearch - Source
    baseurl=http://mirrors.ustc.edu.cn/epel/6/SRPMS
    #mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-source-6&arch=$basearch
    failovermethod=priority
    enabled=0
    gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
    gpgcheck=1

epel-testing.repo:

    [epel-testing]
    name=Extra Packages for Enterprise Linux 6 - Testing - $basearch
    baseurl=http://mirrors.ustc.edu.cn/epel/testing/6/$basearch
    #mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=testing-epel6&arch=$basearch
    failovermethod=priority
    enabled=0
    gpgcheck=1
    gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
     
    [epel-testing-debuginfo]
    name=Extra Packages for Enterprise Linux 6 - Testing - $basearch - Debug
    baseurl=http://mirrors.ustc.edu.cn/epel/testing/6/$basearch/debug
    #mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=testing-debug-epel6&arch=$basearch
    failovermethod=priority
    enabled=0
    gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
    gpgcheck=1
     
    [epel-testing-source]
    name=Extra Packages for Enterprise Linux 6 - Testing - $basearch - Source
    baseurl=http://mirrors.ustc.edu.cn/epel/testing/6/SRPMS
    #mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=testing-source-epel6&arch=$basearch
    failovermethod=priority
    enabled=0
    gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
    gpgcheck=1

运行 yum makecache

### 相关网站

- Wiki <http://fedoraproject.org/wiki/EPEL>

- FAQ[^faq] <http://fedoraproject.org/wiki/EPEL/faq>

[^faq]: Frequently Asked Questions
