---
---

# Rust Crates 镜像使用帮助

此处的帮助文档已经废弃，新的内容请访问 <https://mirrors.ustc.edu.cn/help/>

---

## 使用说明

在 \$HOME/.cargo/config 中添加如下内容

    [registry]
    index = "git://mirrors.ustc.edu.cn/crates.io-index"

如果所处的环境中不允许使用 git 协议, 可以把上述地址改为

    index = "http://mirrors.ustc.edu.cn/crates.io-index"

同步频率为每两个小时更新一次.

如果 cargo 版本为 0.13.0 或以上, 需要更改 \$HOME/.cargo/config 为以下内容:

    [source.crates-io]
    registry = "https://github.com/rust-lang/crates.io-index"
    replace-with = 'ustc'
    [source.ustc]
    registry = "git://mirrors.ustc.edu.cn/crates.io-index"

## 相关链接

官方主页: <https://crates.io/>
