---
---

## ssh 代理

这个脚本通过自动登录免费的 ssh 账户，实现自动的 ssh 代理， 绑定的端口为 7070

ssh_proxy.sh:

```sh
#!/bin/bash
 
cd `dirname $0` #进入ssh_proxy.sh所在的目录
SSH_ACCOUNT_SITE="http://dailimm.com/freessh.php" #提供免费ssh账户的网站
 
'wget' -q $SSH_ACCOUNT_SITE -O /tmp/ssh_site
HOST=$(cat /tmp/ssh_site | grep "服务器地址" | sed "s/^.*value=\"\(.*\)\" onClick.*$/\1/") #获取服务器地址
USER= `cat /tmp/ssh_site | grep "服务器用户" | sed "s/^.*value=\"\(.*\)\" onClick.*$/\1/"` #获取用户名
PASSWORD= `cat /tmp/ssh_site | grep "服务器密码" | sed "s/^.*value=\"\(.*\)\" onClick.*$/\1/"` #获取密码
 
echo "$PASSWORD" #打印密码，当服务器忙时，密码获取的字段是服务器忙的信息
ssh.ex $HOST $USER $PASSWORD #利用expect实现自动登录
```

ssh_proxy.ex:

```expect
#! /usr/bin/expect -f
 
set HOST [lindex $argv 0] #获取服务器地址
set USER [lindex $argv 1] #获取用户名
set PASSWORD [lindex $argv 2] #获取密码
set PORT 7070 #设置绑定的端口号
set tout 60  #设置超时的时间
 
set timeout $tout
 
spawn ssh -D $PORT $USER@$HOST vi #连接服务器
expect "password: "
send "$PASSWORD\r" #输入密码
 
interact
expect eof
```

使用方法：

     ./ssh_proxy.sh

ssh\_proxy.sh 和 ssh\_proxy.ex 要在同一目录下。
