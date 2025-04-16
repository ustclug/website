---
redirect_from: /wiki/user/taoky/howtoask/
---

# 提问指南

License: CC-BY-NC-SA 4.0

## 为什么需要再写一份这样的指南 {#why-this-guide}

网上已经有一些关于如何提问的文档，例如：

- 提问的智慧（[原文](http://www.catb.org/~esr/faqs/smart-questions.html)，[中文](/wiki/doc/smart-questions/)）
- [别傻傻地提问](https://github.com/tangx/Stop-Ask-Questions-The-Stupid-Ways/blob/master/README.md)

本文不是这些文档的翻版。我们希望通过更加简洁、清晰、友好的语言，帮助同学们快速了解提问注意事项。

本文涉及到的真实例子会做匿名化处理。我们希望读者在遇到类似问题时，能够结合自己的实际情况进行思考，而不是机械地执行检查单。

## 提问之前 {#before-asking}

在求助他人之前，不妨先自己分析一下问题，这样既能问得更准确，节省他人时间，也能加深对问题的理解。

### 阅读已有的信息 {#read-existing-info}

多数错误伴随着错误信息（error message），这是解决问题的第一步。想要帮助你的人通常也需要这些信息，所以不妨自己先行阅读它们。一些基本的技巧包括：

- 错误信息多为英文，不过无需担心，开发者通常不会使用太复杂的语法或词汇（不妨这样想：很多开发者的英文水平可能并不如你）
  > 如果你实在克服不了语言障碍，不妨尝试使用 DeepL、Google Translate 等翻译软件，或者借助大语言模型来帮助理解错误信息。
- 程序日志一般分为 info、warn（warning、W）、error（E）等级别。通常情况下，请优先关注**第一个出现的 error/warning** 信息，因为后续错误往往只是前面的延伸。

  > 有些程序前置的错误信息内容可能信息量较低，例如 `subprocess xxx returned error code xxx` 这类提示，只能表明某个进程出错了，但是不包含具体原因。直接搜索的话效果会很差，故需要定位并搜索最初发出的错误信息。

- 如果你不知道在哪里找到日志，那么建议先解决日志的问题，毕竟没有这些信息，其他人也只能摸着水晶球来猜测到底发生什么了。

下面是这个过程中一些错误示范：

- 例 1：镜像站怎么挂了

  对应提问的截图中的错误信息节选：

  ```console
  E: 无法下载 http://mirrors.ustc.edu.cn/ubuntu/pool/main/g/gcc-11/g%2b%2b-11_11.3.0-1ubuntu%7e22.04_amd64.deb  404  Not Found [IP: 202.38.95.110 443]
  E: 有几个软件包无法下载，要不运行 apt-get update 或者加上 --fix-missing 的选项再试试？
  user@hostname:~/桌面$
  ```

  可以看到，这里的输出已经给出很清晰的建议了，需要执行一下 `apt-get update` 命令。把这样的错误信息截图发到群里，也许是一件不太负责的事情。

- 例 2：为什么我装不了 `pytorch`

  执行的命令与错误信息：

  ```console
  $ pip install pytorch
  Collecting pytorch
    Downloading pytorch-1.0.2.tar.gz (689 bytes)
    Preparing metadata (setup.py) ... done
  Building wheels for collected packages: pytorch
    Building wheel for pytorch (setup.py) ... error
    error: subprocess-exited-with-error

    × python setup.py bdist_wheel did not run successfully.
    │ exit code: 1
    ╰─> [6 lines of output]
        Traceback (most recent call last):
          File "<string>", line 2, in <module>
          File "<pip-setuptools-caller>", line 34, in <module>
          File "/tmp/pip-install-ol4_fzbu/pytorch_308e04ef51d74e3a93b1f4be765a77bd/setup.py", line 15, in <module>
            raise Exception(message)
        Exception: You tried to install "pytorch". The package named for PyTorch is "torch"
        [end of output]

    note: This error originates from a subprocess, and is likely not a problem with pip.
    ERROR: Failed building wheel for pytorch
    Running setup.py clean for pytorch
  Failed to build pytorch
  ERROR: Could not build wheels for pytorch, which is required to install pyproject.toml-based projects

  [notice] A new release of pip is available: 23.2.1 -> 24.0
  [notice] To update, run: pip install --upgrade pip
  ```

  错误提示显示异常（exception）的内容是 `You tried to install "pytorch". The package named for PyTorch is "torch"`，说明要安装的软件包的名字是 `torch`，而非 `pytorch`，因此将命令从 `pip install pytorch` 改成 `pip install torch` 即可。

- 反例：为什么我的程序编译不了

  ```console
  $ gcc myporgram.c
  cc1: fatal error: myporgram.c: No such file or directory
  compilation terminated.
  ```

  可以看到，输出中报错信息明确了是 `No such file or directory`（没有对应的文件或文件夹），说明程序找不到指定的文件。仔细检查便可发现是命令里面把文件名敲错了。

### 利用搜索引擎等工具 {#use-search-engine}

尽管近几年大语言模型发展迅速，但是搜索引擎在解决问题方面仍然不可或缺。

#### 选择搜索引擎 {#choose-search-engine}

作为业界不成文的「共识」，对常用搜索引擎的排序是：谷歌 > 必应国际版 > 必应国内版 > 百度。可以都试试，根据自己的实际情况选择。

以下主要介绍通用搜索引擎的信息。在特定场景下，以下方式可能会更加合理：

- 使用包含网页搜索功能的大语言模型（例如 [Deepseek 联网搜索](https://chat.deepseek.com)）直接询问
- 使用特定领域的搜索引擎，例如：
  - [Google Scholar](https://scholar.google.com/)、[知网](https://www.cnki.net/)等搜索论文
  - 使用 [OEIS](https://oeis.org/) 搜索整数序列
  - 使用 [Debian Code Search](https://codesearch.debian.net/) 查找 Debian 上所有软件包的源代码，也可用 [GitHub](https://github.com) 搜索其存放的公开代码
  - 部分站点或服务会拒绝通用搜索引擎索引，需要使用其手机 App 或合作方网站搜索（例如微信公众号、小红书等）

#### 搜索相关项目的手册/FAQ 等信息 {#search-docs}

在某些场景下，直接搜索对应项目的帮助文档、手册、FAQ 等是比搜索报错信息更好的选择。例如，在使用 Python 的 `argparse` 模块遇到问题时，最好先查阅手册寻找答案：

```text
python argparse
```

在搜索这类关键字时，合格的搜索引擎应该能将相关手册等关键信息优先显示。当然，日积月累，你也会对这些手册的位置有一个大致的了解。作为参考，以下列举了一些手册与文档信息：

- Linux 命令：`man 需要查询的命令`
- Arch Linux：[Arch Wiki](https://wiki.archlinux.org/)
- Python：[Python 官方文档](https://docs.python.org/3/)
- C 与 C++：[cppreference](https://en.cppreference.com/w/)

#### 使用合适的查询 {#use-proper-query}

最简单的几个技巧：

- 去掉「为什么」之类的副词与「的」等助词（尽管现代搜索引擎通常会忽略这些内容）
- 使用空格分割关键词
- 去掉不具备普遍性的内容：例如用户名、文件名、变量名等不会影响问题的信息
- 善于使用搜索引擎的特殊功能。大部分搜索引擎都支持下述功能：

  - 搜索运算符：用半角双引号 `"关键词"` 可精确匹配内容，`+关键词` 表示必须包含该词，`-关键词` 则表示排除该词。

    因此如果你的搜索内容本身就带 `-` 符号，请去掉它。

  - `site:` 标识符：例如输入 `site:example.com Something`，就能让搜索引擎只在 `example.com` 这个网站内搜索。

- 当工具出现错误代码时，直接搜索 `工具名称 错误代码` 比搜索错误提示更有效。
- 使用英语：支持多语言的工具（比如上文的 `apt`）在互联网上往往是英文内容比中文多。如果中文结果无法解决问题，不妨试试将工具语言切换回英文。

以这个问题为例：

```text
为什么我运行 apt update 会输出这个：
Reading package lists... Done
E: Could not open lock file /var/lib/apt/lists/lock - open (13: Permission denied)
E: Unable to lock directory /var/lib/apt/lists/
W: Problem unlinking the file /var/cache/apt/pkgcache.bin - RemoveCaches (13: Permission denied)
W: Problem unlinking the file /var/cache/apt/srcpkgcache.bin - RemoveCaches (13: Permission denied)
```

首先判断最重要的信息，进行调整：

```text
为什么我运行 apt update 会输出这个：E: Could not open lock file /var/lib/apt/lists/lock - open (13: Permission denied)
```

接下来可以用上述简单策略来处理查询：

```text
apt update 输出 E: Could not open lock file /var/lib/apt/lists/lock - open (13: Permission denied)
```

（连「输出」这两个字甚至也可以不要）

直接贴到任何搜索引擎，无论是必应、谷歌还是百度，都能找到对应的解决方法。

#### 筛选结果 {#filter-results}

部分搜索引擎会在结果中返回广告，可以在浏览器中安装去广告扩展（例如 uBlock Origin）来屏蔽这些内容。

有一小部分网站（大多出于商业目的）会不加选择地收集垃圾内容，甚至想方设法欺骗搜索引擎，使其误判为有效信息。这些网站被称为「内容农场」。这些网站提供的信息对解决问题没什么帮助。有关内容农场的特征等信息，可以阅读这篇「少数派」的文章：[清理「内容农场」，还你清爽的 Google 中文搜索体验](https://sspai.com/post/69407)。

对于搜索得到的结果，目前普遍不成文的认识是：一些网站的内容质量（例如 CSDN）相对更低，中文结果的平均质量也不如英文（很遗憾，这也是更推荐使用英文搜索的原因之一）。在读者逐渐熟练使用搜索引擎后，应该能对不同质量的结果有一个更清晰的判断。

### 其他信息 {#other-info}

自 2023 年初大语言模型（GPT 等）逐渐普及以来，询问大语言模型已成为解决问题的有效途径，而且比真人更有耐心。不过这同样需要技巧，请参考本文「[附录：如何正确向大语言模型提问](#llm)」。

## 提问时的注意事项 {#when-asking}

### 避免 X-Y 型问题 {#avoid-xy}

X-Y 型问题指代这类情况：

1. 你遇到了 X 问题，你认为用 Y 方法可以解决 X 问题
2. 但是你遇到了阻碍，因此向别人提问关于 Y 的问题，而不告诉其他人最原本的 X 问题
3. 如果用 Y 方法解决 X 问题的思路本身便是错误的，那么这样的提问也是无效的

以下摘录了陈皓先生在他的博客中介绍 X-Y 型问题（[Web Archive](https://web.archive.org/web/20240309145853/https://coolshell.cn/articles/10804.html)）时的例子：

- 例子 1：获取字符串后三位字符？

  ```text
  Q: 我怎么用 Shell 取得一个字符串的后 3 位字符？
  A1: 如果这个字符的变量是$foo，你可以这样来 echo ${foo:-3}
  A2: 为什么你要取后 3 位？你想干什么？
  Q: 其实我就想取文件的扩展名
  A1: 我靠，原来你要干这事，那我的方法不对，文件的扩展名并不保证一定有 3 位啊。
  A1: 如果你的文件必然有扩展名的话，你可以这样来：echo ${foo##*.}
  ```

- 例子 2：获取文件大小？

  ```text
  Q: 问一下大家，我如何得到一个文件的大小
  A1: size = ls -l $file  | awk '{print $5}'
  Q: 哦，要是这个文件名是个目录呢？
  A2: 用 du 吧
  A3: 不好意思，你到底是要文件的大小还是目录的大小？你到底要干什么？
  Q: 我想把一个目录下的每个文件的每个块（第一个块有 512 个字节）拿出来做 md5，并且计算他们的大小……
  A1: 哦，你可以使用 dd 吧。
  A2: dd 不行吧。
  A3: 你用 md5 来计算这些块的目的是什么？你究竟想干什么啊？
  Q: 其实，我想写一个网盘，对于小文件就直接传输了，对于大文件我想分块做增量同步。
  A2: 用 rsync 啊，你妹！
  ```

- 我们补充另一个真实的例子（经过大幅简化）：

  ```text
  Q: 有没有人在导入的时候遇到 TypeError: Can't create an SSLContext object without an ssl module? 的报错？
  A1: 你编译的时候没加 ssl 模块吗
  Q: 加了，我看了 csdn 上的教程 [截图]
  A2: 你这教程怎么把源代码目录移动到 /usr/lib 下面啊，换个教程吧
  A3: 等等，为什么你要自己编译 python？你在用什么发行版？
  Q: Ubuntu 20.04，我没找到 python3 在哪里
  A3: 20.04 不是自带的 Python 3.8 吗？这个不够用吗？
  Q: 不是，我直接跑 python 出来的是 python2
  A2: 装 python-is-python3
  A3: 20.04 源里面也有 3.9，可以直接 install python3.9
  ```

### 直接提问，避免使用「在吗」/「有人吗」 {#ask-directly}

在私聊中，直接提问比先只问「在吗」更高效。考虑这个虚构的例子：

```text
A (8:00): 在吗？
B (13:00): 怎么了？
A (15:00): 我遇到了 XXXXXXX 错误，然后 YYYY 命令跑不了，怎么办？
B (16:00): 你应该 ZZZZZZZ
```

对比一下直接问：

```text
A (8:00): Hi，我遇到了 XXXXXXX 错误，然后 YYYY 命令跑不了，怎么办？
B (13:00): 这样，你应该 ZZZZZZZ
```

群聊中也是如此，只是出于礼貌的话，额外“握手”一次反而显得浪费时间。

### 避免「有没有人懂」 {#justask}

不要在群聊里面这样问：

```text
有没有人懂 C++？有个问题想问问
```

原因如下：

- C++ 是非常复杂的，没有多少人真的懂/精通 C++。对很多别的领域也是类似的。
- 就算真的有人懂，懂的人很可能也不想在群里显摆自己。不太懂的人就更没有兴趣看你的问题了。
- 这类问题往往属于常识范畴，不精通相关领域的人也可以回答。

一个改善后相对好一些的提问是：

```text
我遇到了一个问题，我的 C++ 程序需要运行一个 CUDA kernel，我要怎么写 cmake 来编译这个 kernel 并且让我的程序调用？
```

相关论述可参考 [不要问有没有人，请直接问](https://fars.ee/~justask.html)。

### 尽可能提供「最小可复现样例」 {#mre}

**最小可复现样例**（Minimal reproducible example，MRE）是一段**完整、精简**的程序代码或者执行流程，**不包含与错误无关的部分**。这通常只包含出现问题的核心几行代码、命令、以及最小依赖项。你可以复制当前的工程，通过二分法逐步删除无关部分，并保留原有错误来制作 MRE。和上面自行阅读错误信息的过程类似，你自己可能就会发现其中的问题。

不妨换个角度思考：当提问者只提供一段冗长代码，包含大量第三方库和自定义结构体、类方法时，缺少这些关键信息会让回答者无从下手。提问者若直接提供全部代码，恐怕很少有人愿意帮忙调试几百行的程序，更不用说配置复杂的运行环境了。

> MRE 的提供能平衡提问者和回答者的时间，虽然需要提问者花费更多准备时间和一定技巧，但有助于准确定位问题。

### 提供必要的问题描述与相关信息 {#provide-necessary-info}

需要说明的内容包括：

- 具体问题是什么
- 引发问题的命令/代码
- 报错信息（注：如上文所述，通常只有前几条报错信息是关键的，建议先从前面的有效报错开始提问）
- 自己尝试过用什么方法解决
- 系统与软件的版本信息（例如，如果你想在一个主要讨论 Linux 的群里面问 Windows 下的问题，务必把这一点说清楚）

这是一个在 Linux 讨论群里的反例：

```text
Q: 怎么在命令行里面下载一个 url？
A: curl http://example.com > example.html
Q: 不对啊，我下载下来不是 html 文件，是一堆乱七八糟的东西
A: 嗯？
Q: 比如说 StatusCode, StatusDescription 这些，还有不少乱码
A: 啊？你这个 URL 是什么？
....
A: 要不发个截图？
Q: [截图]
....
A: 你在用 Windows？装 curl 了吗？
A2: 这个是 PowerShell 那个假 curl 吧
A2: 要用 curl.exe 调用才行
```

如果提问者在一开始就说清楚自己在 Windows 下，那么这个问题可能会更快得到解决。

报告错误时请直接提供原始输出，不要自行翻译。建议在开发者的语言（通常是英语）环境下复现错误，获得更准确的提示信息，帮助其他人定位你的问题。建议将错误信息复制后发送，而不是自己手动对着敲一遍；如果原文内容过长，可以参考下一节内容来使用 Pastebin 等工具分享完整文本。

在 Linux 系统中，可以使用以下方法设置程序运行的语言：

```shell
# 指定语言为美式英语
LC_ALL=en_US.UTF-8 你的命令
# 指定语言为简体中文
LC_ALL=zh_CN.UTF-8 你的命令
```

### 使用代码片段服务分享问题相关的代码与报错 {#use-pastebin}

代码和报错信息如果太长，直接截图或贴到群聊里可能不太合适：

- 截图里的代码不方便他人直接使用，既难以 OCR 识别，也没人愿意手动转录。
- 较长的信息直接发送会影响他人阅读前面内容，也不够美观（尤其在不支持代码块的 QQ、微信等聊天软件中）
- 某些聊天软件会把特殊字符自动转换成表情符号，使得文本难以阅读

虽然聊天等场景支持上传文件，但在某些场合（如群聊）直接上传文件可能不太合适，管理员通常不希望群共享里堆满杂乱代码。部分网站提供了存储长文本的功能（注意一些网站可能无法直接访问）：

- GitHub 对应 [GitHub Gist](https://gist.github.com/)
- GitLab 对应其 [Snippets](https://gitlab.com/dashboard/snippets) 功能
- 独立的 Pastebin 类服务，例如 [Ubuntu pastebin](https://paste.ubuntu.com/)，[Pastebin.com](http://Pastebin.com) 等

科大校内的同学可以使用校内 GitLab（[超算中心](https://git.ustc.edu.cn/) 或 [LUG](https://git.lug.ustc.edu.cn/)）的 Snippets。

一个反例是：

```text
我的 vulkan 程序在 wayland 下没有显示出来，托盘那里有程序的图标，怎么回事？
```

这个问题的反例原因在于：

- 没有提供任何代码，要知道 Vulkan 画个三角形都要写一千多行代码
- 环境信息不够详细：比如 Wayland 主要依赖混成器实现，建议说明具体使用的桌面环境，如 KDE；Vulkan 作为图形接口较为宽泛，最好补充相关图形库信息，例如是否使用了 GLFW 绘制窗口。

### 避免拍屏 {#use-screenshots}

除非实在无法截图（例如系统启动阶段），否则不要拍屏，因为：

- 不美观
- 因为[莫尔纹](https://en.wikipedia.org/wiki/Moir%C3%A9_pattern)现象，字/图像可能会拍不清楚
- 其他人可能得歪着头才能看清内容
- 不利于其他人搜索类似问题

## 无人应答 {#if-no-answer}

没人回答问题不等于被无视。在群聊中，认真提问却无人回应，往往只是因为看到问题的人都不知道答案罢了。也要注意，群聊或论坛里的陌生人并没有义务回答你的问题。

可以考虑从以下一些方式解决问题：

- 线下咨询。
  - Tip: [LUG 在西区与高新区的活动室](/wiki/lug/contact/#%E9%9D%A2%E5%AF%B9%E9%9D%A2%E4%BA%A4%E6%B5%81)，只要房间里有人就可以进来，来之前建议先在群里问一下
- 向对应服务/软件的维护人员提交工单
  - Tip: 科大网络信息中心报修系统 <https://baoxiu.ustc.edu.cn/>

## 附录：如何正确向大语言模型提问 {#llm}

### 请先阅读正文内容，再阅读本部分 {#read-main-content-first}

对人类有效的提问策略，大多对大语言模型（LLM）也有效。

### 提供足够的上下文信息 {#provide-context}

和向人类提问类似，提供足够的上下文信息可以更好帮助大语言模型理解问题，给出更好的回答。以刚才的例子为例。

原始例子：

````text
Human: 怎么在命令行里面下载一个 url？
LLM: 在命令行里下载一个 URL，常用的两个工具是 `curl` 和 `wget`。以下是它们的基本用法：

---

### 1. 使用 `curl`

```bash
curl -O https://example.com/filename.zip
```

- `-O`：表示使用远程文件的原始名字保存文件。

若你想自定义保存的文件名：

```bash
curl -o myfile.zip https://example.com/filename.zip
```

如果是需要跳过 SSL 检查的网站，可以加上 `-k`：

```bash
curl -k -O https://example.com/filename.zip
```

---

### 2. 使用 `wget`

如果你的系统里安装了 `wget`，可以这样用：

```bash
wget https://example.com/filename.zip
```

和 `curl` 类似，也可以添加选项如：

- `--no-check-certificate`：跳过证书检查。
- `-O myfile.zip`：指定保存文件名。

例如：

```bash
wget -O myfile.zip https://example.com/filename.zip
```

---

### 安装这些工具（如果没有）

在 Linux/macOS 系统中，你可以通过包管理器安装：

- macOS (使用 Homebrew):
  ```bash
brew install curl
brew install wget
  ```

- Ubuntu/Debian:
  ```bash
sudo apt install curl
sudo apt install wget
  ```

---

### 简要对比

| 特性   | `curl`                | `wget`                |
|--------|------------------------|------------------------|
| 支持协议 | HTTP, FTP, SFTP 等    | HTTP, FTP 等            |
| 默认行为 | 输出到终端          | 保存为文件              |
| 下载多个文件 | 支持，但需脚本处理 | 支持 `-i` 或输入文件列表  |

---

如果你告诉我你是用 Windows / Linux / macOS，我可以给你更具体的命令。
````

改进后的例子：

````text
Human: 在 Windows Powershell 下，怎么在命令行里面下载一个 url？直接给命令即可。
LLM: 在 Windows PowerShell 中，你可以使用以下命令下载一个 URL：

```powershell
Invoke-WebRequest -Uri "https://example.com/file.zip" -OutFile "file.zip"
```

请将其中的 `https://example.com/file.zip` 替换为你要下载的实际 URL，`file.zip` 替换为你希望保存的文件名。
````

这里相比原始版本增加了以下信息：

- 环境是 Windows PowerShell
- 希望 LLM 直接输出命令

得到的结果就更加简洁，也更加符合用户需求，毕竟很多 Windows 用户的电脑里可能根本没有 wget 或 curl。

### 提问语言 {#ask-language}

在大语言模型的训练语料中往往英文占比更高，因此用英文提问可能效果更好。国产的大语言模型可能可以缓解这个问题。

### 避免超长的对话 {#avoid-long-dialog}

大语言模型的工作模式很简单：每次用户发送消息时，LLM 都会从头分析内容，直到用户本次信息结束才开始生成。这带来了两个问题：

- 对于超长的对话，每一次继续对话都会浪费不少的钱。假设当前的对话前，LLM 分析了一个很长的网页，花费了一块钱，那么基于这段对话作为背景，**每次**发送一条消息，都会再花至少一块钱。
- 相比于短文本，LLM 对长文本更容易产生「**幻觉**」，即输出与实际情况不相符的内容。

如果发现 LLM 工作异常，可以重启会话。重新开始后，更应该调整提问的策略。
