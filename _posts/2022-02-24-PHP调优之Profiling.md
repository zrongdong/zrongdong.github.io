---
layout:     post
title:      "PHP调优之Profiling"
subtitle:   ""
date:       2022-02-24 18:04:18
author:     "张晨"
tags:
    - php 调优 Profiling KCacheGrind Webgrind
---

本次使用的工具是Xdebug profiling & KCacheGrind


## 环境准备

这次演示我就使用我最熟悉的yii2来做演示了。

安装yii2
> 如果一切顺利的话，你不会遇到问题。
> 你也可以使用自己熟悉的框架或者项目。只要能启动就行
 
```sh
# composer安装yii2
composer create-project --prefer-dist yiisoft/yii2-app-basic yii2

cd yii2

# 运行Yii2
php yii serve
```


在浏览器访问[http://localhost:8080/](http://localhost:8080/)。看效果

## 开启Xdebug

*怎么安装Xdebug?*

简单一点，你可以这样安装。`pecl install xdebug-2.9.8`


查看php配置文件在哪里？
```sh
php --ini
```
这样可以看到你的PHP配置文件在什么目录下。


Xdebug配置如下

```ini
zend_extension="xdebug.so"
# 开启profiler
xdebug.profiler_enable = On
# 输出信息的目录
xdebug.profiler_output_dir = /var/tmp/
xdebug.profiler_output_name = cachegrind.out.%p
# 开启触发模式。不需要开启
xdebug.profiler_enable_trigger = Off
```

你可以运行 `php --ri xdebug`确认你是否已经成功配置

## 生成数据

确保已经配置好Xdebug之后。重启Yii2应用。生成一点数据。

查看你的`/var/tmp`目录下是否生成了数据。

```sh
ll /var/tmp
```


## 工具一：Webgrind

这个工具是PHP写的，就很简单，直接docker运行就可以了。


```sh
docker run --rm -v /var/tmp:/tmp -p 80:80 jokkedk/webgrind:latest
```

如果你不会使用Docker，可以使用工具二。

![效果图1](/img/web/2.png)
![效果图2](/img/web/3.png)

## 工具二：KCacheGrind

Mac系统直接运行`brew install qcachegrind --with-graphviz`即可安装。

如果你已经安装了`graphviz`。你也可以直接使用`brew install qcachegrind`

其他系统可以参考这个进行安装
[参考地址](http://kcachegrind.sourceforge.net/html/Download.html)

github仓库在这里
[https://github.com/KDE/kcachegrind](https://github.com/KDE/kcachegrind)



![效果图](/img/web/1.png)



## 总结

其实可以的话。我觉得使用`KCacheGrind`会强大很多。

这个要看自己去操作和体验。


## 参考文档

- [https://github.com/jokkedk/webgrind](https://github.com/jokkedk/webgrind)
- [https://daniellockyer.com/php-flame-graphs/](https://daniellockyer.com/php-flame-graphs/)
- [https://github.com/brendangregg/FlameGraph](https://github.com/brendangregg/FlameGraph)
- [https://kcachegrind.github.io/html/Documentation.html](https://kcachegrind.github.io/html/Documentation.html)
- [https://xdebug.org/docs/profiler](https://xdebug.org/docs/profiler)
- [https://stackoverflow.com/questions/27038356/how-to-generate-flame-graphs-with-php](https://stackoverflow.com/questions/27038356/how-to-generate-flame-graphs-with-php)
- [https://github.com/KDE/kcachegrind](https://github.com/KDE/kcachegrind)

