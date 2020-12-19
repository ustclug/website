---
title: "在 Linux 内核中测试程序性能"
author: "gloit"
categories:
  - Technology
tags:
  - Benchmark
  - Kernel
  - LLVM
---

本学期，我担任了李诚老师编译原理课程的助教。在课程实验中，我们基于 LLVM 构建了一套编译系统，其中一个实验需要编写后端优化算法。为了评估学生们的优化代码，我们需要比较优化前后的代码（在这里是 LLVM IR）的性能。我们通过统计程序运行的时间来比较代码的性能，但是用户程序会受到[内核调度][1]。因为不是连续执行程序，所以受到调度造成的延迟会导致统计到的时间出现噪音，这些噪音可能会让测试结果不准确<del>甚至影响到了同学们的分数</del>。最开始，我想到是不是可以统计指令数来评估性能，打算用 `perf stat` 进行测试。然而，我们提供的实验环境基于虚拟机，[VirtualBox][3] 和 [WSL][4] 都没有实现相关的虚拟寄存器，要让同学们方便地使用该指令会比较困难，只得作罢。这时，我突然想到，内核线程可以不受到调度，那么使用内核线程是不是可以更精确的测量时间呢？于是我便开始了尝试。

注：由于原本目的是用于 LLVM IR，所以使用了 `clang` 来编译内核，没有这种需求可以完全无视 `clang`。

## 编写内核模块

### 超简单的内核模块编写方法

为了创建内核线程，我们可以构建一个内核模块，由它来执行相关的函数。构建一个基础的内核模块非常简单，这里我们 参考 [**The Linux Kernel Module Programming Guide**][2]：

```c
/*
 *  hello_mod.c - The simplest kernel module.
 */
#include <linux/module.h>	/* Needed by all modules */
#include <linux/kernel.h>	/* Needed for KERN_INFO */

int init_module(void)
{
	printk(KERN_INFO "Hello world.\n");

	/*
	 * A non 0 return means init_module failed; module can't be loaded.
	 */
	return 0;
}

void cleanup_module(void)
{
	printk(KERN_INFO "Goodbye world.\n");
}
```

然后再加上一个简单的 Makefile：

```makefile
# obj-m 告诉构建系统以模块编译，编译目标是 hello.ko
obj-m += hello.o
hello-objs := hello_mod.o

all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
```

这样，一个超简单的内核模块就完成啦！

为了编译内核模块，我们需要有头文件，在 Ubuntu 上可以安装 `linux-headers-<version>` 来实现。又或者你像我一样需要用到 `clang` ，那就下载 Linux 源码重新编译安装（PS：如果全量编译搭配 VSCode 补全体验很好）。在这之后，运行 `sudo make CC=/path/to/clang` 就可以编译这个模块了。编译完成后，会发现目录下多出来一个叫 `hello.ko` 的文件，它就是我们编译得到的内核模块。

在这个模块中，`init_module` 会在模块被载入时调用，而 `cleanup_module` 会被模块被卸载时被调用。通过 `insmod hello.ko`，可以载入它，而 `rmmod hello` 可以卸载这个模块。`printk`会将日志打印到内核的日志中，调用 `dmesg` 可以看到模块打印的欢迎和告别信息。

### Tic-Toc ...

虽然已经编写了一个模块，但是它啥都干不来，我们还得实现计时功能。在编写用户态程序时，语言库里通常有获取当前时间的函数，内核也一样。我们可以通过`ktime.h` 中的 `ktime_get` 来获取时间，大概的逻辑如下：

```c
ktime_t start, end;
u64 dur_ns;
start = ktime_get();
foo(); // 被测试的函数
end = ktime_get();
dur_ns = ktime_to_ns(ktime_sub(end, start));
printk(KERN_INFO "foo runtime: %lluns", dur_ns);
```

看得出来，内核里的函数接口也很平易近人，简单几行就把我们最核心的算法实现完了。

### 怎么使用它？

现在，我们已经知道了如何统计时间，还得设计一个接口来让人触发相关的功能。虽然让模块在初始化时运行也不是不行，但是扩展性就变得太糟糕了。我决定用 [procfs][5] 来设计一个接口。Procfs 来源于 UNIX 哲学中一切皆文件的思想，它把系统运行时的一些信息用文件目录的形式展示出来，这样可以通过简单的文件操作（比如 `cat`、管道等）来访问和控制系统相关的参数，你可以通过 `/proc/` 目录访问里面的内容。

