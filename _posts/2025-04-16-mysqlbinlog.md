---
layout:     post
title:      "解析Mysql Binlog"
subtitle:   ""
date:       2025-04-16
author:     "Jason"
tags:
    - mysql binlog
---


如果你有一个mysql binlog文件，你要怎么才能看到它里面的内容啦？

这个文件是一个二进制文件，不可以直接用文本文件查看的，必须用一些解析工具可以看到里面的内容。

下面就演示如何使用mysqlbinlog工具查看日志内容。



## 下载mysqlbinlog工具

下载自己电脑版本和你得到的mysql binlog文件对应的版本号。

例如，我是Mac OS。 mysql是5.7的版本。

我就下载如下链接: https://downloads.mysql.com/archives/get/p/23/file/mysql-5.7.30-macos10.14-x86_64.tar.gz

下载地址： [https://downloads.mysql.com/archives/community/](https://downloads.mysql.com/archives/community/)


## 使用mysqlbinlog命令解析文件

mysqlbinlog常用的选项

| 选项                                     | 说明                                        | 示例                                     |
| ---------------------------------------- | ------------------------------------------- | ---------------------------------------- |
| `--no-defaults`                          | 忽略本地配置文件                            |                                          |
| `--start-position=N`                     | 从某个位置开始读取                          | `--start-position=1234`                  |
| `--stop-position=N`                      | 读取到某个位置结束                          | `--stop-position=4567`                   |
| `--start-datetime="YYYY-MM-DD HH:MM:SS"` | 设置起始时间                                | `--start-datetime="2025-04-15 00:00:00"` |
| `--stop-datetime="YYYY-MM-DD HH:MM:SS"`  | 设置结束时间                                | `--stop-datetime="2025-04-15 23:59:59"`  |
| `--base64-output=DECODE-ROWS`            | 配合 `-v` 用于解析基于行的事件（row-based） | `--base64-output=DECODE-ROWS -v`         |
| `--skip-gtids`                           | 跳过 GTID（全局事务 ID）的相关信息输出      |                                          |

执行示例
```sh
./mysqlbinlog --no-defaults --skip-gtids --base64-output=DECODE-ROWS -v /data/binlog-171572-binlog.031007
```

```
# at 545730
#240822 10:23:21 server id 2132407162  end_log_pos 546331 CRC32 0xaf5952c2 	Update_rows: table id 133 flags: STMT_END_F
### UPDATE `chuangliang_ad_task_toutiao`.`task_log_toutiao_project_info`
### WHERE
###   @1=262479479
###   @2=0
###   @3=0
###   @4='crontab_task_37272413_20240822101033'
###   @5=231
###   @6='_1761244942147632'
###   @7=12002623515
###   @8='processing'
###   @9='2024:08:22'
###   @10='ProjectInfo'
###   @11=''
###   @12=''
###   @13=11
###   @14=0
###   @15=''
###   @16=1724292677
###   @17=1724293401
###   @18=0
###   @19=12000023236
###   @20=0
###   @21='{"ip":"127.0.0.1"}'
### SET
###   @1=262479479
###   @2=0
###   @3=0
###   @4='20240822101033'
###   @5=231
###   @6='1761244942147632'
###   @7=12002623515
###   @8='success'
###   @9='2024:08:22'
###   @10='ProjectInfo'
###   @11=''
###   @12=''
###   @13=11
###   @14=148
###   @15='{}'
###   @16=1724292677
###   @17=1724293401
###   @18=0
###   @19=12000023236
###   @20=0
###   @21='{"ip":"127.0.0.1"}'
```




## 参考地址

- [https://support.huaweicloud.com/usermanual-rds/rds_05_0138.html](https://support.huaweicloud.com/usermanual-rds/rds_05_0138.html)
- [https://downloads.mysql.com/archives/community/](https://downloads.mysql.com/archives/community/)

