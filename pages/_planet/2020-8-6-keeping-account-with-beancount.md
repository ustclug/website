---
title: 使用 Beancount 进行记账并自动记录一卡通消费
author: Xenon
date: 2020-8-6
categories: 
- USTC
tags: 
- Beancount
- eCard
---

本文首发于 <https://charlesliu7.github.io/blackboard/2019/07/24/beancount/>

偶尔看到了复式记账这个概念，对精细记账的我而言很受用，选择 Beancount 这样的开源工具的原因莫过于账本数据完全由自己掌握，而不是被各大 APP
所保管。本文从一次个人实践的角度来说明一下复式记账的使用。

本篇文章是一个从零开始的个人实践记录，涵盖 **文件组织- >基本账本书写->爬取一卡通数据并自动记录**，供同样使用 Beancount
的同学做参考，但此实践并不一定完全合乎其他人的使用习惯，如果有其它记录策略也是可以的。本文内容基于读者对复式记账和 Beancount
语法有一定了解的情况下撰写的，关于复式记账的概念和一些诸多基本功能介绍，可以参考阅读以下文章：

  * [文本记账综述、复式记账开源工具比较](https://plaintextaccounting.org/#comparisons)
  * [Beancount复式记账（一）：为什么](https://www.byvoid.com/zhs/blog/beancount-bookkeeping-1)

开始！

## 安装使用

Beancount 是一个 Python 实现的开源工具，在本地即可运行，首先从 PyPI 获取：

    
    
    pip install beancount fava

其中 `beancount` 是核心包，包含核心的命令行工具；`fava` 是网页可视化工具。 ~~这里有一个[fava
示例账本](https://fava.pythonanywhere.com/huge-example-file/balance_sheet/) ，对应的
Beancount 源代码可以在 [Bitbucket
上下载](https://bitbucket.org/blais/beancount/src/default/examples/)。~~
本文的示例账本以及可视化可以在该[仓库](https://git.lug.ustc.edu.cn/Charles/ecard_beancount)查看。

克隆该仓库，在命令行中使用 `fava main.beancout`。

    
    
    $ fava main.beancout
    Running Fava on http://localhost:5000

打开浏览器即可看到可视化账本。

## 文件结构

Beancount 支持 `include` 语法来拓展账簿，个人采用按时间划分文件，辅之特殊事件（比如旅游）单独记录的方法，目录结构如下：

    
    
    .
    ├── 2018
    │   └── ...
    ├── 2019
    │   └── 01.bean
    │   └── 02.bean
    │   └── 03.bean
    │   └── 04.bean ; 注释用分号
    │   └── xx.event.bean ; 单独针对某一特别事件的账本，比如旅游
    │   └── 05.bean
    │   └── 06.bean
    │   └── 07.bean
    ├── accounts.bean ; 记录初始账户信息
    ├── main.bean ; 主文件

## 账本书写

###  账户信息设置

首先要定义账户，即文件 `accounts.bean`，Beancount 系统中预定义了五个分类：

  * Assets 资产 本人按照`账户类型:国家:金融机构名字:具体账户`的策略划分，时间是开户时间，比如：

    
    
    2017-01-01 open Assets:CN:Bank:BoC:C1234 CNY ; 学校银行卡
    2017-01-01 open Assets:CN:Card:USTC CNY ; 一卡通
    2017-01-01 open Assets:CN:Web:AliPay CNY ; 支付宝
    2017-01-01 open Assets:CN:Web:WeChatPay CNY ; 微信支付

有一类针对 AA 付款或者个人向自己借款的账户，需要专门记录。

    
    
    2017-01-01 open Assets:Receivables:X ; 对 X 的应收款项

  * Liabilities 负债 本人主要是信用卡和向他人借款的账户，比如：

    
    
    2017-01-01 open Liabilities:Payable:X ; 对 X 的债务
    2017-01-01 open Liabilities:CreditCard:CN:BoC:C1111 CNY ; 信用卡
    2017-01-01 open Liabilities:CreditCard:CN:Huabei CNY ; 花呗

  * Equity 权益（净资产） 目前只有一个用于平衡开户的时候账户资金的权益。

    
    
    1990-01-01 open Equity:Opening-Balances

  * Expenses 支出 支出就非常的多样化，可以根据自己需求分门别类，比如：

    
    
    2017-01-01 open Expenses:Clothing ; 包括上衣，裤子和装饰，袜子，围巾，帽子
    2017-01-01 open Expenses:Shoes ; 鞋
    2017-01-01 open Expenses:Food:Dinner
    2017-01-01 open Expenses:Food:Lunch
    2017-01-01 open Expenses:Food:Breakfast
    2017-01-01 open Expenses:Food:Fruits
    2017-01-01 open Expenses:Food:Nightingale ; 校门口夜宵
    2017-01-01 open Expenses:Food:Drinks
    2017-01-01 open Expenses:Food:Snack ; 杂食、零食

等等……

  * Income 收入 收入也可以根据自己的实际收入来源来建立账户，比如：

    
    
    2017-01-01 open Income:Salary:XXX
    2017-01-01 open Income:Salary:Others
    2017-01-01 open Income:Others

### 主文件设置

然后设置主文件 `main.bean` 内容，主文件任务是设置全局变量，然后去涵盖各个子账本：

    
    
    option "title" "取个霸气的名字吧" ; 账簿名称
    option "operating_currency" "CNY" ; 账簿主货币
    option "operating_currency" "USD" ; 可以添加多个主货币
    
    include "accounts.bean" ; 包含账户信息
    
    ; 每个月的账本
    include "2020/06.bean"
    include "2020/07.bean"

### 账户初始余额设置

在开始记账前，要设置每个账户的余额信息，采用以下方法来给每个账户设置余额/借记账单:

    
    
    2019-01-01 pad Assets:Bank:CN:BoC:C1111 Equity:Opening-Balances ; 从 Opening-Balances 中划取 XX 帐到银行卡中
    2019-01-02 balance Assets:Bank:CN:BoC:C1111    +xxx.xx CNY ; 银行卡余额为 xxx.xx

该语句的含义是无论 `Assets:Bank:CN:BoC:C1111` 之前余额多少，在 2019 年 1 月 2 日开始之前都调整到 xxx.xx
CNY，差额从 Equity:Opening-Balances 来。注意两行之间差一天的时间，`balance`
断言界定为当天开始；一般储蓄卡余额为正，信用卡余额为负。

### 记账

  * 基本记账，记账语法为：

    
    
    YYYY-mm-dd * ["Payee"] "Narration"
      posting 1
      posting 2
      posting 3
      ...

比如：

    
    
    2019-01-01 * "Walmart" "在超市买两件衣服和晚餐"
      Expenses:Clothing 20 USD
      Expenses:Clothing 10 USD
      Expenses:Food:Dinner 10 USD
      Liabilities:CreditCard:US:Discover -40 USD

  * 多货币转换使用@@作为货币转换即可，货币 Beancount 会进行汇率计算，比如：

    
    
    2019-01-01 * "日本航空" "纽约-东京"
      Expenses:Transport:Airline 1000 USD @@ 110000 JPY
      Liabilities:CreditCard:JP:Rakuten -110000 JPY

  * 账户结息 账户的利息肯定难以每日都记录，本人采用 `pad`+`balance` 断言，每隔一段时间结算一下。

  * 分期付款 这是个常见的购买方式，需要单独设置开一个 Liabilities Account，手续费记利息支出，每个月账单出现的时候转移一下。

### 核账

本人选择每个月还款日核实一下账本，在 Fava 左侧 `Balance Sheet` 或者 `Holdings`
里可以看到各个账户当前的状况，如果和实际的账户金额有出入的话就需要点进对应账户查看每笔交易的情况，看看是否漏记或者错记。

##  用 Importer 自动记录一卡通消费

###  综述

`Importer` 个人理解的作用是将整理好的账单文本转化为 Bean 记录的形式，即格式化 (表格, JSON 等) 账单 -> Importer ->
Beancount 记录，Importer 在其中起到一个消费记录格式转化作用。

Beancount 作者对 Importer 有详细的文档叙述，即 [Importing External Data in
Beancount](http://furius.ca/beancount/doc/ingest)。Beancount 官方也有基于机器学习的智能
importer
[beancount/smart_importer](https://github.com/beancount/smart_importer)。

而本人的需求是：

  1. 利用[校园一卡通门户系统](https://ecard.ustc.edu.cn/login)获取每日的一卡通使用记录，并生成 `CSV` 记录。
  2. 基于 `CSV` 的账单生成 `bean` 文件。
  3. 能够自行定制规则来实现对不同消费的分类。

###  将当日的一卡通消费生成为 `CSV`

爬取一卡通数据的代码为
[crawer.py](https://git.lug.ustc.edu.cn/Charles/ecard_beancount/-/blob/master/crawler.py)
，其作用为爬取当日的一卡通消费记录，并自定义规则区分早、午、晚餐，生成符合 Beancount 格式的 `CSV`。（代码可以直接运行）

    
    
    import requests
    from datetime import datetime
    from bs4 import BeautifulSoup
    import json
    import codecs
    import csv
    
    name = 'XXX'  # 姓名
    stu_no = 'PBXXXXXXXX'  # 学号
    pwd = 'user_pwd'  # 统一身份认证密码
    
    if __name__ == '__main__':
        # 利用统一身份认证登陆校园一卡通门户系统
        casurl = 'https://passport.ustc.edu.cn/login?service=http%3A%2F%2Fecard.ustc.edu.cn%2Fcaslogin'
        caspost = {'username': stu_no, 'password': pwd}  # 统一身份认证
        msg = ''
        s = requests.session()
        try:
            r = s.post(casurl, caspost)
        except Exception as e:
            msg = '{0} - INFO: USTC ecard CAS登陆失败 {1}'.format(datetime.now().strftime('%Y-%m-%d %H:%M:%S'), e)
        remaining = 0
        if not name in r.text:
            msg = '{0} - INFO: USTC ecard CAS登陆失败 NOOOOOOOO!!!!!!!!'.format(datetime.now().strftime('%Y-%m-%d %H:%M:%S'))
            print(msg)
        else:
            msg = '{0} - INFO: USTC ecard CAS登陆成功'.format(datetime.now().strftime('%Y-%m-%d %H:%M:%S'))
            print(msg)
            paylist = s.get('https://ecard.ustc.edu.cn/paylist')
            b = BeautifulSoup(paylist.text, features="lxml")
            token = b.findAll('input')[-1].get_attribute_list('value')[0]
            data = s.post(url='https://ecard.ustc.edu.cn/paylist/ajax_get_paylist', data={'date': '', 'page': ''}, headers={'origin': 'https://ecard.ustc.edu.cn', 'referer': 'https://ecard.ustc.edu.cn/paylist', 'sec-fetch-mode': 'cors', 'sec-fetch-site': 'same-origin', 'x-csrf-token': token, 'x-requested-with': 'XMLHttpRequest'})
            b = BeautifulSoup(data.text, features="lxml")
            table = b.find('table')
            th_index = []
            for th in table.findAll('th'):
                th_index.append(th.getText())
            year, month, day = datetime.now().year, datetime.now().month, datetime.now().day
            # 根据自己定义的规则判定早餐、午餐、晚餐
            payinfo = {'breakfirst': {'loc': '', 'type': '科大餐饮', 'value': 0.0, }, 'lunch': {'loc': '', 'type': '科大餐饮', 'value': 0.0, }, 'dinner': {'loc': '', 'type': '科大餐饮', 'value': 0.0, }, 'transferin': {'loc': '一卡通充值', 'type': '', 'value': 0.0, } }
            flag = True
            for tr in table.findAll('tr'):
                line = []
                for td in tr.findAll('td'):
                    line.append(td.getText())
                if line and flag:
                    remaining = float(line[3])
                    flag = False
                if not line:
                    pass
                elif line[0] == '圈存机充值' and int(line[1]) == 0:
                    payinfo['transferin']['value'] = float(line[4])
                elif line[0] == '消费':
                    linetime = datetime.strptime(line[5], '%Y-%m-%d %H:%M:%S')
                    if linetime > datetime(year, month, day, 6) and linetime  datetime(year, month, day, 10) and linetime  datetime(year, month, day, 16) and linetime < datetime(year, month, day, 20): # 判定为晚餐
                        if line[6] in payinfo['dinner']['loc']:
                            pass
                        else:
                            payinfo['dinner']['loc'] += (line[6] + ' ')
                        payinfo['dinner']['value'] += float(line[4])
                    elif linetime  0:
                csvinfo.append({headers[0]: today, headers[1]: payinfo['transferin']['type'], headers[2]: payinfo['transferin']
                                ['loc'], headers[3]: "%.2f" % -payinfo['transferin']['value'], headers[4]: 'Transferin'})
            if payinfo['breakfirst']['value'] > 0:
                csvinfo.append({headers[0]: today, headers[1]: payinfo['breakfirst']['type'], headers[2]: payinfo['breakfirst']
                                ['loc'], headers[3]: "%.2f" % payinfo['breakfirst']['value'], headers[4]: 'Breakfirst'})
            if payinfo['lunch']['value'] > 0:
                csvinfo.append({headers[0]: today, headers[1]: payinfo['lunch']['type'], headers[2]: payinfo['lunch']['loc'], headers[3]: "%.2f" % payinfo['lunch']['value'], headers[4]: 'Lunch'})
            if payinfo['dinner']['value'] > 0:
                csvinfo.append({headers[0]: today, headers[1]: payinfo['dinner']['type'], headers[2]: payinfo['dinner']
                                ['loc'], headers[3]: "%.2f" % payinfo['dinner']['value'], headers[4]: 'Dinner'})
            with open(today+'.csv', 'w') as f:
                f_csv = csv.DictWriter(f, headers)
                f_csv.writeheader()
                f_csv.writerows(csvinfo)
    

代码执行完毕后会生成 `20XX-XX-XX.csv`，例如 `2020-07-02.csv`：

记账日期| 收款人| 交易摘要 | 人民币金额 | 类别  
---|---|---|---|---  
2020-07-02 | 科大餐饮 | 一卡通充值 | -200.00 | Transferin  
2020-07-02 | 科大餐饮 | 西区芳华园餐厅 | 5.00 | Breakfirst  
2020-07-02 | 科大餐饮 | 西区芳华园餐厅 | 10.00| Lunch  
2020-07-02 | 科大餐饮 | 西区芳华园餐厅 | 10.00 | Dinner  
  
### 准备 Importer Config

Beancount Importer Config 文件为
[importers/ustc_card_importer.py](https://git.lug.ustc.edu.cn/Charles/ecard_beancount/-/blob/master/importers/ustc_card_importer.py)。

    
    
    #!/usr/bin/env python
    import os
    import sys
    import beancount.ingest.extract
    from beancount.ingest.importers import csv
    
    beancount.ingest.extract.HEADER = ''
    
    def dumb_USTCecard_categorizer(txn):
        # At this time the txn has only one posting
        try:
            posting1 = txn.postings[0]
        except IndexError:
            return txn
    
        # Guess the account(s) of the other posting(s)
        if 'breakfirst' in txn.narration.lower():
            account = 'Expenses:Food:Breakfast'
        elif 'lunch' in txn.narration.lower():
            account = 'Expenses:Food:Lunch'
        elif 'dinner' in txn.narration.lower():
            account = 'Expenses:Food:Dinner'
        elif 'transferin' in txn.narration.lower():
            account = 'Assets:CN:Bank:BoC:C1234'
        else:
            return txn
        # Make the other posting(s)
        posting2 = posting1._replace(
            account=account,
            units=-posting1.units
        )
        # Insert / Append the posting into the transaction
        if posting1.units < posting2.units:
            txn.postings.append(posting2)
        else:
            txn.postings.insert(0, posting2)
        return txn
    
    CONFIG = [
        # USTC canteen
        csv.Importer(
            {
                csv.Col.DATE: '记账日期',
                csv.Col.PAYEE: '收款人',
                csv.Col.NARRATION1: '交易摘要',
                csv.Col.AMOUNT_DEBIT: '人民币金额',
                csv.Col.NARRATION2: '类别'
            },
            account='Assets:CN:Card:USTC',
            currency='CNY',
            categorizer=dumb_USTCecard_categorizer,
        ),
    ]
    

语法说明参见 [Beancount 系列二： Importer
设置](https://charlesliu7.github.io/blackboard/2019/12/03/beancount-importer/)。

执行命令生成 bean 账单。

    
    
    bean-extract ustc_card_importer.py 2020-07-02.csv

得到账单：

    
    
    **** /path/to/2020-07-02.csv
    
    2020-07-02 * "科大餐饮" "一卡通充值; Transferin"
      Assets:CN:Card:USTC        200.00 CNY
      Assets:CN:Bank:BoC:C1234  -200.00 CNY
    
    2020-07-02 * "科大餐饮" "西区芳华园餐厅; Breakfirst"
      Assets:CN:Card:USTC      -5.00 CNY
      Expenses:Food:Breakfast   5.00 CNY
    
    2020-07-02 * "科大餐饮" "西区芳华园餐厅; Lunch"
      Assets:CN:Card:USTC  -10.00 CNY
      Expenses:Food:Lunch   10.00 CNY
    
    2020-07-02 * "科大餐饮" "西区芳华园餐厅; Dinner"
      Assets:CN:Card:USTC   -10.00 CNY
      Expenses:Food:Dinner   10.00 CNY

校园卡消费可以直接使用该 importer。支付宝账单、信用卡账单等也可以通过导出 CSV 账单的方式利用自己编写的 importer 导入。

### 自动化

上述过程需要执行多个命令和脚本，利用 `crontab` 在每日睡前 (23:30) 执行一遍代码即可自动化记录消费。

    
    
    $ python crawler.py>>log.log
    $ cd importers
    $ python ustc_card_importer_pipeline.py # 注意这里需要修改要记录的账本文件

Done!

## Fava

  * Fava 可视化网页中提供了编辑功能，对于多文件的编辑，默认打开的是主文件，要想修改编辑器默认打开的文件，需将 `2019-07-11 custom "fava-option" "default-file"` 这个设置放在想要设定的文件里。
  * Fava 系统中也提供了添加记录的功能，但添加的记录默认写入了主文件里，根据[Fava insert-entry options](https://github.com/beancount/fava/issues/875), [default-file could also set the insertion file](https://github.com/beancount/fava/issues/882) 作者似乎不 care 添加在哪个文件里这个问题，但依然可以利用 `insert-entry` 关键字变相设置一下，比如将 `2019-01-01 custom "fava-option" "insert-entry" ".*"` 断言写在 `2019/01.bean` 文件的末尾，所有在 2019-01-01 之后的记录，通过 Fava 添加记录的话，该记录会 write 在这个断言之前。
  * Fava 是不带有密码功能的，根据 [Make fava password-protected](https://github.com/beancount/fava/issues/314) 作者认为这不应该是 Fava 应该做的工作；利用 [Apache](https://www.digitalocean.com/community/tutorials/how-to-set-up-password-authentication-with-apache-on-ubuntu-16-04?comment=76154) 或者 [Nginx](https://docs.nginx.com/nginx/admin-guide/security-controls/configuring-http-basic-authentication/) 的认证功能可以满足这个需求。
  * 可视化工具 Fava 也支持 Importer，可以通过设置：

    
    
    2017-01-01 custom "fava-option" "import-config" "./importers/path/to/importer.py"
    2017-01-01 custom "fava-option" "import-dirs" "./importers/path/to/csv_tmp/"

在 Fava 界面侧栏看到 Importer，并手动导入数据。

注 ：Importer 在 Fava 中使用的时候 metadata 会被去除。

  * Fava 还支持自定义 side bar link，即：

    
    
    2099-01-01 custom "fava-sidebar-link" "This Week" "/jump?time=day-6+-+day"
    2099-01-01 custom "fava-sidebar-link" "This Month" "/jump?time=month" 
    2099-01-01 custom "fava-sidebar-link" "3 Month" "/jump?time=month-1+-+month%2B1" 
    2099-01-01 custom "fava-sidebar-link" "Year-To-Date" "/jump?time=year+-+month" 
    2099-01-01 custom "fava-sidebar-link" "All dates" "/jump?time="

