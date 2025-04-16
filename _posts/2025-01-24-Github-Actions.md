---
layout:     post
title:      "Github Actions"
subtitle:   "github自动化部署 自动化脚本"
date:       2025-01-24
author:     "Jason"
tags:
    - github action
---

我们经常写完代码，推送到代码仓库的时候，就希望它自动部署到线上。

其实github就能够支持这个功能。

这个有个专有名词叫CI/CD(持续集成/持续交付)

下面简单讲解一下github怎么做自动部署。



## 基本概念

### workflow(工作流)

在项目的`.github/workflows`目录下的`yml`文件就是一个flow。

当你仓库下存在这个文件时，github就会自动解析，在你指定的动作时，执行对应的任务。

### runs-on(运行平台)

也就是运行你的工作流的基础环境。
这里可选的有`ubuntu` 、 `windows` 、 `macOS`

### job(任务)

每个工作流里面都可以写多个任务去运行，执行任务。

### step(步骤)

每个任务都有多个执行步骤

### action(动作)

每个步骤，都可以引用一个别人写好的工具。只需要你传递指定的参数即可。

这就是为了简化我们的步骤。


## 简单实例

### 目的

我有一个Jekyll的博客项目

这个博客都是静态页面，我是部署在自己的服务器上面的。

我希望每次我推送新的提交之后，它都自动帮我部署到服务器上面去。

### 代码

```yaml
# 工作流命名
name: Deploy to Server
# 工作流触发条件
on:
  # 推送master分支时触发
  push:
    branches:
      - master
# 任务
jobs:
  # 任务命名
  build-and-deploy:
    # 任务运行平台 ubuntu
    runs-on: ubuntu-latest
    # 任务名
    name: Build & Deploy
    # 步骤
    steps:
      # 检出代码到运行目录
      - uses: actions/checkout@v4
      # 更改权限
      - name: Fix permissions for Docker volume
        run: chmod -R 777 $(pwd)
      # 使用源镜像构建项目
      - name: Build
        run: docker run --rm -v $(pwd):/srv/jekyll zhangrongdong/guoneiyuan:basic_v1.0 jekyll build
      # 把文件上传到服务器目录
      - name: Deploy to Server
        uses: easingthemes/ssh-deploy@main
        with:
          # 读取Github的 私密变量
          SSH_PRIVATE_KEY: ${{ secrets.PRIVATE_KEY }}
          # 复制时的参数
          ARGS: "-az --delete"
          # 源目录
          SOURCE: "./_site/"
          # 部署目标主机
          REMOTE_HOST: ${{ secrets.HOST }}
          # 部署目标主机端口
          REMOTE_PORT: ${{ secrets.PORT }}
          # 登录用户
          REMOTE_USER: ${{ secrets.USER }}
          # 部署目标目录
          TARGET: ${{ secrets.TARGET }}

```

私密变量配置

![](/image/2025-01-24/Snipaste_2025-01-24_17-44-58.png)




## 参考地址

- [https://www.ruanyifeng.com/blog/2019/09/getting-started-with-github-actions.html](https://www.ruanyifeng.com/blog/2019/09/getting-started-with-github-actions.html)

