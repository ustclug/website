---
---

### ExPASy的ps_scan在linux下的简明配置指南

##### 配置数据库

下载数据库 

    
    
    wget -c  
    ftp://ftp.expasy.org/databases/prosite/release_with_updates/prosite.dat

给一个文件夹$PROSITE的环境变量，然后把prosite.dat放在$PROSITE/里头。例如我把 prosite.dat放在/home/sun/ps _scan/下 <code>export PROSITE=“/home/sun/ps_scan”</code>

##### 配置软件

下载软件 

    
    
    wget -c  
    ftp://ftp.expasy.org/databases/prosite/tools/ps_scan/ps_scan_linux_x86_elf.tar.gz

解压缩 

    
    
    tar -zxvf /home/sun/ps_scan_linux_x86_elf.tar.gz -C /home/sun/ps_scan/ 

得到ps _scan文件夹中有如下文件：LICENSE，pfscan，pfsearch，psa2msa，ps_ scan.pl, README, README.prf. 其中LICENSE是该软件的协议，pfscan, pfsearch, psa2msa三个文件是可执行文件，ps_ scan.pl是perl脚本，两个README是使用指导。 

把三个可执行文件放进$PATH文件夹。 

    
    
    sudo cp pfscan /usr/local/bin/
    
    
    sudo cp pfsearch /usr/local/bin/
    
    
    sudo cp psa2msa /usr/local/bin/

##### 运行软件

    
    
    perl ps_scan.pl [options]

这里你需要处于ps_scan.pl所在的目录下，至于数据库，由于前边设置过环境变量，软 件会自动找到。当然你也可以在[options]的后头接上数据库的文件。[options]的参数 可以在README里头找到。 

如果你想以后用起来更方便，可以把ps _scan.pl也放进$PATH里。 <code>chmod 777 ps_scan.pl</code>

    
    
    sudo cp ps_scan.pl  /usr/local/bin/ps_scan

这样一来，以后只要输入 ps _scan 即可运行ps_ scan.pl这个脚本。 
