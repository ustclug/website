---
---

# PyPI 镜像使用帮助

此处的帮助文档已经废弃，新的内容请访问 <https://mirrors.ustc.edu.cn/help/>

科大源目前暂不提供 PyPI 镜像或反代。

---

如何使用科大 mirrors 加速 pip？

编辑 ~/.pip/pip.conf 文件（如果没有则创建之），将 index-url 开头的一行修改为下面一行：

    index-url = https://mirrors.ustc.edu.cn/pypi/web/simple

如果运行 pip 时, 提示如下错误

    configparser.MissingSectionHeaderError: File contains no section headers.

请在 ~/.pip/pip.conf 最上方加上 [global] 这一 section header

如：

pip.conf:

    [global]
    index-url = https://mirrors.ustc.edu.cn/pypi/web/simple
    format = columns

## 同步方式

使用 bandersnatch，每 4 小时从 pypi.python.org 官方同步。

## 相关链接

- PyPI Official Mirrors: <https://pypi.python.org/mirrors>

- PEP-381 Mirroring Protocol: <http://www.python.org/dev/peps/pep-0381/>

- bandersnatch: <https://pypi.python.org/pypi/bandersnatch>
