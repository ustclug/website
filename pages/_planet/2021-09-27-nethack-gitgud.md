---
title: "菜鸡写给菜鸡的 NetHack 入门教程"
author: "petergu"
categories:
  - Tutorial
tags:
  - 游戏
---

#### 教程说明

本教程只介绍最基本的操作和游戏刚刚开始阶段的策略，帮助新手活过第一层。引用内容为补充或 Fun facts，可以忽略。图中游戏“截图”均为字符界面的直接复制——虽然没有了颜色或加粗效果，但还是觉得这样更合适一些。

#### 关于

NetHack 是一款历史悠久的 Roguelike 游戏，基于龙与地下城规则，也有着 Roguelike 典型特征：随机生成地图，永久死亡，难度和复杂度非常高。同时，游戏中也融合了各种文化和领域的元素，并且有多种有趣的提示信息和死亡方式。

> 总有一二十年才通关的老玩家说 NetHack 不难——或许和某些其他 Roguelike 相比确实如此，但这和你有什么关系呢？

此游戏默认只有字符界面，以下为一个游戏画面，可以感受一下：

```
This kobold corpse tastes terrible!--More--

                                                       --------
                      ----------                       |......-
                      |........|`######################-......|
                      |........|     -----------       |<.....|
                      |........|     |.........|  #####.....{.|
                      |........-#####|.........-###    --------
                      |........|    #..........|
                      --------|-     -------.---
                             ##
                              ##
                              #
                             #
                     --------.--
                     |$........|
                     |.........|
    ------------    #..........|
    |.....@.d..|    #|..........
    |.....^.....#####|....>....|
    ------------     -----------

Petergu the Stripling          St:15 Dx:14 Co:18 In:9 Wi:7 Ch:10 Lawful
Dlvl:1 $:11 HP:7(16) Pw:1(2) AC:6 Xp:1
```

> 贴图模式也是有的，但是不如字符模式经典

#### 安装和配置

如果你使用 Linux 等操作系统，那么 NetHack 多半可以直接从软件源中安装：包名通常为 `nethack` 或 `nethack-console`。如果使用 Windows，可以在[官方网站](https://nethack.org/v366/ports/download-win.html)下载。建议使用默认的英文版。

为了更好地游戏体验，在 Linux 上推荐将以下内容添加至 `~/.nethackrc` 配置文件（这也是 Ubuntu 中自带的配置）。

```
#
# System-wide NetHack configuration file for tty-based NetHack.
#

OPTIONS=windowtype:tty,toptenwin,hilite_pet
OPTIONS=fixinv,safe_pet,sortpack,tombstone,color
OPTIONS=verbose,news,fruit:potato
OPTIONS=dogname:Slinky
OPTIONS=catname:Rex
OPTIONS=pickup_types:$
OPTIONS=nomail

# Enable this if you want to see your inventory sorted in alphabetical
# order by item instead of by index letter:
# OPTIONS=sortloot:full
# or if you just want containers sorted:
# OPTIONS=sortloot:loot

#
# Some sane menucolor defaults
#

OPTIONS=menucolors
MENUCOLOR=" blessed "=green
MENUCOLOR=" holy "=green
MENUCOLOR=" uncursed "=yellow
MENUCOLOR=" cursed "=red
MENUCOLOR=" unholy "=red
MENUCOLOR=" cursed .* (being worn)"=orange&underline
```

#### 开局

运行 NetHack 后将看到以下提示：

```

NetHack, Copyright 1985-2020
         By Stichting Mathematisch Centrum and M. Stephenson.
         Version 3.6.6 Unix, built Mar 18 18:21:43 2020.
         See license for details.


