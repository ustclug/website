---
---

# 下载在线视频

这个脚本借助于<http://www.flvcd.com/>，分析各主流视频网站的视频地址，根据给定的视频网页地址，下载其中的视频。 

[get-video.sh](/wiki/_export/code/scripts/get-video435f.sh?codeblock=0 "下载片段")

    
    
    
    #!/bin/bash
     
    flv_web_addr=$1
    flv_dir=$HOME/videos    #存放视频地址的位置
    flvcd_page_file=/tmp/flv_page_file
     
    wget -q -O $flvcd_page_file "http://www.flvcd.com/parse.php?format=high&kw=$flv_web_addr"
    flvurls=( $(cat $flvcd_page_file | grep "<U>" | sed s/\<U\>//g) )  #取出所有片段的视频地址
    flvtitles=( $(cat $flvcd_page_file | grep "<N>" | iconv -f gb2312 -t utf8 | sed -n "s/\s\{1,\}/_/g;s/<N>//gp") )  #取出所有片段的标题，将空格替换为下划线
    nr_urls=${#flvurls[@]}
     
    if [ $nr_urls -eq 0 ]
    then
        echo "No videos found in this page :("
        exit 1
    fi
     
    for ((i=0; i<$nr_urls; i++))
    do
        title=${flvtitles[$i]}
        url=${flvurls[$i]}
        echo "title: $title"
        echo "  url: $url"
        wget -U NoSuchBrowser/1.0 -O "$flv_dir/$title.flv" $url
    done

使用方法很简单： 

    
    
    ./get-video.sh http://v.youku.com/v_show/id_XMjA2NDgyOTg0.html

这将下载这个视频的4个部分，保存到$flv_dir这个目录下。 

如果不需要下载，也可以直接使用mplayer等播放器播放： 

[play-video.sh](/wiki/_export/code/scripts/play-videoc273.sh?codeblock=2 "下载片段")

    
    
    
    #! /bin/bash 
     
    wget -q -O- http://www.flvcd.com/parse.php?kw=$1 | grep "<U>" | sed s/\<U\>//g  | mplayer -playlist -

使用方法同上， 

    
    
    ./play-video.sh http://v.youku.com/v_show/id_XMjA2NDgyOTg0.html
