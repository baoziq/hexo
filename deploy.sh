#!/bin/bash

set -e

git pull
git add .
commit_msg=${1:-"update: $(date '+%Y-%m-%d %H:%M:%S')"}
git commit -m "$commit_msg"
git push origin main

hexo clean
hexo g -d

