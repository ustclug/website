---
---

# ustclug 自建软件源使用帮助

## 收录架构

i386, amd64, armhf 

## 收录版本

针对Debian Jessie挑选的部分软件，版本按需确定。 

## 使用说明

  * 编辑`sources.list`文件：




[snippet.bash](https://lug.ustc.edu.cn/oldwiki/_export/code/mirrors/help/ustclug?codeblock=0 "下载片段")
    
    
    
    echo deb https://mirrors.ustc.edu.cn/ustclug ustclug main | sudo tee /etc/apt/sources.list.d/ustclug.list

  * 使用`apt-key add`添加缺失的公钥：




[snippet.bash](https://lug.ustc.edu.cn/oldwiki/_export/code/mirrors/help/ustclug?codeblock=1 "下载片段")
    
    
    
    wget -q https://mirrors.ustc.edu.cn/ustclug/ustclug.asc -O - | sudo apt-key add -

  * 在`apt update`后即可正常使用。




**注意** ：LUG@USTC对其中的软件包的来源不做任何保证，请谨慎使用。 

## 相关链接

无 
