---
---

# 替换及重置 Homebrew 默认源

    替换brew.git:
    cd "$(brew --repo)"
    git remote set-url origin https://mirrors.ustc.edu.cn/brew.git

    替换homebrew-core.git:
    cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
    git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git

替换 Homebrew Bottles 源: 参考:[替换 Homebrew Bottles 源](homebrew-bottles "https://lug.ustc.edu.cn/wiki/mirrors/help/homebrew-bottles")

在中科大源失效或宕机时可以： 1\. 使用[清华源设置参考](https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/ "https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/")。 2\. 切换回官方源：

    重置brew.git:
    cd "$(brew --repo)"
    git remote set-url origin https://github.com/Homebrew/brew.git

    重置homebrew-core.git:
    cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
    git remote set-url origin https://github.com/Homebrew/homebrew-core.git

注释掉 bash 配置文件里的有关 Homebrew Bottles 即可恢复官方源。 重启 bash 或让 bash 重读配置文件。
