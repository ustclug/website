---
---

# crontab

Cron 服务通常用于循环定期执行任务，而 crontab 用于添加、删除和查看 Cron 项目。

每个用户的 crontabs 是独立的。如果/etc/cron.allow 存在，则必须在里面添加 username（每个条目一行）来获得使用 crontab 命令的权限。如果/etc/cron.deny 存在，则必须保证用户名不在其中才能使用 crontab 命令。如果两个文件都存在，则 cron.allow 的优先级更高。如果两个文件都不存在，则可能只有 root 或者所有用户都可以使用 crontab 命令。

### crontab 命令

命令使用方法：

    crontab [ -u user ] file
    crontab [ -u user ] [ -i ] { -e | -l | -r }

当指定了 file 的时候，这个文件被用作该用户的 cron 表项。

参数含义：

- -u 指定用户。通常没有这个参数的时候默认使用当前用户，但是在使用 su 命令的时候可能会有问题。因此建议一直使用-u 参数指定用户。

- -e 编辑用户的 cron 表

- -l 列出用户的 cron 内容

- -r 删除当前用户的 cron 表

- -i 配合-r 使用，在进行删除的时候提供选择

### crontab 文件的编辑

- 以#开头的行表示注释，但是注释不能与 cron 命令或者环境参数设置语句在同一行。

- 环境变量设置语句为 name = value 形式，但是 value 里面引用的变量不会被解析。例如$HOME 不会解释为用户的 home 目录，而是直接当作字符串“$HOME”处理，环境变量通常用于设置$SHELL (默认为/bin/sh), $MAILTO(默认为 crontab 关联的用户), \$PATH（默认为/usr/bin:/bin）等等。

- 每行的内容依次为分、时、月中的某天、月份、星期中的某天。

示例：

           # 使用bash
           SHELL=/bin/bash
           #设置MAILTO
           MAILTO=paul

           #每天00:05执行
           5 0 * * *       $HOME/bin/daily.job >> $HOME/tmp/out 2>&1

           # 每月的第一天的14:15执行
           15 14 1 * *     $HOME/bin/monthly

           # 每周周一至周五22:00执行
           0 22 * * 1-5    mail -s "It's 10pm" joe%Joe,%%Where are your kids?%

           #每个两个小时的第23分钟执行
           23 0-23/2 * * * echo "run 23 minutes after midn, 2am, 4am ..., everyday"

           #每个周日的04:05执行
           5 4 * * sun     echo "run at 5 after 4 every sunday"

           # 每个月的第8天到第15天的04:00执行
           0 4 8-15 * *    test $(date +u) -eq 6 && echo "2nd Saturday"

更多内容参见 man crontab 和 man 5 crontab

### 来源声明

blog/crontab.txt · 最后更改：2013/04/29 08:04 (外部编辑)
