---
title: git
author: baozi
categories: git
---

### 查看当前分支

`git branch -- show-current`

### 回退到上一个版本

```shell
git reset --hard HEAD~1
```

### 删除文件

```she
git rm filename
```

### 删除分支

```she
git branch -d branch_name
```

### 创建新分支

```shell
git checkout -b branch_name
git switch -c branch_name
```

### 回退到clone后的版本

```shell
git restore .
```

### 查看特定版本的文件

`git log -- file_name`：查看特定文件的提交记录

`git show COMMIT_ID：file_name`：查看某个历史提交的内容，注意，file_name要加路径，如果当前已经再对应的文件夹下，需要加`./`

`git diff OLD_COMMIT_ID NEW_COMMIT_ID -- file_name`：比较两个版本特定文件的区别