Shall I pick character's race, role, gender and alignment for you? [ynaq]
```

你可以按 `n` 然后自己选择人物的种族（人类，矮人，精灵，地精，兽人）、角色（考古学家、骑士、游客等 13 种）、性别（男、女）和阵营（守序、中立、混乱），或者按 `y` 让系统随机选一个。对于新手，女武神（Valkyrie）、野蛮人（Barbarian）和武士（Samurai）是开局较为容易的角色，虽然我觉得巫师（Wizard）的游戏体验比较有趣。

> 性别和阵营可以在游戏中因道具改变

> 每个角色的每个阵营对应一个不同的神。其中僧侣（Monk）的神是中国神话传说中的”人物”：山海经、赤松子和黄帝

选好之后根据提示按 `y` 开始。出现 `--More--` 时说明提示未显示完，按空格到下一句话。

> 被怪打一下后出现 `--More--`，下一句话基本是 `You die...`

```
Hello petergu, welcome to NetHack!  You are a neutral male human Wizard.
--More--




  -----
  |..@|
  |.f(|
  |x..|
  |...|
  |?..+
  -----









Petergu the Evoker             St:9 Dx:8 Co:16 In:17 Wi:14 Ch:11 Neutral
Dlvl:1 $:0 HP:12(12) Pw:7(7) AC:9 Xp:1
```

图中，`@` 是你，身边白底（复制出来看不到了）的 `f` 是你的宠物猫，`x` 是一只怪（grid bug），`+` 是关着的门。各种字符代表什么需要慢慢记忆，或者按 `/` 然后根据提示再按 `/`，移动光标查看地图上的信息，结束按 `ESC`。

> 无论任何时候都要仔细阅读提示。这和学习 Linux 命令行是一样的。

底栏是各种状态。新手主要要关注的就是 HP，即生命值；AC，Armor Class，代表防御，越低越好；以及可能出现在底栏的其他临时状态，比如失明（Blind）。其他属性的含义可在 Wiki 上查询。

> HP 降为 0 只是最无聊的死亡方式

按 `i` 可以打开装备栏查看自己的物品。空格返回。

```
 Weapons
 a - a blessed +1 quarterstaff (weapon in hands)
 Armor
 b - an uncursed +0 cloak of magic resistance (being worn)
 Scrolls
 i - an uncursed scroll of magic mapping
 j - an uncursed scroll of enchant weapon
 k - an uncursed scroll of remove curse
 Spellbooks
 l - a blessed spellbook of force bolt
 m - an uncursed spellbook of create monster
 Potions
 f - an uncursed potion of gain ability
 g - an uncursed potion of monster detection
 h - an uncursed potion of healing
 Rings
 d - an uncursed ring of fire resistance
 e - an uncursed ring of invisibility
 Wands
 c - a wand of magic missile (0:4)
 Tools
 n - a magic marker (0:55)
 o - an uncursed blindfold
 (end)
```

按 `Ctrl-X` 可以查看自身可以查看的属性。空格翻页和返回。

> 更多的属性不能自我感觉到，只有特殊情况下才会显示出来

```
 Petergu the Wizard's attributes:

 Background:
  You are an Evoker, a level 1 male human Wizard.
  You are neutral, on a mission for Thoth
  who is opposed by Ptah (lawful) and Anhur (chaotic).
  You are in the Dungeons of Doom, on level 1.
  You entered the dungeon 9 turns ago.
  There is a full moon in effect.
  You have 0 experience points.

 Basics:
  You have all 12 hit points.
  You have all 7 energy points (spell power).
  Your armor class is 9.
  Your wallet is empty.
  Autopickup is on for '$' plus thrown.

 Current Characteristics:
  Your strength is 9.
  Your dexterity is 8.
  Your constitution is 16.
  Your intelligence is 17.
 (1 of 2)
```

“静态”操作就这些：因为 NetHack 是回合制游戏，你可以随时查看这些信息并在进行动作前充分思考。

那么接下来的任务就是活下去了。毕竟，游戏的目的是在地牢深处找到炎多的护符（Amulet of Yendor）并将其献给自己的神，而不是原地不动。

#### 游戏开始

首先是**移动**。推荐的移动方式是和 Vim 操作类似的 8 个方向的 `hjklyubn`，当然新手用四个方向键也未尝不可。

> 事实上，用方向键移动 as good as dead。按下一个移动键不松手也是常见的死亡原因。
>
> 可以用大写的 `HJKLYUBN` 向一个方向长距离移动

比如说，按下箭头或 `j` 移动到门边上。移动途中，`x` 被猫杀死了。

> `Rex misses the grid bug. Rex bites the grid bug.`
>
> `Rex bites the grid bug. The grid bug is killed!`

> 按 `Ctrl-P` 可以查看之前的消息。

> 前期，宠物比你战斗力强也是常有的事

```
 -----
 |..<|
 |..(|
 |..f|
 |...|
 |..@+
 -----
```

**开门**才能出去。按 `ol` 开右侧（`l` 移动方向）的门。之后就可以向右探险了。沿着过道（`#`）走了一段，发现没有路了。

```
-----
|..<|
|..(|
|...|
|...|
|...-#
-----#
     ###
       #
       #
       ###f
          @
```

这也是常见操作：需要搜索以下才能找到路。按 `s` **搜索**，或者更常用的，按 `10s` 搜索 10 次。如果没有路就再来 10 次。发现了隐藏的门，于是继续开门走进屋子。

```
You find a hidden door.





  -----
  |..<|
  |..(|
  |...|
  |...|
  |...-#
  -----#
       ###
         #
         #
         ###f
            @+
```

屋子里有一个 `[` ，走到物品上方并按 `,` **捡起**。`p - a splint mail.`。这是一件盔甲，按 `w` **穿戴**，再按 `？` 选择可穿戴的物品，`p` 选择新捡到的盔甲。`You cannot wear armor over a cloak.`，先把外套**脱下**。按 `T`，看提示已经脱掉了，再穿盔甲，然后再次 `W` 穿上外套。这是可以看见 AC 降为 3，盔甲不错。

> 我们的运气不错。如果发现 `AC` 上升，多半是盔甲被诅咒（cursed），并且被诅咒的兵器和物品无法脱下。

```
                                             ----------------
                                            #@d.............|
  -----                                     f|...............           ....
  |..<|                                  #### ..............|
  |..(|                                  ####+ .............+
  |...|                                  ##    --------- ----
  |...|                                  ##
  |...-#                                 ##
  -----#     ---------                   ##
       ###   |.......|      -----+----  ###
         #   |.......|      |.........###
         #   |.......|      |.......{|####
         ####|........######-........|
            #-.......|      |........|
             |.......|      |..>.....|
             ---------      |........|
                            ----------

Petergu the Evoker             St:9 Dx:8 Co:16 In:17 Wi:14 Ch:11 Neutral
Dlvl:1 $:0 HP:10(12) Pw:7(7) AC:3 Xp:1
```

继续探险，开门看见一只豺狼。直接按向右移动的键（`l`）**攻击**它。几步之后，狼被打死，你也只剩 8 HP 了。

> 当然，见到怪不掂量一下自己的能力就直接攻击并不是好的策略。

> 比如如果正面击打一个冰冻之眼（Frozen eye），你会被冻住若干回合，然后被旁边路过的小怪打死。

> 可以按 `.` 原地休息，这会缓慢回复失去的 HP。

```
You kill the jackal!  You hear water falling on coins.



                                             ----------------
                                            f@%.............|
  -----                                     #|...............           ....
  |..<|                                  #### ..............|
  |..(|                                  ####+ .............+
  |...|                                  ##    --------- ----
  |...|                                  ##
  |...-#                                 ##
  -----#     ---------                   ##
       ###   |.......|      -----+----  ###
         #   |.......|      |.........###
         #   |.......|      |.......{|####
         ####|........######-........|
            #-.......|      |........|
             |.......|      |..>.....|
             ---------      |........|
                            ----------

Petergu the Evoker             St:9 Dx:8 Co:16 In:17 Wi:14 Ch:11 Neutral
Dlvl:1 $:0 HP:8(12) Pw:7(7) AC:3 Xp:1
```

可以看到提示狼被打死。同时你听到一些声音。

> `You hear water falling on coins.` 的意思是本层有喷泉（中间屋子里的 `{`）

地上的 `%` 是狼的尸体。杀死怪物后你多半希望**吃掉**尸体，否则没有食物会饿死。移动到 `%` 上方并按 `e`，选择 `y` 吃掉。

> `You see here a jackal corpse.`
>
> `There is a jackal corpse here; eat it? [ynq] (n) y`
>
> `This jackal corpse tastes okay. You finish eating the jackal corpse.`

> 当然，不是什么都能吃。有些怪的尸体会让你中毒。如果因此呕吐，你会变得更饿。然而有些尸体可以让你获得某些能力（比如抵抗中毒、抵抗寒冷等）。如果触摸鸡头蛇怪（cockatrace）的尸体，会变成石头。

这时，可以看到我们吃饱了，变得 Satiated。

> 这时继续大量吃东西可能会被噎死。

同时发现，有一扇锁着的门。我们目前没有撬锁工具，只能**踢**开。按 `Ctrl-D` 然后方向 `h` 踢门几次。

```
This door is locked.



                                             ----------------
                                            #-..............|            -----
  -----                                     #|.f.............           .....|
  |..<|                                  ####|..............|
  |..(|                                  ####+@.............+
  |...|                                  ##  ----------- ----
  |...|                                  ##
  |...-#                                 ##
  -----#     ---------                   ##
       ###   |.......|      -----+----  ###
         #   |.......|      |.........###
         #   |.......|      |.......{|####
         ####|........######-........|
            #-.......|      |........|
             |.......|      |..>.....|
             ---------      |........|
                            ----------

Petergu the Evoker             St:9 Dx:8 Co:16 In:17 Wi:14 Ch:11 Neutral
Dlvl:1 $:0 HP:9(12) Pw:7(7) AC:3 Xp:1
```

我们踢门多次门才打开，中途来了两只狼，第一只被猫一击咬死，第二只也被猫一击咬死。

> `This door is locked.`
>
> `WHAMMM!!! Rex misses the jackal.`
>
> `WHAMMM!!! Rex bites the jackal. The jackal is killed!`
>
> `WHAMMM!!!`
>
> `WHAMMM!!!`
>
> `WHAMMM!!!`
>
> `As you kick the door, it crashes open! The jackal bites!`
>
> `Rex misses the jackal.`
>
> `You miss the jackal. The jackal bites! Rex bites the jackal.`
>
> `The jackal is killed!`

> 注意到图右边部分显示的房间了吗？因为从隔壁房间的门口“路过”，视野所限只能看到屋内的一部分。字符界面不代表没有光照的处理。

一层探险结束后，捡到了一些其他护身符和戒指等。因为捡东西过多，处于 `Burdened` 状态。走到 `>` 的位置，按 `>` **下行**到下一层地牢。

> 负重是非常不好的，但本人就是不想扔东西。

> `You fall down the stairs.`

> 下楼的时候宠物如果在你身边一格以内，会和你一起下去。否则会被留在原地，并逐渐野化

这时候，背包里已经有一些不知道是什么的装备了。

> `r - a sapphire ring`
>
> `t - a pyramidal amulet`

**鉴定物品**（Identification）是 NetHack 中重要而困难的。最基础的方法就是亲自体验：`P` - `?` - `t` 戴上护身符。好像没什么变化，仍然不知道是什么。按 `R` 移除。戒指也一样，什么也没鉴定成。只能作罢。

> 鉴定物品的高级技巧有很多，比如在商店观察卖出价格。

> NetHack 中每种戒指、护身符和卷轴有不同的外观。每一局游戏中外观和功能的对应保持不变，但不同局游戏的这种对应是随机的。这一点并不是 trivial 的，因为，比如说，戒指的材质（金属、石头等）不一样，从而决定了每一局中玩家能通过变身（polymorph）并吃掉戒指获得何种永久属性。

继续同样的探险。看到商店，但我们没有钱，只好离开。

> `"Hello, petergu! Welcome to Akhalataki's used armor dealership!"`

> 攻击商店老板是非常不明智的行为。但是，如果店内有死亡魔杖（Wand of death），可以用其将老板杀死并获得所有的物品。如果有许愿魔杖（Wand of wishing），可以许愿得到死亡魔杖。这二者的基础价格都是 1200，很容易被认出。

> 如果你是游客（Tourist），并且穿着夏威夷 T 恤（Hawaiian shirt），会被商店老板加价“宰客”。

> 宠物可以捡起商店中的物品并在店门外放下—— shoplifting。
>
> `You hear someone cursing shoplifters.`

```
         #
        ##
        #
        #
--------|--
|.......@.|
|[[[[[[f@[|
|[[[[[)[[)|
|))[[.[[[[|
-----------
```

捡到并戴上一枚红宝石戒指后，发现这是被诅咒的——摘不下来了。然而还不知道它是干什么的，但多半不是什么好东西。

> `E - a cursed ruby ring (on right hand)`

```
You see here a blindfold.  You faint from lack of food.--More--

                                       ------
                                       |....|
                                      #......###
                           ------######|....|  ##     ------
      ----------------     |....-######|....|   ###   |....|
      |..............-     |....|#     |....|     ####....F|
      .......@..F....|     |....|      |....|         |....-##
      |......f.......|     |..^..      --)---         ------ ###  ------------
      ---.------------     -|-.--        #                     ###..{........|
         ###                #            #####                    |..........|
           ####             #                ##                   |........>.|
             -.----      ---.-      ----------.--                 ------------
             |....|      |...|      ............|
             |....|      |...|      |...........|
             |....|      |...|      |.<.........+
             |.....######-...|      |...........|
             ------      -----      -------------



Petergu the Evoker             St:8 Dx:8 Co:16 In:17 Wi:14 Ch:11 Neutral
Dlvl:3 $:28 HP:15(15) Pw:23(23) AC:1 Xp:2 Fainted Burdened Deaf
```

不久之后，因饥饿晕倒。戴上的戒指多半是 Ring of hunger。按 `e` 吃一个鸡蛋，回过神来。正好背包里有解除诅咒的卷轴，读一个：按 `r` - `?` - `k`。

> `As you read the scroll, it disappears.--More--`
>
> `You feel like someone is helping you. Rex misses the lichen.--More--`

然后，戒指就可以摘下来了。

又饿了，吃个鸡蛋结果变质了。

> `Blecch! Rotten food! The world spins and goes dark.`

又走了一阵，没有吃的了（因为尸体都让猫吃了），已经晕倒，怎么办？只有神能救我们了。

> `Wizard Needs Food, Badly!`

`#pray`

> `You begin praying to Thoth. You are surrounded by a shimmering light.--More--`
>
> `You finish your prayer. You feel that Thoth is well-pleased.--More--`
>
> `Your stomach feels content.`

**祈祷**是非常强大的——看，这就饱了。但是如果频繁祈祷，神会对我们生气。

> 原地祈祷三次，就会被雷劈死。

```


                                                 --------
                            ---------------######........#
           --------         |..@>.........|#     |......|#     -----
           |......|         |.............|#    #-..B...|#     |...|
           |...:..|         ---|-----------#    #|......|#     |...|
           |......|            #   ##   ####    #|.......##    |...|
           |......|         ##*##########       #.......| #####....|
           |......|        ##  #    #####     ###-------- #    |...|
           -----|--       ##   #        #     # #         #    -|---
                #         #  ###        ##    ##          #     #
                #        ##  #           #    #           #     #
                #        #---.------     #    #           #     #
                #        #|........|    -|----#           ##    ##
                #       ##|........|    |..|>|#            ####--|---------
               ##     ### |........|    |....|#               #...........|
           ----.-     #   |<.......|    |....-#                |..........|
           |.....######   |........|    ------                 |..........|
           |...{| ######  .........|                           ------------
           ------         ----------

Petergu the Evoker             St:9 Dx:8 Co:16 In:17 Wi:14 Ch:11 Neutral
Dlvl:4 $:62 HP:15(15) Pw:23(23) AC:1 Xp:2 Burdened
```

发现，本层有两个下楼梯。这是因为有一个是通往支线任务地精矿洞（Gnomish Mines）的。这个支线较难，如果不是女武神等前期强角色基本不要擅自进入。支线地图是这种风格，周围都是地精 `G`。稍微进去一下，立刻被围攻。幸亏猫比较强打死几只怪。还剩 7 HP 逃了出来。当然，矿洞里装备也很多，我们换了双鞋子，现在 `AC` 是 0，而代价是沉重的盔甲和行动不便。

> `b - an uncursed +0 cloak of magic resistance (being worn)`
> `p - a +0 splint mail (being worn)`
> `B - a +0 iron skull cap (being worn)`
> `I - a +0 pair of hard shoes (being worn)`

```
   ---
   |..--
 ---....- -
 |.......|.
  .........-
   -.......|
    -......|
     -..f..--
     --.....|
      -..G..|
   |....|...| ---
   | ----.......|
       -.@......|
      |.........|
      |.......---
      ..*.G.....
     ------------
```

下一层看到一个箱子。可以 `#loot` **抢劫**。但箱子上锁了，所以可以踢几脚把锁打开。

> 这么做的代价是箱内的药水和易碎的魔杖会损坏。

> `THUD! You break open the lock!`

```
You see here a large box.


                                                           -----
                  -----------     #########################....|
                  |.........|    ###########        #      |...|
                  |.........|    #------      ------       .....
                  |.........|    #.....| #####...<.|       |...|
                #`|..f..>...|    #|.....##    |...)|       --.--
                 #-...@.....+     |....|      |...)|         #
                 #-----------    #-.----      |....|         #
                 #####        ##  ##          |....|###      #
                   # ################        #---.--##############
                              #              `############ --.-+-|----
                   .                               ###     ..........|
                  |.                                       |.........|
                  |.                                       |...... ..|
                  |.                                       |.........|
                  ---                                      |.........|
                                                           -----------


Petergu the Conjurer           St:9 Dx:8 Co:16 In:17 Wi:14 Ch:11 Neutral
Dlvl:5 $:75 HP:25(25) Pw:31(31) AC:0 Xp:3 Burdened
```

然而箱子是空的。

> 你也可以往箱子里放一些东西。

下一层看到了一些类似宫殿的东西。中间有先知，可以花 50 块钱向它咨询（`#chat`）。

```
You see here a statue of a plains centaur.


                                                   -------
             ------------           ###############-....*|
             |..........|        ####              |.....|
             ...........| ############        #####-.^....
             |.....<....|##     #-----|-------#    -------
             -|----------#       |C.........C.#
              ############       |.....C.....|#
                                 |...-----...|
                                 |...|.{.|...|
                                 |..@|{.{|C..|
                                 |.....{.|...|
                                 |..f-----...|
                                 |.....C.....|
                                 |C.........C|
                                 -------------




Petergu the Conjurer           St:9 Dx:8 Co:16 In:17 Wi:14 Ch:11 Neutral
Dlvl:6 $:75 HP:25(25) Pw:31(31) AC:0 Xp:3 Burdened
```

下一层，遇到一只巨大的蝙蝠（Giant bat），被咬到残血后我们逃跑，但是它追了过来，狭路相逢。

```
The giant bat bites!--More--

                                          -----                       -----
                                          |...|                #######-...|
                                         #|....#################      |...|
                                         #-...|#                      |...|
                                         #|...|                       -...|
                                         #|...|                       |.>.|
                                         #-----                       ---.-
                                         ##                              #
                                         #                               *
                                        ###                              #
                                         # #                             #
                                         ###                             #
                                           #                          -|-|-
                                           #                          |...|
                                           #                          |...|
                                          +######B@######`            ...<|
                                         .|#                          -----
                                         .-#
                                         --#

Petergu the Conjurer           St:9 Dx:8 Co:16 In:17 Wi:14 Ch:11 Neutral
Dlvl:7 $:88 HP:5(29) Pw:43(43) AC:0 Xp:4 Burdened
```

> `You die...--More--`
>
> `Do you want your possessions identified? [ynq] (n) `

于是毙命此地。

死后游戏会问你要不要看看你的东西到底是什么。你可以看一眼。

```
 L - 3 uncursed scrolls of blank paper
 R - an uncursed scroll of fire
 Spellbooks
 l - a blessed spellbook of force bolt
 m - an uncursed spellbook of create monster
 x - an uncursed spellbook of slow monster
 Potions
 f - an uncursed potion of gain ability
 g - an uncursed potion of monster detection
 h - an uncursed potion of healing
 G - an uncursed potion of sickness
 O - an uncursed potion of water
 S - a blessed potion of sleeping
 Rings
 d - an uncursed ring of fire resistance
 e - an uncursed ring of invisibility
 r - an uncursed ring of cold resistance
 E - an uncursed ring of aggravate monster
 H - an uncursed ring of sustain ability
 Wands
 c - a wand of magic missile (0:4)
 Tools
 n - a magic marker (0:55)
 (2 of 3)
```

通常，如果看了，就会发现背包有至少一件能避免死亡的物品（比如残血之后喝个药之类的，或者这个 magic missile 看起来很 promising）。然而生命只有一次，这就是 Roguelike。

```

                       ----------
                      /          \
                     /    REST    \
                    /      IN      \
                   /     PEACE      \
                  /                  \
                  |     petergu      |
                  |      88 Au       |
                  |   killed by a    |
                  |    giant bat     |
                  |                  |
                  |                  |
                  |       2021       |
                 *|     *  *  *      | *
        _________)/\\_//(\/(/\)/\//\/|_)_______


Goodbye petergu the Wizard...

You died in The Dungeons of Doom on dungeon level 7 with 704 points,
and 88 pieces of gold, after 3310 moves.
You were level 4 with a maximum of 29 hit points when you died.
```

#### 尾声

通过本菜鸡的一局典型游戏流程，希望你已经了解了 NetHack 的基本操作，并能够在地下城中跌跌撞撞地存活一段有限大的时间。仍然有非常多重要的机制和操作本教程中没有提及（甚至 BUC 都没有说），这就要各位自己寻找了。对于一般玩家，要胜任这种游戏，作弊、剧透甚至是阅读源代码都是有必要而并不可耻的行为。

#### 参考资料

https://nethackwiki.com

https://www.zhihu.com/question/40177337

https://www.melankolia.net/nethack/nethack.guide.html

https://nethack.org/

https://github.com/regymm/nethackassistant

https://alt.org/nethack/

By regymm 2021.9
