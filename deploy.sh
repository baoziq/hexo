#!/bin/bash

set -e  # 发生错误立即退出

echo "git pull"
git pull origin main

echo "hexo clean"
hexo clean
echo "hexo g -d"
hexo g -d

echo "git add ."
git add .
commit_msg=${1:-"update: $(date '+%Y-%m-%d %H:%M:%S')"}
echo "git commit"
git commit -m "$commit_msg" || echo "No changes to commit"
echo "git push"
git push origin main

echo "finish"
