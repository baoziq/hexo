#!/bin/bash

set -e

echo "git pull"
git pull
echo "git add ."
git add .
commit_msg=${1:-"update: $(date '+%Y-%m-%d %H:%M:%S')"}
echo "git commit"
git commit -m "$commit_msg"
echo "git push"
git push origin main

echo "hexo clean"
hexo clean
echo "hexo g -d"
hexo g -d
echo "finish"

