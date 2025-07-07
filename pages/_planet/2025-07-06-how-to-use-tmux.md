---
title: "提升命令行使用体验──tmux 终端复用"
author: "TheRainstorm"
categories:
  - Tech Tutorial
tags:
  - tmux
  - netcat
---

本文会介绍 tmux 的基础使用方法，以及长期使用下来的一些常用配置。

## 背景 & 原理

在使用命令行的过程中，我们经常遇到一个需求，那就是让程序在退出当前终端后保持运行。在以往，我们可能会使用 `nohup` 加让程序后台运行的方式，比如：

```shell
➜  ~ nohup ping 127.0.0.1 &
[1] 89083
nohup: ignoring input and appending output to 'nohup.out'
➜  ~ ps -elf |grep ping
0 S yfy        89083   88672  0  85   5 -  3352 -      11:39 pts/0    00:00:00 ping 127.0.0.1
```

这样在断开终端连接后，重新登陆到服务器，可以发现 ping 进程仍然在运行。hohup 默认将程序输出追加到 nohup.out 文件中，可以通过 tail 检验这一点。

```shell
➜  ~ tail -f nohup.out
64 bytes from 127.0.0.1: icmp_seq=7 ttl=64 time=0.024 ms
64 bytes from 127.0.0.1: icmp_seq=8 ttl=64 time=0.027 ms
64 bytes from 127.0.0.1: icmp_seq=9 ttl=64 time=0.023 ms
64 bytes from 127.0.0.1: icmp_seq=10 ttl=64 time=0.035 ms
➜  ~ ps -elf |head -n1
F S UID          PID    PPID  C PRI  NI ADDR SZ WCHAN  STIME TTY          TIME CMD
➜  ~ ps -elf |grep ping
0 S yfy        89083       1  0  85   5 -  3352 -      11:39 ?        00:00:00 ping 127.0.0.1
```

正常情况下，当终端退出时（如关闭终端窗口，或者 ssh 网络中断），shell 进程会给所有子进程发送一个 SIGHUP 信号，从而导致进程结束。而 nohup 可以让进程忽略掉 SIGHUP 信号，从而在后台保持运行。

> tips: ps 输出还可以观察到 ping 进程父进程变为了 1，这是因为原本的父进程 shell 已经退出，Linux 内核会将孤儿进程交由 init/systemd 进程托管。

nohup 在简单场景比较有用，但是不适用更复杂的场景。比如用户无法再对后台进程进行输入操作，并且同时维护多个进程也很不方便。不过我们其实还有更优雅，更强大的方案，那就是 tmux。

