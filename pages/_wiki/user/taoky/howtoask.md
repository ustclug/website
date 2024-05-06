---
---

# 提问指南

**<i class="fas fa-exclamation-triangle"></i> 注意：**本文为草稿，内容可能随时更改。
{: .notice--warning }

License: CC-BY-NC-SA 4.0

## 为什么需要再写一份这样的指南

关于如何提问，有一些相关的文档，诸如：

- 提问的智慧（[原文](http://www.catb.org/~esr/faqs/smart-questions.html)，[中文](https://lug.ustc.edu.cn/wiki/doc/smart-questions/)）
- [别像弱智一样提问](https://github.com/tangx/Stop-Ask-Questions-The-Stupid-Ways/blob/master/README.md)

本文不是这些文档的替代，而是旨在用简洁、清晰、友好的语言表述与提问相关的注意事项，并且给出相关的正例与反例（真实的例子会做匿名化处理），以便快速了解相关的注意点。

也需要注意的是，以下内容不是能够机械性执行的检查单，注意需要「具体问题具体分析」。

## 提问之前

请先尝试自己解决问题：有的时候解决方法比想像的要简单得多（并且自己解决也比问别人快得多）。以下会给出一些问题解决的通用思路。

### 阅读已有的信息

很多时候遇到的问题会伴随着错误信息，至少分一点点耐心去读一下错误信息可能对解决问题很有帮助。如果有能力的话，尝试从日志等地方收集相关的信息也很可能会有帮助。

当然不少错误信息都是英语，不过能来到科大的同学高考大概都是需要考英语的，错误信息大部分时候都不会包含长难复杂句式（比高考英语的难阅读理解简单）。实在不行的话，借助词典或者机器翻译软件（考虑近年深度学习的巨大进步，2024 年的机器翻译发展水平已经很高了；并且计算机领域的词汇也就那些），也可以帮助阅读并尝试理解含义。

- 反例：镜像站怎么挂了

  对应提问的截图中的错误信息节选：

  ```console
  E: 无法下载 http://mirrors.ustc.edu.cn/ubuntu/pool/main/g/gcc-11/g%2b%2b-11_11.3.0-1ubuntu%7e22.04_amd64.deb  404  Not Found [IP: 202.38.95.110 443]
  E: 有几个软件包无法下载，要不运行 apt-get update 或者加上 --fix-missing 的选项再试试？
  user@hostname:~/桌面$
  ```

  这里从图上命令输出的最后一行就可以看到，`apt` 给出了运行 `apt-get update` 的建议。如果甚至都没有去试一试就直接截个图问别人，那么很不幸，得不到好脸色恐怕也是意料之中的事情。

- 反例：为什么我装不了 pytorch

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

  可以看到，异常（exception）的内容是 `You tried to install "pytorch". The package named for PyTorch is "torch"`，意思就是说，要安装的东西的名字应该是 torch 而不是 pytorch，所以解决方法就是跑的命令从 `pip install pytorch` 改成 `pip install torch`。

- 反例：为什么我的程序编译不了

  ```console
  $ gcc myporgram.c
  cc1: fatal error: myporgram.c: No such file or directory
  compilation terminated.
  ```

  可以看到，输出中报错信息明确了是 `No such file or directory`（没有对应的文件或文件夹），代表给的文件程序找不到。仔细检查可以发现是命令里面把名字敲错了。

### 利用搜索引擎等工具

尽管近两年大语言模型发展迅速，但是搜索引擎在解决问题上仍然有着不可或缺的作用。

#### 选择搜索引擎

作为业界不成文的「共识」，对常用搜索引擎的排序是：谷歌 > 必应国际版 > 必应国内版 > 百度。可以都试试，根据自己的实际情况选择。

#### 搜索相关项目的手册/FAQ 等信息

在某些场景下，直接搜索对应项目的帮助文档、手册、FAQ 等是比搜索报错信息更好的选择。例如，如果我在使用 Python 的 `argparse` 模块时遇到了问题，可能最好的方式是先搜索其手册信息，在手册中寻找需要的内容：

```
python argparse
```

（这么搜索对于合格的搜索引擎，足以将其手册等关键信息排在结果最前面）

#### 使用合适的查询

最简单的几个技巧：

- 去掉「为什么」这样的副词与「的」这样的助词
- 使用空格分割搜索关键词
- 去掉只在你的计算机上有的信息（比如说用户名、主机名——比如如果你的用户名是 john123，并且搜索的时候带上了输出里面的 john123，那么搜索引擎可能会尽量匹配结果里面有 john123 的结果，这在几乎所有的时候都是不符合预期的）
- 可能需要去掉查询里面的横线 `-`：搜索引擎很可能将其解释为「以横线（减号）开头的查询词不允许包含在结果中」

作为一个例子，对于下面这个「问题」：

```
为什么我运行 apt update 会输出这个：
Reading package lists... Done
E: Could not open lock file /var/lib/apt/lists/lock - open (13: Permission denied)
E: Unable to lock directory /var/lib/apt/lists/
W: Problem unlinking the file /var/cache/apt/pkgcache.bin - RemoveCaches (13: Permission denied)
W: Problem unlinking the file /var/cache/apt/srcpkgcache.bin - RemoveCaches (13: Permission denied)
```

首先判断（最）重要的信息，并且调整：

```
为什么我运行 apt update 会输出这个：E: Could not open lock file /var/lib/apt/lists/lock - open (13: Permission denied)
```

然后使用上面的简单策略处理查询：

```
apt update 输出 E: Could not open lock file /var/lib/apt/lists/lock - open (13: Permission denied)
```

（「输出」这两个字甚至也可以不要）

直接贴到任何搜索引擎（必应/谷歌），甚至百度给出的结果链接都是对应的解决方法。

#### 筛选结果

搜索引擎可能会返回广告，可以考虑为自己的浏览器安装反广告扩展（例如 uBlock Origin）排除这一部分内容。

有一小部分网站（大多出于商业目的）会不加选择地收集垃圾内容，并且不择手段让搜索引擎相信它们包含有效的信息。这些网站被称为「内容农场」。这些网站的内容当然对解决你的问题也基本上不会有帮助。有关内容农场的特征等信息，可以阅读「少数派」的文章：[清理「内容农场」，还你清爽的 Google 中文搜索体验](https://sspai.com/post/69407)。

对于搜索得到的结果，目前普遍（同样不成文）的认识是：一些网站的内容质量（例如 CSDN）普遍比其他的更低，中文结果的平均质量比英文结果低（很遗憾，这也是为什么更推荐使用英文搜索的重要原因之一）。在逐渐使用搜索引擎的过程中，对不同结果的质量也可以有更清晰的判断。

### 其他信息

从 2023 年初开始，大语言模型（GPT 等）逐渐普及。询问大语言模型同样也是很有效的问题解决途径（并且确实比真人更有耐心）。不过，这不代表不需要任何技巧，大语言模型就会自动施展魔法解决所有问题。有关详细信息，请参考本文「附录：如何正确向大语言模型提问」。

## 提问时的注意事项

### 避免 X-Y 型问题

X-Y 型问题指代这样一种情况：你遇到了 X 问题，你相信用 Y 方法可以解决 X 问题，但是不知道怎么使用，因此向别人提问如何使用 Y 的问题，而不告诉其他人 X 问题的内容。如果用 Y 方法解决 X 问题的思路是错误的，那么这样的提问就是浪费时间。

在去年（2023）离世的陈皓先生曾在他的博客中介绍了 X-Y 型问题（[Web Archive](https://web.archive.org/web/20240309145853/https://coolshell.cn/articles/10804.html)），由于其原始博客目前无法直接访问，以下摘录了其中提及的例子。

- 例子 1：获取字符串后三位字符？

  ```
  Q: 我怎么用 Shell 取得一个字符串的后 3 位字符？
  A1: 如果这个字符的变量是$foo，你可以这样来 echo ${foo:-3}
  A2: 为什么你要取后 3 位？你想干什么？
  Q: 其实我就想取文件的扩展名
  A1: 我靠，原来你要干这事，那我的方法不对，文件的扩展名并不保证一定有 3 位啊。
  A1: 如果你的文件必然有扩展名的话，你可以这样来：echo ${foo##*.}
  ```

- 例子 2：获取文件大小？

  ```
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

### 避免「在吗」/「有人吗」

在私聊的场合下，直接提问比先只问「在吗」是更好、效率更高的选择，否则参考这个（虚构的）例子：

```
A (8:00): 在吗？
B (13:00): 怎么了？
A (15:00): 我遇到了 XXXXXXX 错误，然后 YYYY 命令跑不了，怎么办？
B (16:00): 你应该 ZZZZZZZ
```

对比一下直接问：

```
A (8:00): Hi，我遇到了 XXXXXXX 错误，然后 YYYY 命令跑不了，怎么办？
B (13:00): 这样，你应该 ZZZZZZZ
```

同样在群聊的场景下，直接问问题比问「有人吗」是更好的选择——毕竟其他人有充分的理由不理你（当然，如果你是群里的大红人，可能是另外一回事）。

### 避免「有没有人懂」

一个糟糕的例子是在群聊里面问：

```
有没有人懂 C++？有个问题想问问
```

原因如下：

- C++ 是非常复杂的，没有多少人真的懂/精通 C++。对很多别的领域也是类似的。
- 就算真的有人懂，懂的人很可能也不想在群里（通过回答这样的问题）夸耀自己很懂。而不太懂的人就更没有兴趣看你的问题了。
- 很多时候对应的问题即使是不精通相关领域的人也可以回答，对应的问题可能是某种常识。

一个改善后相对好一些的提问是：

```
我遇到了一个问题，我的 C++ 程序需要运行一个 CUDA kernel，我要怎么写 cmake 来编译这个 kernel 并且让我的程序调用？
```

相关论述可参考 [不要问有没有人，请直接问](https://fars.ee/~justask.html)。

### 尽可能提供「最小可复现样例」

很少会有人愿意自愿帮助别人调试几百行的代码，或者配置一致的非常复杂的环境，因此**最小可复现样例**（Minimal reproducible example，MRE）可以很大程度帮助他人调试，并且在某些情况下甚至可以直接定位问题。最小可复现样例一般是一个**完整**的程序代码或者执行流程，与产生错误**无关的部分不包含**在这样的样例里面。

一种类型的反例是：只给了一段无法直接编译的很长的函数，函数里面调用了各种第三方库或者自己的结构体/类的方法，但是这些信息不在提供的内容中，这会给解决问题带来不小的困难。

### 提供必要的问题描述与相关信息

必要的描述与信息可能包括：

- 具体问题是什么
- 引发问题的命令/代码
- 报错信息
- 自己尝试过用什么方法解决
- 系统与软件的版本信息（例如，如果你想在一个主要讨论 Linux 的群里面问 Windows 下的问题，务必把这一点说清楚）

### 使用 Snippet/Gist/Pastebin 类型服务放问题相关的代码与报错

代码和报错信息可能会非常长，此时截图或者直接文本贴到群聊里面可能不是一个合适的选择

- 截图，特别是代码，如果其他人想跑你的代码，OCR 可能会有问题，而且也没有人会想自己人肉 OCR。
- 对于比较长的信息，直接发送会影响其他人阅读前面的信息，并且不美观（特别是不支持代码块样式的聊天软件，例如 QQ/微信）

尽管诸如聊天等场景下可以上传文件，在一些场合直接上传文件可能会不受欢迎（例如群聊的管理员可能不希望群共享文件里面都是乱七八糟的代码）。一些网站提供了存储长文本的功能（注意一些网站可能无法直接访问）：

- GitHub 对应 [GitHub Gist](https://gist.github.com/)
- GitLab 对应其 [Snippets](https://gitlab.com/dashboard/snippets) 功能
- 独立的 Pastebin 类型服务，例如 [Ubuntu pastebin](https://paste.ubuntu.com/)，[Pastebin.com](http://Pastebin.com) 等

对于科大校内的同学，可以使用校内 GitLab（[超算中心](https://git.ustc.edu.cn/) 或 [LUG](https://git.lug.ustc.edu.cn/)）的 Snippets。

### 避免拍屏

除非实在无法截图，否则不要拍屏，因为：

- 不美观
- 字/图像可能会拍不清楚
- 其他人可能需要扭脖子才能正确看到内容

## 如果没有人回答

没有人回答问题 ≠ 被无视，在群聊中，如果认真提问却没有人回答，更有可能发生的事情是：看到问题的人完全不知道如何解决，仅此而已。同时也需要注意，群聊中（或者论坛中）的其他与你素不相识的人也没有必须回答问题的义务。

可以考虑从以下一些方式解决问题：

- 线下咨询。
  - Tip: LUG 在西区与高新区的活动室，只要房间里有人就可以进来（可以来之前在群里问一下）
- 向对应服务/软件的维护人员提交工单
  - Tip: 科大网络信息中心报修系统 <https://baoxiu.ustc.edu.cn/>

## 附录：如何正确向大语言模型提问

### 阅读本部分前，先阅读正文内容

对人类有效的提问策略，大多对大语言模型也有效。

### Be concise

有的时候（特别是对规模很大的语言模型），大语言模型会事无巨细地列出从安装到写代码的每一步，但是很多时候这样是没有必要的：浪费 token（钱），而且在生成实际解决问题的内容之前还要等废话说完。

这种情况可以使用特征工程的手段缓解：通过显式告诉模型简洁输出内容来加速输出、节约成本。可以对比下面两个例子：

- 原始例子

  ````
  Human: 如何在 Linux 下让 IPMI 向操作系统发送 NMI 信号？
  GPT: 在 Linux 下通过 IPMI (Intelligent Platform Management Interface) 向系统发送 NMI（非屏蔽中断）信号，可以用于触发内核转储或进行内核调试。下面是具体的步骤：

  1. **确认 IPMI 设备正常工作**：
     在 Linux 系统上，你首先需要确保 IPMI 模块已经加载到内核中。使用以下命令检查：
     ```bash
     lsmod | grep ipmi
     ```
     如果没有列出相关模块（比如 `ipmi_msghandler`，`ipmi_devintf`），你需要加载它们：
     ```bash
     sudo modprobe ipmi_devintf
     sudo modprobe ipmi_si
     ```

  2. **安装必要的工具**：
     使用 `ipmitool` 命令可以管理并控制 IPMI 设备。确保此工具已安装：
     ```bash
     sudo apt-get install ipmitool   # Debian/Ubuntu
     sudo yum install ipmitool       # CentOS
     ```

  3. **发送 NMI 信号**：
     使用 `ipmitool` 命令发出 NMI 到操作系统：
     ```bash
     sudo ipmitool chassis power diag
     ```
     这个命令会向系统发送一个 NMI 信号。

  4. **观察系统响应**：
     确保你的系统配置为在收到 NMI 时采取相应的动作。通常，Linux 内核会在接收到 NMI 时打印状态信息到系统日志中。你可以通过查看 `/var/log/syslog` 或使用 `dmesg` 命令来查看这些信息。

  Linux 系统默认可能不响应 NMI 信号，特别是在进行内核崩溃 (kernel crash) 调试时需要特别配置。这可能涉及到设置如何处理 NMI 的内核参数，例如启用 `kernel.nmi_watchdog=1` 来启用 NMI 监视狗，或者通过 `sysctl` 命令设置相应的内核参数。你也可能需要设置系统以便在接收到 NMI 时生成内核转储文件（vmcore 文件），通过配置 kdump/kexec 工具来完成。

  这些步駐會从 IPMI 软件层面向操作系统发送 NMI 信号，具体的系统响应和处理方式则需要根据你的系统配置和需求进行相应的设置。
  ````

- 末尾添加 `Be concise`

  ````
  Human: 如何在 Linux 下让 IPMI 向操作系统发送 NMI 信号？Be concise
  GPT: 要在 Linux 下通过 IPMI 让 BMC 向操作系统发送 NMI（Non-Maskable Interrupt，即不可屏蔽中断）信号，你可以使用 `ipmitool` 工具。该工具允许你与服务器的 BMC 进行交互，并执行各种管理命令。

  请按照以下步骤操作：

  1. 确保你的机器上安装了 `ipmitool`。如果没有安装，你可以通过包管理器来安装它。例如，在基于 Debian 的系统上，使用：
     ```bash
     sudo apt-get install ipmitool
     ```

  2. 使用 `ipmitool` 发送 NMI 到操作系统。你需要确保有适当的权限来执行此操作。使用以下命令：
     ```bash
     sudo ipmitool chassis power diag
     ```

  这条命令告诉 BMC 发送 NMI 到主机的 CPU。此操作通常用于诊断目的。

  **注意事项**：
  - 确保在安全与必要的情况下执行此操作，因为 NMI 通常用于非常特殊的诊断过程，可能会导致系统崩溃或其他不稳定的行为。
  - 你可能需要根据你服务器的 IPMI 版本和配置调整命令。有时，硬件或固件的不同版本可能会影响命令的效果。
  - 保证你有服务器的管理员权限，因为发送 NMI 信号通常需要较高的权限。
  ````

### 提问语言

由于大语言模型的训练语料很多时候英文的数据量远大于中文，因此使用英文提问得到的结果质量可能比中文提问更好。国产的大语言模型可能可以缓解这个问题。

### 避免超长的对话

大语言模型（GPT）的工作模式简单来讲是：每次用户发送消息时，GPT 都会从最开头开始分析内容，到用户本次发送的信息结束后再开始生成。这样带来了两个问题：

- 对于超长的对话，每一次继续对话都会浪费不少的钱——假设当前的对话前，大语言模型分析了一个很长的网页，花费了一块钱，那么基于这段对话作为背景，**每次**发送一条消息，都会再花一块钱。
- 相比于短文本，GPT 对长文本更容易产生「**幻觉**」，即更容易输出与实际情况不相符的内容。
