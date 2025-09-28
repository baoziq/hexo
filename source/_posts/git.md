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

