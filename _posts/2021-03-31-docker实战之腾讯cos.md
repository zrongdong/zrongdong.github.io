---
layout:     post
title:      "Docker实战之腾讯cos"
subtitle:   "使用hub的镜像工具使用cos"
date:       2021-03-31 09:09:15
author:     "张晨"
tags:
    - docker
---



# 简介

> 需求是这样的，我需要从linux服务器上面上传文件到腾讯的cos里面去。根据cos官网文档的指示，我需要下载一个coscmd的工具，它是基于python的。我安装了多次安装不下来。(因为我对python不了解，也不了解pip)。
>
> 我自己安装不了，难道就不准我是用docker安装了吗？小问题。



## 操作步骤

- 搜索是否有`coscmd`的镜像

```sh
docker search coscmd
## 结果
NAME                                DESCRIPTION                                     STARS               OFFICIAL            AUTOMATED
gjz010/coscmd                                                                       0
ocavue/coscmd                                                                       0
panwenbin/coscmd                    COSCMD tool for qcloud COS                      0
haloislet/coscmd                                                                    0
orangeciplugins/tencentyun-coscmd   【腾讯云插件】使用 COSCMD 工具，用户可通过简…                     0
qianchenglong/coscmd                                                                0
jaehue/coscmd                                                                       0
bigbugteam/coscmd                                                                   0
xiaodajun/coscmd                    里面包含 node ，将 debian 和 pip 都切换为阿…                0
neosus/landing-build                aws, coscmd and tccli                           0
wangshiqiang/coscmd                                                                 0
airdb/coscmd                                                                        0
surenkid/ktsee-coscmd               COSCMD tool from tencent cloud, automatic ba…   0
aslinwang/python-nodejs-coscmd      qcloud coscmd in python-nodejs image            0

```

看一下。反正上面都不是官方的，能用就行，要求没那么高。那我就挑选了`panwenbin/coscmd`这个镜像吧。你真是个幸运儿。

**注释：是因为我的技术有限，不想自己搭建coscmd的环境，所以才用别人的镜像，不然的话，完全可以自己打包一个coscmd的镜像**



- 拉取镜像

```sh
## 拉镜像
docker pull panwenbin/coscmd

## 可以执行查看当前主机上的镜像
docker images
```



- 启动镜像

```sh
docker run -it -d panwenbin/coscmd /bin/bash
6242a56160e704559b644e08903757959b88e1e5959f5539f211d064fb9c099d

## 进入容器，容器id为上一条结果的输出，例如我就是
docker exec -it 6242a56160e7 bash
```



- 配置和验证命令

```sh
## 查看命令是否存在
coscmd --help
```

> 然后根据官网文档自己进行配置。配置成功之后，自行上传一个文件尝试是否成功。这里不是讲解的重点。

- 将配置文件拷贝出来本地

```sh
docker cp 6242a56160e7:/root/.cos.conf ./
```

----

然后好像就大功告成了。我们可以尝试一下能不能上传文件

```sh
## 如下命令是运行一个镜像
## --rm 容器结束后删除容器
## -v 挂在目录
## coscmd upload /root/a.txt test/ 将文件上传到cos的test目录中
docker run --rm -v $(pwd)/.cos.conf:/root/.cos.conf -v $(pwd)/a.txt:/root/a.txt panwenbin/coscmd coscmd upload /root/a.txt test/
```

结果就是成功了。

然后我们就可以每次通过这种方式上传文件到cos了。速度还是蛮快的。



## 扩展

我将上面的操作步骤搞成了一个命令。然后只需要执行这个命令就可以上传文件了。减轻我们的操作步骤

```shell
#!/bin/bash
if [ -n "$1" ]; then
    docker run --rm -v /root/.cos.conf:/root/.cos.conf -v $1:$1 panwenbin/coscmd coscmd upload $1 test/
else
    echo "没有包含第一参数"
fi
```

> 上面的应该都能看懂吧，就不解释了。
>
> `chmod +x upload2cos`让其可以执行就好了

测试一下

```sh
./upload2cos /root/b.txt
```