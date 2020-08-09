---
---

## Vim笔记

##### Vim基本操作

  + “一个光标的故事”（方向键不是最好的选择） ⇒ The Vim Way 

  + 先阅读vimtutor，根据提示进行操作练习 ⇒ 先尝试“生存下来”

![8-\)](../lib/images/smileys/icon_cool.gif)

  + 常用模式：normal, lastline, visual, insert, … ⇒ 熟练在它们中切换 

  + 字词句段篇 ⇒ word/string/paragraph/blockwise ⇒ 尝试在它们之间移动、选定、编辑 

  + 搜索式移动 ⇒ F/f，T/t，/，？，…… 

  + 

![:!:](../lib/images/smileys/icon_exclaim.gif)

查看当前词语的man手册页 ⇒ Shift-k 

  + 

![:!:](../lib/images/smileys/icon_exclaim.gif)

查看当前词语的定义处（局部变量） ⇒ gd 

  + 跳转到文件 ⇒ gf 

  + 块（blockwise）操作 ⇒ v/c/d/y + a/i + {/[/(/“/‘ 

  + 窗口间的移动 ⇒ <C-w> \+ h/i/j/k/

学会使用帮助 

Vim中键入： 

    
    
    :help xxx

即可获得关于xxx的帮助。xxx可以是选项、命令、甚至快捷键组合。 

##### Folding

在Vim中输入： 

    
    
    :set fdm=syntax

即表示以syntax的方式折叠代码（即设定FoldingMethod）。 

  + Folding的方法有syntax、marker、indent、manual等几种。 

  + 在折叠处按z-o可以展开一层折叠，z-O展开此处所有层次的折叠。z-c/C则相反。 

  + 展开当前文件所有的折叠可以用z-R，折叠则用z-M。

##### QuickFix

摘抄一段QuickFix的帮助文件： 

    
    
    Vim has a special mode to speedup the edit-compile-edit cycle.  This is
    inspired by the quickfix option of the Manx's Aztec C compiler on the Amiga.
    The idea is to save the error messages from the compiler in a file and use Vim
    to jump to the errors one by one.  You can examine each problem and fix it,
    without having to remember all the error messages.

也就是说，QuickFix原来是用在处理编译出错的信息上的。其实通过配置，它也能用于cscope的查询和跳转。 

Vim内置支持make指令，你可以输入 

    
    
    :make

来调用make命令在Vim当前工作目录下编译，其出错信息就会出现在QuickFix窗口中。 

QuickFix有些常用指令： 

    
    
    :copen
    :cclose
    :cnext
    :cprev

分别是打开/关闭QuickFix窗口，下一个和上一个错误/警告。其它命令可以查看其帮助文件。 

##### Macro

TODO 

##### Split Screen

TODO 

##### C/C++

ctags和cscope是Linux下比较常用的C/C++代码分析器，配合Vim使用有不错的效果。 

  + ctags

Open C++ file with extra stl_tags: [Click On Me](http://www.vimer.cn/2010/01/让vimgvim支持补全cstl库.html "http://www.vimer.cn/2010/01/让vimgvim支持补全cstl库.html")

  + cscope

可以参考：<http://cscope.sourceforge.net/cscope_vim_tutorial.html>

那些ctags和cscope能做和不能做的事情 

ctags和cscope只能找到匹配的字符串，但是对于C++里面复杂的语义，如函数重载之类的却无能为力。跳转的时候可能会跳转错误或者给出一堆重名的函数以供选择，代码补全的时候也一样。要做到跳转/补全的正确，现有的C++的IDE（集成开发环境）中，Eclipse、QtCreator、KDevelop等都是用自带的分析器解析后再做跳转的。现在有人开始尝试在Emacs上用gcc前端分析代码，求得精确的补全，不过我还没找到Vim上比ctags和cscope更好用的东西。这么说吧，ctags和cscope这些轻量的分析器配合Vim这种快速的编辑器还是比较搭配的。或者你可以试着用一下下面提到的Eclim，后端就是个Eclipse…… 

然后呢，请务必记住—— 

活用QuickFix和TagSelect！ 

  + 代码补全

Vim自身带有不少补全功能，可以在Vim中搜索关于“compl”的帮助 

在此，我推荐C++开发者安装omnicppcomplete插件，所有用户安装neocomplcache插件。 

  + Eclim：以Vim作为前端，操作Eclipse后端，打开和编辑Eclipse工程。[Eclim官方网站](http://eclim.org/ "http://eclim.org/")

##### 番外篇：正则表达式

Vim的强大也体现在其搜索/替换的时候，能够使用强大的正则表达式这一点上。参见[正则表达式30分钟入门教程](http://www.deerchao.net/tutorials/regex/regex.htm "http://www.deerchao.net/tutorials/regex/regex.htm")

## Vim与Linux下的C/C++开发

  + Vim只是一个编辑器

  + 用好Linux这个最大的IDE ⇒ The Unix Way

各种小工具的配合让开发工作变得简单 

  + 用vim编辑 ⇒ 用gcc编译 ⇒ 用gdb调试

## Vim插件列表

多看[Vim官方网站](http://www.vim.org/ "http://www.vim.org/")上各个插件的介绍页面和帮助手册 

注意插件冲突和快捷键冲突 

  + a.vim

  + conque _1.1.vba * DoxygenToolkit.vim * doxygen * grep.vim * mark * matchit * neocomplcache * NERD_ commenter

  + omnicppcomplet

  + pathogen.vim

  + showfunc.vim

  + snipMate

  + tabbar.vim

  + taghighlight

  + taglist

  + txtbrowser

  + vcscommand

  + winmanager

  + zencoding

  + …… 
    - [上述插件原始文件的打包下载](/.ustc.edu.cn/_redsky/vim-scripts.tar "http://lug.ustc.edu.cn/~redsky/vim-scripts.tar.gz")，其实我更推荐大家到Vim官方网站上面去搜索这些插件，一边看着简介一边下载。

## Vim配色方案

    - tango2: 

![:-\)](/wiki/lib/images/smileys/icon_smile.gif) 可以与终端配色一致 / ![:-\(](../lib/images/smileys/icon_sad.gif)

 深色背景下的紫色比较惨淡

    - eclipse： 

![:-\)](/wiki/lib/images/smileys/icon_smile.gif) gvim下配色接近eclipse / ![:-\(](../lib/images/smileys/icon_sad.gif)

 终端下配色不好协调

    - solarized： 

![:-\)](/wiki/lib/images/smileys/icon_smile.gif) 暖色调，可以调节背景，有配套的终端配色 / ![:-\(](../lib/images/smileys/icon_sad.gif)

 部分颜色与highlight插件配合后比较刺眼

    - desert

    - wombat

    - vc

    - kate

    - ……

## Vim资源列表

[我的Vim配置文件](/.ustc.edu.cn/_redsky/vim-config.tar "http://lug.ustc.edu.cn/~redsky/vim-config.tar.gz")：包括.vimrc/.gvimrc/.vim/myVim，注意前面有“.”的是隐藏文件。配置文件里面已经补上了注释。 

[CoolShell：简明Vim练级攻略](http://coolshell.cn/articles/5426.html "http://coolshell.cn/articles/5426.html")

[CoolShell：主流文本编辑器学习曲线](http://coolshell.cn/articles/3125.html "http://coolshell.cn/articles/3125.html")

[Adam8157：在中科大关于Vim的演讲](http://adam8157.info/blog/2011/12/ustc-vim-speech/ "http://adam8157.info/blog/2011/12/ustc-vim-speech/")

[把vim打造成一个真正的IDE(1)](http://www.vimer.cn/2009/10/把vim打造成一个真正的ide1.html "http://www.vimer.cn/2009/10/把vim打造成一个真正的ide1.html")

[把vim打造成一个真正的IDE(2)](http://www.vimer.cn/2009/10/把vim打造成一个真正的ide2.html "http://www.vimer.cn/2009/10/把vim打造成一个真正的ide2.html")

[把vim打造成一个真正的IDE(3)](http://www.vimer.cn/2009/10/把vim打造成一个真正的ide3.html "http://www.vimer.cn/2009/10/把vim打造成一个真正的ide3.html")

[Vimer(朱念洋)使用的vim/gvim相关插件整理](http://www.vimer.cn/2010/06/本博使用的vimgvim相关插件整理.html "http://www.vimer.cn/2010/06/本博使用的vimgvim相关插件整理.html")
