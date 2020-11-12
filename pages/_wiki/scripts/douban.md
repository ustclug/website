---
---

# 豆瓣电台

摘自瀚海星云 bbs：[http://bbs.ustc.edu.cn/cgi/bbstcon?board=Linux&file=M.1286547291.A](http://bbs.ustc.edu.cn/cgi/bbstcon?board=Linux&file=M.1286547291.A "http://bbs.ustc.edu.cn/cgi/bbstcon?board=Linux&file=M.1286547291.A")

针对网速慢的用户以及豆瓣电台的改动做了些修改～: D

[dbfm.pl](/wiki/_export/code/scripts/dbfm435f.pl?codeblock=0 "下载片段")

    #!/usr/bin/perl -w
    use LWP;
    use HTTP::Cookies;
    use JSON;
    use Encode;
    use Term::ANSIColor;
    #use Smart::Comments;
     
    my $time = 0;
    $SIG{INT} = "quit";
     
    my $b = LWP::UserAgent->new;
    $b->cookie_jar(HTTP::Cookies->new);
     
    my $form = {
        form_email=>'your_id',   ###----- 你的帐号-----###
    	form_password=>'your_passwd',          ###----- 你的密码 ----###
        redir=>"/service/account/?return_to=http%3A%2F%2Fdouban.fm&amp;mode=checkid_setup",
    };
     
    #-------login the douban.
    my $login = $b->post('http://www.douban.com/login', $form);
    my $_c = $b->get('http://douban.fm/radio');
    my $uid ='2650910';
    if($_c->content=~/flashvars\[s](http://perldoc.perl.org/functions/s.html)+=\[s](http://perldoc.perl.org/functions/s.html)+\{uid:'(\d+)'/){
        $uid=$1;  #-- Get the uid of your account.
    }
    #-------douban cache folder.
    my $USER_DIR = "$ENV{HOME}/.douban";
    [mkdir](http://perldoc.perl.org/functions/mkdir.html) $USER_DIR unless -d $USER_DIR;
     
    &play_radio();
     
    #-------play the mp3.
    sub play_radio{
        while(1) {
            my $mp3 = $b->get('http://douban.fm/j/mine/playlist?r=' .[rand](http://perldoc.perl.org/functions/rand.html)(). '&type=n&sid=&uid='.$uid .'&channel=1' );#这里的channel参数是新增的，取值0-9 ~:P
            my $result = JSON->new->utf8(0)->decode($mp3->content);
            $result  = $result->{song};
            for my $hash(@$result){
                 [print](http://perldoc.perl.org/functions/print.html) colored $hash->{'title'}." ", 'yellow';
                 [print](http://perldoc.perl.org/functions/print.html) colored ("$hash->{'albumtitle'}",'blue'),'  ';
                 [print](http://perldoc.perl.org/functions/print.html) colored "$hash->{'artist'}\n",'green';
                 [print](http://perldoc.perl.org/functions/print.html) colored "$hash->{'picture'}\n$hash->{'url'}\n", 'white';
                 #######--如果不需要下载封面图片显示在conky上，以下2行不需要用---###############
                 download_cover($hash);
                 log2file("[Playing] ",$hash->{'title'},"\t(",$hash->{'artist'},")\n");
                 #######--
    			 #qx {wget "$hash->{'url'}" -O /tmp/dbfm 2>/dev/null && mplayer /tmp/dbfm 2>/dev/null};
                             #这一行我换成带缓存的mplayer调用，单纯的管道在网速不行的时候不太给力～:)
    			 [qx](http://perldoc.perl.org/functions/qx.html) {wget "$hash->{'url'}" -O - 2>/dev/null |mplayer -cache 1024 -  2>/dev/null };
            }
        }
    }
     
    sub quit{
        [qx](http://perldoc.perl.org/functions/qx.html) {killall -9 mplayer};
        if ([time](http://perldoc.perl.org/functions/time.html)()-$time<3){
            [print](http://perldoc.perl.org/functions/print.html) "exiting...\n";
            log2file("[Stopped]\n");
            [exit](http://perldoc.perl.org/functions/exit.html) 1;
        }
        [print](http://perldoc.perl.org/functions/print.html) "Press Ctrl+C again in 3 seconds to exit...\n";
        [select](http://perldoc.perl.org/functions/select.html)([undef](http://perldoc.perl.org/functions/undef.html),[undef](http://perldoc.perl.org/functions/undef.html),[undef](http://perldoc.perl.org/functions/undef.html),1);
        $time = [time](http://perldoc.perl.org/functions/time.html)();
        # $SIG{INT} = "quit";
    }
     
    #######--如果不需要下载封面图片显示在conky上，以下都不需要用---###############
    sub log2file{
        my $logfile="/tmp/douban.log";
        [open](http://perldoc.perl.org/functions/open.html) LOG, "+>>/tmp/douban.log" or [return](http://perldoc.perl.org/functions/return.html) -1;
        [print](http://perldoc.perl.org/functions/print.html) LOG @_;
        [close](http://perldoc.perl.org/functions/close.html) LOG;
        [return](http://perldoc.perl.org/functions/return.html) 0;
    }
    sub download_cover{
        my $hash = [shift](http://perldoc.perl.org/functions/shift.html);
        my $covername = $hash->{albumtitle} . "_cover.jpg";
        my $artist = $hash->{'artist'};
        $covername = &file_trim ($covername);
        $artist = &file_trim ($artist);
        [mkdir](http://perldoc.perl.org/functions/mkdir.html) "$USER_DIR/$artist" if ! -d "$USER_DIR/$artist";
     
        my $file = "$USER_DIR/$artist/$covername";
        if ($hash->{'picture'}|| $hash->{'picture'}=~/^http.+jpg$/){
     
            if ( ! -[s](http://perldoc.perl.org/functions/s.html) $file ){
                $b->get($hash->{'picture'},':content_file' =>"$file") or [return](http://perldoc.perl.org/functions/return.html) -1;
            }
            [unlink](http://perldoc.perl.org/functions/unlink.html) "/tmp/douban_cover.jpg";
            [symlink](http://perldoc.perl.org/functions/symlink.html) "$file","/tmp/douban_cover.jpg";
        }
        [return](http://perldoc.perl.org/functions/return.html) 0;
    }
     
    sub file_trim{
        my $file = [shift](http://perldoc.perl.org/functions/shift.html);
        $file = decode('utf8',$file);
        $file =~ s/['"\\\/<>\?\!:\|\*]/ /g;
        $file =~ s/^\s+//;
        $file =~ s/\s+$//;
        $file = encode('utf8',$file);
        $file;
    }
     
    __END__