在初始化的时候，我们通过 `proc_mkdir` 和 `proc_create` 可以像普通的文件系统一样在 `/proc/` 目录下创建目录和文件：

```c
// 在 /proc/ 下创建一个目录
if ((root = proc_mkdir(proc_dirname, NULL)) == NULL)
    return -EEXIST;
// 在 /proc/<proc_dirname>/ 目录下创建一个文件，并让该文件使用 bench_fops
if (proc_create(filename, 0444, root, &bench_fops) == NULL)
    return -ENOMEM;
```

这里的 `bench_fops` 是一个类型为 `struct file_operations` 的结构体。它能为这个文件注册功能，比如 open、read、write 等。在内核中设计一个文件系统也需要实现类似的操作，万幸的是， procfs 下不需要实现 [POSIX][6] 语义。在这里，我希望只要有 `write` 被调用时，就会运行我的测试程序，这样我只要在 shell 中用 `echo` 和管道重定向就能调用它了：

```c
// 所有参数都用不到，我们只希望触发一次测试
ssize_t run_bench(struct file *filp, const char __user *buf,
                  size_t len, loff_t *ppos) {
    // 测试相关的函数
    foo();
    // 返回长度和参数一样代表写入成功
    return len;
}

// 这是 C99 加入的结构体指定初始化，其它成员默认为空。
// 这意味着该文件只支持写
static const struct file_operations bench_fops = {
	.owner		= THIS_MODULE,
	.write		= run_bench
}
```

模块功能已经完成了，最后得给模块取个好听的名字。我把英文中表示时间流逝的 tic-toc （tick-tock） 和表示内核的 kernel 合在一起，就变成了 tiktok。

## 链接函数

我本以为编写了寥寥数行 tiktok，将 LLVM IR 编译到目标文件再链接到模块上便可以了。然而经过测试，这样做会导致进程一直无法返回。经过反汇编比较了同一段代码在内核模块里编译的结果和外部产生的结果后，我才理解是因为编译选项不同导致了内存布局的差别，这使得默认参数编译的代码无法在内核中使用。由于内核编译选项繁杂，根据不同架构也会产生不同的选项，我们必须把代码放置进内核的构建系统内来让它产生内核想要的汇编（现在的内核中禁用了浮点数，所以浮点计算就无法测试了）。对于普通的 c 文件，只需要在 Makefile 中加上几句，比如：

```makefile
hello-objs := hello_mod.o another_file.o
```

但是 LLVM IR 还需要一些技巧来骗过编译系统才行。我把自制编译器产生的 IR 文件改成了 .c 文件，并修改了 Makefile：

```makefile
hello-objs := hello_mod.o another_file.o
CFLAGS_another_file.o := -O0 -x ir
```

内核编译系统会在产生 another_file.o 时将这里的 `-O0 -x ir` 传给编译器，这让编译器知道接下来要读的语言是 LLVM IR，并且关掉大部分优化（这样才能体现出自制编译器中的优化效果）。由于 LLVM IR 编译时会忽略一些选项，所以我让编译器在产生中间代码时就加上了属性来确保编译正确。

虽然知道了怎么链接函数，但是内核是无法链接库函数的，而 IO 函数也无法直接在内核中使用。对此，我们可以修改相关的函数，在 tiktok 实现相似的功能。比如， `printf` 可以转换成 `printk`，而 `exit` 可以换成内核中的 `do_exit`。`malloc` 和 `free` 比较复杂，内核中的内存可没有进程那样退出就自动释放这么好的待遇。所以，在内核中必须得手动维护每一次分配和释放，避免出现事故导致 panic 或者内存泄漏（当然我很懒，课程不需要我就都没实现）。

## 一个小测试

既然实现完了，我们进行一个测试来检验 tiktok 的功能：

```c
#define OUT_LOOP 100
int main(void){
    int i;
    int a;
    int j;

    a = 2;
    j = 0;
    while (j < OUT_LOOP){
        i = 0;
        while(i < 1000000) {
            a = a * i + 1;
            i = i + 1;
        }
        j = j + 1;
    }
    return a;
}
```

