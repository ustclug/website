---
---

# Linux的多媒体支持

平时爱折腾多媒体方面的东西，对多媒体多少也有一点了解，下面分享一些Linux多媒体应用的见解，不足之处欢迎大家指正。 

本文的组织如下：前面是对整体情况的一些介绍，后面就是具体的应用了。 

## 多媒体文件结构介绍

### 音视频流

音视频流是多媒体文件的核心数据。 

### 文件容器

音视频流封装在文件里的方式。 

### 编码

音视频流如果以原始编码的方式存储，将需占用巨大的空间，为此需要编码以达到压缩的目的。 

## Linux的多媒体框架

### GStreamer

成熟，LGPL，因而被广泛使用。可以使用gstreamer-ffmpeg，还有gstreamer-pitfdll来使用Windows的Direct Show滤镜（win32codecs）。GNOME下有著名的前端Totem。 

### Xine

另一个多媒体框架，GPL。曾经的亮点是可以wrapper Windows的DirectShow滤镜（win32codecs）。 

### Mplayer/Mencoder

完整的多媒体平台。Mplayer是一个播放器，Mencoder是一个非常有名的转码器，Windows下很多转码工具其实都是它的前端。因为Mplayer主要是作为一个播放器，所以其对影音源的读取能力很强，包括各种DVD和蓝光DVD。通常，即使你使用ffmpeg制作DVDRip，也需要使用Mplayer来先将影音流dump出来。 

### VLC

完整统一的多媒体平台。与Mplayer一样同时支持编解码和播放，同时对流媒体支持非常好，甚至用来在线播放ftp里的电影都非常稳定，可以作为流媒体服务器。 VLC提供了一个完整的框架，但是由于年纪轻，文档少，一些功能还有不稳定的因素，因此现在还不是最完美的方案，但我们有理由相信，也许将来VLC将成为主流的跨平台播放器。 

### XMMS2

精炼的音频播放框架。命令行参数十分友好，而且是以后台daemon的方式运行，因此是个非常好的命令行音乐播放器。 

### FFmpeg

通用的转码平台，大牛Fabrice Bellard发起的项目，libavcodec就是其中最重要的一个组件，实际上上边很多播放器强大的解码能力都是由此项目提供的。 ffmpeg可以支持copy，可以用来从影片里提取声音，或者切割多媒体文件。由于它是作为一个转码平台，能够输出许多容器格式，因此在提取和切割方面十分强大。 

### HandBrake

针对视频收藏分享的转码平台，能够使用x264和xvid两种编码器，并最后封装成强大的mkv格式。各平台下都有相应的版本；GUI和CLI接口十分友好，参数设置方便，且可以从GUI生成命令行参数。 

## Linux的编解码器

### 神级的解码器libavcodec

FFmpeg中最重要的部分，对i386和arm指令集优化极高，遗憾地是现在对多核的支持还比较早期。 

### 昔日王者的编码器xvid

当年DVD Rip的事实标准格式。据说是MPEG4标准的一个实现，很多便携MP4都支持这种格式（通常是用avi封装）。 

### 前沿编码器x264

h264编码器的一个实现，现在几乎所有的高清电影都用这种格式和该编码器编码，将来应该会更加流行；普清视频也有用这种编码器编码，通常称为half cd，以提供较好的压缩率。 而且h264的软硬件解码已十分完善，很多显卡也支持h264硬件解码，同时也有可以接受的软件解码库。所以无论从压缩质量还是兼容性来说，都可以使用它来编码你的收藏视频。 ffmpeg和mencoder都有x264支持，只要在编译时开启了相应选项，就能直接在其中方便地使用x264。 

## 解流与混流

### mkvtoolnix

MKV的推动者，最完美的MKV解决方案。可以从GUI生成命令行参数。 

## 用Mplayer看影片

Mplayer非常强大，不仅对ffmpeg的libavcodec支持非常好，还能调用各种外部的解码库；缺点是没有好用的GUI前端，Gnome Mplayer还不错，但是还是有些不足的细小地方，但是Mplayer的CLI是非常强大的。下面介绍~/.mplayer/config文件的配置。 

顺便再提一个很shit的问题：如果你用的是A卡+fglrx的驱动，你需要使用gl模式的输出，原因如下： 

Catalyst's Xv implementation is broken (visual glitches, no vsync, wrong colors.) Xv with Catalyst is supposed to only have correct colors when you connect your card to a TV 

无语了，不得不承认M$ PC机本来就不是为Linux设计的，在M$ PC机诞生之初，在M$ PC里装Linux是非法的。就好像现在刷路由器和手机一样，只不过现在只是保修没了而已。 

### 设置编解码器和输出设备

    
    
    vfm="ffmpeg"
    afm="ffmpeg"
    vo=xv
    ao=alsa

### 设置字幕

    
    
    fontconfig=yes
    font='WenQuanYi Micro Hei'
    # ass-hinting=0
    # ass-styles=
    sub-fuzziness=1
    slang=Chinese,chs,zh
    subfont-text-scale=2
    subfont-osd-scale=2
    subpos=95
    subcp='enca:zh:cp936'

### 关闭屏幕保护

    
    
    heartbeat-cmd="gnome-screensaver-command -p" 

## 用ffmpeg录屏

    
    
    ffmpeg -f x11grab -q 2 -r 15

## 用HandBrake转码

HandBrake本来主要是针对DVD收藏的，但由于其使用的解码前端是libavcodec，而现在libavcodec几乎已经支持所有格式，所以HandBrake已经可以作为一个通用的转码工具，输出编码是非常适合收藏的h264或xvid。我相机拍下来的影像都是用它来转码的。 

HandBrake的操作是图形界面的，与普通的转码软件差不多，很容易适应，这里就不做赘述了。 
