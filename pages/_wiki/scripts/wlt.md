---
---

# USTC 网络通脚本

网络通采用简单的 HTTP 接口处理登录、开通出校权限等操作，因此不同的脚本都是调用这个 HTTP 接口，参数也完全相同。

网络通的地址为 <http://wlt.ustc.edu.cn/cgi-bin/ip>，常用操作包括参数 `cmd=set&name=用户名&password=密码&type=0&exp=0`。

所有参数都可以通过 GET 或 POST 方法传递，各参数的解释如下：

- `cmd=set` 为固定参数，无需修改。（另有 `cmd=login` 可以登录，但需要保存 cookie。既然脚本中可以不使用 cookie 直接设置出口，也就没有必要使用 `cmd=login` 了。）

- `name=` 为用户名，即你的网络通账号。

- `password=` 为你的网络通密码。

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

  各出口的具体含义请参考[网络通的说明](http://wlt.ustc.edu.cn/link.html)。

  注：参数取值等于网页上的出口编号减去 1。

- `exp=` 参数表示登录时长，即自动退出登录的时间，取值与含义如下：

  | `exp=` | 登录时长 |
  | -----: | :------: |
  |      0 |   永久   |
  |    120 |  动态\*  |
  |   3600 |  1 小时  |
  |  14400 |  4 小时  |
  |  39600 | 11 小时  |
  |  50400 | 14 小时  |

  注：除了 0 和 120 以外的数值都是秒数。

  注 2：“动态”是一个现已不存在的选项，但仍能在 BBS 上找到一些线索，其含义未知。

{% capture notice-special-chars %}
<i class="fas fa-fw fa-exclamation-circle"></i>
需要注意的是，如果密码包含诸如 `&` 等特殊符号，直接进行替换可能无法正常登录。可以使用以下方法测试：

1. 在浏览器中打开网络通网站，然后按下键盘的 F12（Windows/Linux）或者 Command+Option+I（macOS）。
2. 在打开的**开发者工具**中选择 **Console（中文名为「控制台」）标签**。
3. 在控制台中输入（复制粘贴）`params = new URLSearchParams()`，按下回车。
4. 然后输入 `params.set('password', '你的密码')`，按下回车（记得替换 `你的密码`）。
5. 最后输入 `params.toString()`，按下回车。
6. 可以在输出看到类似于 `password=%E4%BD%A0%E7%9A%84%E5%AF%86%E7%A0%81` 的内容，在 `password=` 之后的就是你实际需要替换的密码（不包含最后的双引号）。
{% endcapture %}

<div class="notice--warning">{{ notice-special-chars | markdownify }}</div>

## Windows VBScript 版

VBScript 是 Windows 系统自带的脚本语言，可以直接运行。

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
- 由 LUG @ USTC 维护更新。

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

## 其他版本

- Perl 版：<https://bbs.ustc.edu.cn/cgi/go?cgi=bbscon&bid=77&fn=M41770FCB>
