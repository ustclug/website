---
---

### Linux 下关于硬盘 S. M. A. R. T 的相关操作

主要命令：smartctl，包 smartmontools 中的一个组件。  
Ubuntu 可以通过 apt-get install smartmontools 来安装

#### 常用命令：

有些硬盘需要先执行 smartctl /dev/sdX -s on 来开启硬盘的 S. M. A. R. T 信息访问

##### 1. 查看硬盘的全部 S. M. A. R. T 信息

    smartctl -a /dev/sdX

一个十分有用的命令，将给出许多有用的信息。  
特别关注如下部分：  
SMART Attributes：给出硬盘 S. M. A. R. T 数据的值，其中很多可以用来判断磁盘性能和健康状况以及寿命。  
SMART Error Log：给出硬盘历史上最近的 5 次错误细节。较新的硬盘都不应有错误数据，如果此处有记录错误而并没有察觉到硬盘的问题，不能存有侥幸心里而应该进行全面的硬盘检查。  
SMART Self-test log：给出硬盘历史上以及正在进行的自检的时间和结果。一块健康的硬盘不应在此处出现错误。

##### 2. 执行硬盘自检

    smartctl -t [long|short] /dev/sdX

将进行硬盘内置的离线自检，在自检过程中系统不受影响仍可正常操作。  
一般使用 long（或 extended）进行自检，虽然时间较长但可以发现硬盘几乎 100%的错误，包括未使用的区块坏道以及表面错误等等。  
自检的结果可以在 smartctl -a 或者 smartctl -l selftest 中查看

smartctl 的 GUI：GSmartControl，可以通过 apt-get 安装，图形操作十分直观。

更多信息请使用 man smartctl 查看。

### 来源声明

blog/smartmontools.txt · 最后更改: 2013/04/29 08:04 (外部编辑)
