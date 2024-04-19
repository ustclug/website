---
---

# USTC 网络通脚本

## 参数说明 {#parameters}

所有脚本都是直接调用网络通接口的，因此脚本中的参数完全相同。

- `cmd=set` 为固定参数，无需修改。

- `name=` 为用户名，即你的网络通账号；`password=` 为你的网络通密码。

- `type=` 参数表示选择出口，取值与含义如下：

  | `type=` |       出口       |
  | :-----: | :--------------: |
  |    0    |    教育网出口    |
  |    1    |     电信出口     |
  |    2    |     联通出口     |
  |    3    |    电信出口 2    |
  |    4    |    联通出口 2    |
  |    5    |    电信出口 3    |
  |    6    |    联通出口 3    |
  |    7    |   教育网出口 2   |
  |    8    | 移动测试国际出口 |

- `exp=` 参数表示登录时长，即自动退出登录的时间，取值与含义如下：

  | `exp=` | 登录时长 |
  | -----: | :------: |
  |      0 |   永久   |
  |    120 |   动态   |
  |   3600 |  1 小时  |
  |  14400 |  4 小时  |
  |  39600 | 11 小时  |
  |  50400 | 14 小时  |

## Windows VBScript 版

来源：<https://gist.github.com/iBug/eb6fdbf55465352d6d91b1bdf75ad30f>

```vb
Dim Http, Username, Password
Username = "username"
Password = "password"
Set Http = CreateObject("MSXML2.XMLHTTP.3.0")
Http.Open "GET", "http://wlt.ustc.edu.cn/cgi-bin/ip?cmd=set&type=0&exp=0&name=" & Username & "&password=" & Password, False
Http.Send
MsgBox "Status: " & Http.Status, 65, "WLT"
```

## Shell 版

适用于 macOS、Linux 和各类 Unix 系统，也包括 Windows Subsystem for Linux。

来源：

- <http://bbs.ustc.edu.cn/cgi/go?cgi=bbscon&bid=77&fn=M4CAEC63D>
- <http://bbs.ustc.edu.cn/cgi/bbscon?bn=USTCnet&fn=M52FAC28D>
- 由 LUG @ USTC 更新

### 使用 Wget

```shell
#!/bin/sh
wget --post-data="cmd=set&name=用户名&password=密码&type=0&exp=0" \
  http://wlt.ustc.edu.cn/cgi-bin/ip -O -
```

### 使用 cURL

```shell
#!/bin/sh
curl -d "cmd=set&name=用户名&password=密码&type=0&exp=0" \
  http://wlt.ustc.edu.cn/cgi-bin/ip
```

基于以上命令的一个交互式 POSIX Shell Script: <https://github.com/hosiet/wlt>

## Perl 版

来源：<https://bbs.ustc.edu.cn/cgi/go?cgi=bbscon&bid=77&fn=M41770FCB>

wlt.pl:

```perl
#!/usr/bin/perl

$wget="/usr/bin/wget";
$name="xxxx";
$password="xxxx";
$url="http://wlt.ustc.edu.cn/cgi-bin/ip ;
$log="/dev/null";
$page="/tmp/wlt_state";
$cookies="/tmp/wlt_cookies";

@type=( "教育网出口(国内)",
        "电信网出口(国际,到教育网走教育网,缺省)",
        "网通网出口(国际,到教育网走教育网)",
        "电信网出口2(国际,到教育网免费地址走教育网)",
        "网通网出口2(国际,到教育网免费地址走教育网)",
        "电信网出口3(国际,文献出口)",
        "网通网出口3(国际,到教育网走教育网,到电信走电信)");
@exp=   (     0,    120,    3600,         14400,    39600,    50400);
@expstr=("永久", "动态", "1小时", "4小时, 缺省", "11小时", "14小时");

# 登录网络通，用--keep-session-cookies和--save-cookies得到Cookies
$cmd="cmd=login";
# 这个输出页面不需要，只需要得到cookies
$options="-o $log -O $log --keep-session-cookies --save-cookies $cookies --post-
data \"$cmd&name=$name&password=$password\"";
$command="$wget $options $url";
system $command;

print "请选择出口：\n";
$i=0;
foreach (@type) {
        print "\t", $i+1, ": $type[$i]\n";
        $i=$i+1;
}
print "注：选择出口2、3无法使用的某些电子资源，使用出口4、5、6可能可以正常使用\n
";
print "[1-7] ";
$type=<STDIN>;
$type=$type-1;
$typestr=$type[$type];

print "使用时限：\n";
$i=0;
foreach (@exp) {
        print "\t", $i+1, ": $exp[$i]s, $expstr[$i]\n";
        $i=$i+1;
}
print "[1-6] ";
$exp=<STDIN>;
$exp=$exp-1;
$expstr=$expstr[$exp];
$exp=$exp[$exp];

$cmd="cmd=set";
# 利用Cookies选择出口和时限
$options="-o $log -O $page --load-cookies $cookies --post-data \"$cmd&name=$name
&password=$password&type=$type&exp=$exp\"";
$command="$wget $options $url";
#print $command,"\n";
system $command;

# 输出网络通使用记录
#print "\t\t\t$name 的网络通状态：\n\t$typestr\t$expstr\n";
open PAGE, $page;
@page=<PAGE>;
close PAGE;
foreach $line (grep(/^<tr><td>.*<\/td><\/tr>$/, @page)) {
        chomp $line;
        $line=~s!<tr><td>!!;
        $line=~s!</td><td>! [!;
        $line=~s!</td><td>!] !;
        $line=~s!</td></tr>!!;
        print $line,"\n";
}
```
