---
layout:     post
title:      "Sublime-Text关闭所有窗口不提示保存"
subtitle:   "Sublime-Text关闭所有窗口不提示保存"
date:       2024-01-27
author:     "Jason"
tags:
    - Sublime-Text
---

在Sublime-Text中新建了很多窗口，都没有保存。

在关闭Sublime-Text时，它会挨个提示你保存文件。

因为太多没有保存的文件了。所以我不想它提示我，直接全部关闭就可以了。



## 背景

Sublime-Text是一款很好用的文本工具。

我有任何文本，我都会跑到Sublime-Text里面来进行编辑。

例如给字符串加序号啊。给字符串前后都加上一个双引号啊。多行操作非常方便。

但是我每次操作的时候，我都是直接`command+n` 新建一个窗口。

这样操作多了之后。我的Sublime-Text就有几百个没有关闭的窗口。当我想关闭他们时。Sublime-Text会挨个提示我是否保存。我手都麻了。

下面就是如何处理，它不要提示我，直接给我关闭就好了。



## 解决方案

### 1、直接删除Session文件【推荐方式】

（因为有用的文件我已经保存了，没有保存的文件全部都是没必要保存的。所以我敢这么直接操作。如果你不确定你是否所有有用的文件都已经保存，请不要使用这种方式）

找到你电脑上的Session文件。

这里面保存着你的每一个窗口的标题和内容（包括没保存的）。

直接把它删除就可以了。你再次打开Sublime-Text的时候，原本的窗口，就不会再出来了。


我电脑是mac os系统。操作方式如下。[其他系统可以参考这里](https://superuser.com/questions/894021/where-does-sublime-text-store-its-un-saved-windows)

```sh
# 进入到Sublime-Text
cd /Users/jason/Library/Application\ Support/Sublime\ Text\ 3/Local

# 查看当前目录下的文件
ls -la

# 修改session文件名
mv Session.sublime_session Session.sublime_session.backup
```


然后你再次打开你的Sublime-Text的时候，就发现重新打开了。

（注意：我平时都是直接command+W关闭程序退出的）



### 2、自己编写插件进行跳过

默认新建的窗口的文件都是保存在Session里面去的。（好像是，我也不确定）

我们可以修改它，新建文件时，将当前文件保存到暂存区，这样关闭窗口时就不会提示我们要保存文件了。

我这个脚本更加简单粗暴一点，当窗口获得焦点的时候，就直接设置文件保存到暂存区，它就不会提示你要保存了。

这是一个很危险的动作，不习惯按ctrl+s保存文件的同学，请谨慎操作。因为它不会提示你保存文件。

1. 新建插件

Tools -> Developer -> New Plugin

```py
import sublime
import sublime_plugin


class SetNewScratchBufferCommand(sublime_plugin.EventListener):
    def on_new(self, view):
        view.set_scratch(True)

    def on_save(self, view):
        view.set_scratch(False)

    def on_activated(self, view):
        view.set_scratch(True)
```

ctrl + s 保存

文件名`set_new_scratch_buffer.py`

**你现在可以去关闭所有窗口了。它不会提示你保存了**

我是 Mac OS 文件保存目录在
`/Users/jason/Library/Application Support/Sublime Text 3/Packages/User/set_new_scratch_buffer.py`

如果胆子大的话，你可以保留这个粗暴的脚本。

如果还是为了安全起见的话。你可以把这个脚本删除。下次需要用的时候再拿出来用。



## 参考链接

[未保存文件目录](https://superuser.com/questions/894021/where-does-sublime-text-store-its-un-saved-windows)

[sublimetext API Reference](https://www.sublimetext.com/docs/api_reference.html#sublime_plugin.EventListener.on_activated)

[https://www.jianshu.com/p/e6f4920b3cab](https://www.jianshu.com/p/e6f4920b3cab)

[https://www.jianshu.com/p/d0c8d5f71de9](https://www.jianshu.com/p/d0c8d5f71de9)

