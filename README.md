### 启动说明(Docker)
1. 你需要下载docker镜像
```
docker pull ccr.ccs.tencentyun.com/zrongdong/images:jekyll_cos
```

2. 你需要运行起来
```
docker run --rm -v $(pwd):/srv/jekyll -it -p 4000:4000 ccr.ccs.tencentyun.com/zrongdong/images:jekyll_cos jekyll server
```

3. 如果你只需要构建(`_site文件夹`)。
```
docker run --rm -v $(pwd):/srv/jekyll -i -p 4000:4000 ccr.ccs.tencentyun.com/zrongdong/images:jekyll_cos jekyll build
```

4. 构建并推送到腾讯COS
```
docker run --rm -v $(pwd):/srv/jekyll -it ccr.ccs.tencentyun.com/zrongdong/images:jekyll_cos sh -c "jekyll b && coscli sync ./_site/ cos://blog-1256312020/ -r --thread-num=10"
```



完成


- [**Hexo**](https://github.com/Kaijun/hexo-theme-huxblog)

