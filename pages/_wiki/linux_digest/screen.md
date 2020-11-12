---
---

## screen

screen 命令是在服务器维护等场合非常有用的一个命令。  
如果你有 ssh 到远程服务器的经历的话，你应该知道如果将终端关闭的话，里面正在运行的所有任务都会强制退出，这就导致你必须等待任务完成才能退出。  
使用 screen 可以解决这个问题。其作用便是虚拟一个新的 tty 终端，并在远程登录的场合不会因为退出、网络连接不稳定而中断当前 shell。在执行耗时很长的操作、可能断网的操作、当前网络不稳定等场合使用十分方便。

#### 主要命令

screen：开启一个新的虚拟终端。  
screen -l：显示目前已有的虚拟终端  
screen -r [pid]：连接之前断开的虚拟终端

- 为了方便记忆，也可以对虚拟终端进行命名：

screen -S foobar ：开启一个以 foobar 为名称的虚拟终端；  
screen -r ：在当前仅有一个虚拟终端的情况下连接（attach）已有的虚拟终端，在有多个虚拟终端时效果同 screen -l；  
screen -r foobar ：连接以前名为 foobar 的虚拟终端。

在虚拟终端中，按 ctrl+A 进入 screen 命令模式，此时再按 d 可以断开(detach)（但不终止）当前的终端。

其他命令请在 man screen 中查看。

#### .screenrc 脚本

    # tar-bar
    hardstatus alwayslastline
    hardstatus string '%{=b}%{b}%-w%{.BW}[%n %t]%{-}%+w %=%{G}%C%A %Y-%m-%d'
    # 下面几个不知道是否可以使用……这个配置文件写的有些时候了～
    # hardstatus string '%{=b}%{b}%-w%{.BW}%10&gt;[%n %t]%{-}%+w%&lt; %=%{G}%C%A, %Y-%m-%d'
    # hardstatus alwayslastline '%{Yk}%-w%{.Yk}%n %t%{-}%+w %=%{.w} %{.Yr}%1 ` %{.Yb}%2` M %{kY}%C'
    # hardstatus string "%= %-w%L>%{= BW}%n*%t%{-}%52<%+w %L="
     
    # 这个忘了是干啥的了～
    # termcapinfo xterm|rxvt ti@:te@
     
    # screen里面的所有进程退出，screen就自动退出
    autodetach on               # default: on
    #
    # # 退出vim/nano之后自动刷新屏幕
    # altscreen on
    #
    # # 启动等待，显示版本
    msgwait 2
    version
    # # 启动信息
    startup_message off # default: on
    #
    # # 关闭beep报错
    vbell off
    #
    # # 默认的shell，不设置的话就是bash
    # shell zsh
    #
    # ##    Keybindings    ##
    #
    # # F4关闭tab
    bindkey -k k4 kill
    # # F5新建tab
    bindkey -k k5 screen
    # # F6改标题
    bindkey -k k6 title
    # # F7左边的tab
    bindkey -k k7 prev
    # # F8右边的tab
    bindkey -k k8 next

#### 参考

- <http://linuxtoy.org/archives/screen.html>

- <http://www.ibm.com/developerworks/cn/linux/l-cn-screen/>

- <http://www.rackaid.com/resources/linux-screen-tutorial-and-how-to/>

- <http://www.gnu.org/software/screen/manual/screen.html>

- <http://magazine.redhat.com/2007/09/27/a-guide-to-gnu-screen/>

### 来源声明

blog/screen.txt · 最后更改: 2013/04/29 08:04 (外部编辑)
