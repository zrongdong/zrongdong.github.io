#!/bin/bash

# 获取当前时间
DATE=$(date)

echo "commit: ${DATE}\n";
# commit 
git add .
git commit -m "${DATE}"

# 推送到remote
git push origin master
git push github master