---
---

# crontab

Cron服务通常用于循环定期执行任务，而crontab 用于添加、删除和查看Cron项目。 

每个用户的crontabs是独立的。如果/etc/cron.allow存在，则必须在里面添加username（每个条目一行）来获得使用crontab命令的权限。如果/etc/cron.deny存在，则必须保证用户名不在其中才能使用crontab命令。如果两个文件都存在，则cron.allow的优先级更高。如果两个文件都不存在，则可能只有root或者所有用户都可以使用crontab命令。 

### crontab命令

命令使用方法： 

    
    
    crontab [ -u user ] file
    crontab [ -u user ] [ -i ] { -e | -l | -r }

当指定了file的时候，这个文件被用作该用户的cron表项。 

参数含义： 

  + -u 指定用户。通常没有这个参数的时候默认使用当前用户，但是在使用su命令的时候可能会有问题。因此建议一直使用-u参数指定用户。

  + -e 编辑用户的cron表

  + -l 列出用户的cron内容

  + -r 删除当前用户的cron表

  + -i 配合-r使用，在进行删除的时候提供选择

### crontab文件的编辑

  + 以#开头的行表示注释，但是注释不能与cron命令或者环境参数设置语句在同一行。

  + 环境变量设置语句为 name = value形式，但是value里面引用的变量不会被解析。例如$HOME不会解释为用户的home目录，而是直接当作字符串“$HOME”处理，环境变量通常用于设置$SHELL (默认为/bin/sh), $MAILTO(默认为crontab关联的用户), $PATH（默认为/usr/bin:/bin）等等。

  + 每行的内容依次为分、时、月中的某天、月份、星期中的某天 。

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

blog/crontab.txt · 最后更改: 2013/04/29 08:04 (外部编辑) 

你需要登录发表评论。 