上面是一段进行一些无意义计算的代码，我们修改 `OUT_LOOPS` 的大小（100、99、98）来比较不同方法的灵敏度。除了普通的 time 测量，我还加入了一组使用 `taskset(1)` 的对照组。 `taskset` 控制了程序的亲核性，这使得程序总能被调度到同一个核上，减少了跨核导致的缓存失效开销。为了减少随机误差，每种配置我都运行进行了 100 次函数得到虚列。实验数据可以在[这里](https://github.com/gloit042/tiktok/tree/main/bench)查看。要反映灵敏度，我们无法直接拿不同方法的结果进行比较，而是要在同一个方法内看看能否显著区分出不同循环次数带来运行时间差距（约为 1%~%2）。短暂尝试了复习概率论和数理统计后，我谷歌到了 [K-S 检验][7] （Kolmogorov-Smirnov test），对于两组输入数据它可以检验它们是否同分布。这里我们假设实际运行时间是固有的，而调度等开销造成的是一个均匀同分布的随机误差。如果测量工具对两种配置得到的两组数据无法拒绝同分布假设，我们可以认为它无法准确得检测出程序性能的差异（统计全忘光了，我不知道我在说啥，如果有误欢迎指正）。我使用了 `scipy.stat.kstest` 来进行了 K-S 检验，结果如下表 （p 值小于 0.05 拒绝同分布假设）：

|     p 值     |      98-99      |     99-100      |     98-100     |      98-98      |      99-99      |    100-100     |
| :----------: | :-------------: | :-------------: | :------------: | :-------------: | :-------------: | :------------: |
| normal_time  | $2.11*10^{-1}$  | $5.83*10^{-1}$  | $3.68*10^{-1}$ |  $3.6*10^{-2}$  | $5.83*10^{-1}$  | $1.29*10^{-3}$ |
| taskset_time | $1.56*10^{-2}$  | $2.11*10^{-1}$  | $3.21*10^{-5}$ | $8.15*10^{-1}$  | $8.15*10^{-1}$  | $2.4*10^{-2}$  |
|    tiktok    | $3.73*10^{-36}$ | $6.31*10^{-19}$ | $2.6*10^{-38}$ | $4.11*10^{-43}$ | $1.41*10^{-28}$ | $2.24*10^{-4}$ |

gg，完全没有用，连同一个配置都分不清楚。虽然占据了一个核，但是虚拟机本身也在被调度，这个误差并不满足我们的假设。但是，还不能放弃，还可以抢救一下，我把 tiktok 放裸机上测试了一下，得到的结果如下：

|     p 值     |      98-99      |     99-100      |     98-100      |     98-98      |     99-99      |    100-100     |
| :----------: | :-------------: | :-------------: | :-------------: | :------------: | :------------: | :------------: |
| normal_time  | $4.04*10^{-35}$ | $2.82*10^{-1}$  | $3.05*10^{-31}$ | $8.15*10^{-1}$ | $5.83*10^{-1}$ | $1.54*10^{-1}$ |
| taskset_time | $1.42*10^{-51}$ | $3.64*10^{-2}$  | $4.39*10^{-55}$ | $5.39*10^{-1}$ | $9.08*10^{-1}$ | $2.11*10^{-1}$ |
|    tiktok    | $2.20*10^{-59}$ | $4.39*10^{-55}$ | $2.20*10^{-59}$ | $2.11*10^{-1}$ | $7.02*10^{-1}$ | $2.11*10^{-1}$ |

在裸机上，tiktok 的优势就体现了出来，它比 `taskset` 要更加灵敏一点。然而裸机上使用 `perf stat`就可以看到更加精确的指令数结果...

## 小结

虽然 tiktok 被证明没有太多实际价值，但是研究的过程中我还是学到了挺多 Linux 内核编译系统的知识。我想分享一下这个过程，是因为我觉得这很有趣。如果你对 tiktok 感兴趣，它在我的 [Github](https://github.com/gloit042/tiktok) 上，它比本文介绍的要稍微复杂一丢丢。如果你想要了解更多关于 Linux 内核的内容，网络上有许多很好的资料。至于编译课程，我估计细小的差距是没法在虚拟机里准确测量了，还是要尽量避开这种测试样例（Windows 上应该也有工具，但是不太方便）。

[1]: https://101.lug.ustc.edu.cn/Ch04/#schedule
[2]: https://tldp.org/LDP/lkmpg/2.6/html/x121.html
[3]: https://www.virtualbox.org/ticket/10754?cversion=0&cnum_hist=5
[4]: https://github.com/microsoft/WSL/issues/4678
[5]: https://en.wikipedia.org/wiki/Procfs
[6]: https://en.wikipedia.org/wiki/POSIX
[7]: https://en.wikipedia.org/wiki/Kolmogorov%E2%80%93Smirnov_test