tmux 是一个终端复用器（**T**erminal **MU**ltiple**X**er）。简单来说，tmux 的功能可以概括成一句话：在一个终端里创建多个窗口，并且将窗口分割成多个窗格，每个窗格都运行独立的 shell 进程。这样你就可以让多个应用程序同时运行，而无需打开多个终端模拟器窗口（terminal emulator，如 Xshell、putty、Windows Terminal 等）。下图展示了使用 tmux 创建了一个窗口，并将窗口上下分屏成两个窗格，每个窗格都运行一个 zsh。
![image.png](https://raw.githubusercontent.com/TheRainstorm/.image-bed/main/20250705151056.png)

更重要的是，tmux 将终端和会话（session）进行了分离。我们把创建的窗口和窗格（和其中创建的所有 shell 进程及子进程）看成一个会话，用户可以随时退出（detaching）当前会话，会话会在服务器后台保持运行。在之后，用户可以重新连接上（attaching）这些会话，从而继续之前的工作。

原理上，tmux 采用了客户端和服务器分离的架构（C/S 架构）。用户看到和交互的是 tmux client，tmux client 中创建的窗口（和 shell 进程）连接在 tmux server 进程上。因此，当用户退出 tmux client 后，会话内容可以在后台运行。
通过 pstree 命令，可以看到上图中运行的两个 zsh 的父进程是 `tmux: server`。而和用户交互的其实是 `tmux: client`，其下面并无其他子进程。

```shell
➜  ~ pstree -u yfy|less
sshd---zsh---tmux: client
tmux: server-+-zsh-+-less
             |     `-pstree
             `-zsh---ping
```

在简单了解了下 tmux 的原理后，马上开始 tmux 的上手体验吧。tmux 基础使用非常简单，花 10 分钟就可以完全了解。

## tmux quick start

大部分 Linux 发行版都提供 `tmux` 包，可以通过包管理器安装。其他安装方式（如编译安装）也可以参考官方文档：[Installing · tmux/tmux Wiki](https://github.com/tmux/tmux/wiki/Installing)。

在安装 tmux 后的第一步，我们首先创建一个 tmux 会话。运行 `tmux` 命令后，会进入 tmux 并创建第一个窗口，在这里你可以像往常一样执行命令。

```shell
tmux
```

接着我们介绍最重要的退出话会话和重连会话的方法。按下 `Ctrl+B` 后，再按 `d` 可以退出（detach）当前会话。这样会回到输入 tmux 前的 shell。

通过 `tmux list-sessions` 或者 `tmux ls` 可以查看当前所有的会话信息。

```shell
➜  ~ tmux ls
0: 1 windows (created Thu Jul  3 14:06:05 2025)
```

通过 `tmux attach` 可以连接回第一个会话。

```shell
tmux a  # attach
```

接下来介绍 tmux 最关键的多窗口管理功能，有了它就可以大大提升多任务操作的效率。
tmux 有 session（会话）, window（窗口）, pane（窗格）三个粒度。session 是 tmux 最大的一个粒度，session 下可以创建多个 window，window 可以分割成多个 pane。这里重点介绍窗口和窗格相关的快捷键。

### 窗口操作

```shell
# 创建
Ctrl-B c # 创建新的窗口
Ctrl-B & # 删除当前窗口

# 切換
Ctrl-B Tab        # 切换到刚刚的窗口
Ctrl-B p          # 切换上一个
Ctrl-B n          # 切换下一个
Ctrl-B 数字编号    # 切换到指定一个窗口

# 修改窗口名字
Ctrl-B ,          # 修改当前窗口名字
```

### 窗格操作

```shell
# 创建
Ctrl-B \"     # 上下切分
Ctrl-B %      # 左右切分
Ctrl-B x      # 删除

# 切换
Ctrl-B 方向键      # 方向键上下左右
Ctrl-B [hjkl]     # 使用 vi 风格的 hjkl 键切换，分别对应左上下右

Ctrl-B z      #  切换全屏
```

相信你操作了这些快捷键后，已经可以感觉到 tmux 的方便和强大了。tmux 也是一个像 vim 那样灵活性很高的软件，很多时候一个你不知道的快捷键就能极大体验。因此需要去更多尝试。`tmux list-keys` 可以查看 tmux 的所有快捷键绑定。

本文只介绍了 tmux 的快捷键使用方法，tmux 的软件设计非常简洁高效，以上所有快捷键都有对应它的一个子命令，比如垂直划分窗格对应  `tmux split-window -v` 命令。如果记不住快捷键，可以直接使用 tmux 命令。tmux man 手册的 `COMMAND` 章节提供了所有命令的详细解释。另外本文没有介绍 tmux 的 vi copy 模式，使用该模式可以方便查找、复制程序输出内容，该内容比较进阶，感兴趣的读者可以自行了解。

## 常用配置分享

tmux 像 vim 一样支持高度定制化，可以通过修改 `~/.tmux.conf` 配置各种快捷键，网络上也有 [oh-my-tmux](https://github.com/gpakosz/.tmux) 这样的项目来帮你做一些配置。接下来分享一些我长期使用下来，感觉很有必要的配置，完整配置见我的 [github](https://github.com/TheRainstorm/my-vim-config/blob/master/tmux/.tmux.conf) 仓库。

> bonus: `~/.bashrc` 设置 `alias t="tmux "`，tmux attach 效率立刻提升 300%！

```shell
t      # 创建 sessin
t a    # attach 到第一个 session
```

### 修改快捷键前缀

`Ctrl-B` 按起来距离比较远，很不方便。可以修改成 `Ctrl-X`。

```shell
# prefix
set -g prefix C-x
unbind-key C-b        # disable default prefix
bind C-x send-prefix
```

### 划分窗格快捷键

窗格左右划分和上下划分快捷键比较难记。修改为下划线 `_` 是上下分屏，`-` 是左右分屏。

```shell
# @ pane
# split current window horizontally
bind _ split-window -v -c "#{pane_current_path}"

# split current window vertically
bind - split-window -h -c "#{pane_current_path}"
```

### 鼠标操作

tmux 默认没有启用鼠标，导致无法使用鼠标滚动历史记录。启用鼠标后，还可以直接点击切换不同窗格，以及拖动选择文字复制。

```shell
set-option -g mouse on # open mouse scroll
```

### 打开窗口时默认路径

tmux 打开新窗口时，shell 的默认路径是启动 tmux 客户端时的路径。可以通过以下配置实现：

- `Ctrl-X Alt-C` ：更改默认路径为当前路径
- 创建 panel 时，使用当前路径（`-c` 参数）

```shell
bind M-c attach-session -c "#{pane_current_path}" # Alt-C, to change current path

# @ pane
# split current window horizontally
bind _ split-window -v -c "#{pane_current_path}"

# split current window vertically
bind - split-window -h -c "#{pane_current_path}"
```

### 移动窗口顺序

`Ctrl-Shift` 加方向键左右，可以调整 window 顺序。

```shell
bind -n C-S-Left swap-window -t -1\; select-window -t -1
bind -n C-S-Right swap-window -t +1\; select-window -t +1
```

### session 操作

虽然 window 和 pane 已经足够进行多任务管理了。但是 tmux 提供的多 session 操作也有其用处。适合管理若干完全不相关的任务。

修改快捷键，使其和 window 快捷键类似：`Ctrl-C` 创建新 session，`N/P` （大写）切换上一个和下一个 session。

```shell
# create session
bind C-c new-session

# session navigation
# (/)   #move to prev/next session
bind -r BTab switch-client -l  # move to last session
bind -r N switch-client -n
bind -r P switch-client -p
```

### 复制文字后不自动跳到结尾

tmux 鼠标选中文字会自动复制，但是会自动跳到结尾。有时在查看一些很长的输出历史时，并不想回到结尾，可以通过以下配置禁用跳转：

```shell
# copy select text, and don't jump to end
# https://stackoverflow.com/questions/32374907/tmux-mouse-copy-mode-jumps-to-bottom
bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-selection
```

> 鼠标选中文字后会进入 tmux 的 copy 模式，无法输入命令，此时可以按 q 退出。

### tmux in tmux

有时候想要在 tmux 内再连接另一台服务器，然后也使用 tmux。正常情况下 tmux 快捷键只会传递给外层的 tmux 因此无法工作，但是可以使用以下配置实现按 F12 在内外 tmux 间切换。

```shell
# 按 F12 切换到内嵌 tmux，在 macos 里需要系统设置中取消 F12 占用
# 1. prefix 为 None，不再拦截快捷键
# 2. key-table 为 off，下面再绑定 off 下的 F12，使之能退出内嵌模式
# 3. 改变 statusbar 颜色，以便知道已进入内嵌模式
# 4. 如果处于特殊模式，退出
unbind -T root F12
bind -T root F12 \
  set prefix None \;\
  set key-table off \;\
  set status-style bg=colour235 \;\
  if -F '#{pane_in_mode}' 'send-keys -X cancel' \;\
  refresh-client -S

# 在 off 表里绑定 F12，恢复之前的设置，以退出该模式
bind -T off F12 \
  set -u prefix \;\
  set -u key-table \;\
  set -u status-style \;\
  refresh-client -S
```

> 另一个小技巧是──连续按两次 `Ctrl-B` 时快捷键会传递给内部 tmux。

## 参考资料

- [Tmux 使用教程 - 阮一峰的网络日志](https://www.ruanyifeng.com/blog/2019/10/tmux.html)
- [Ham Vocke --- A Quick and Easy Guide to tmux - Ham Vocke](https://hamvocke.com/blog/a-quick-and-easy-guide-to-tmux/)
- [tmux 内联使用方法](https://fatfatson.github.io/2019/08/11/tmux%E5%86%85%E8%81%94%E4%BD%BF%E7%94%A8%E6%96%B9%E6%B3%95/)
