---
author: baozi
title: shell
categories: missing-semester
---

echo

```shell
echo [-neE] [ARGUMENTS]
```

- 当-n 选项，则取消尾随换行符

- 如果-e 选项，则将解释以下反斜杠转义字符:
  - \ 显示反斜杠字符
  
  - \a 警报(BEL)
  
  - \b 显示退格字符
  
  - \c 禁止任何进一步的输出
  
  - \e 显示转义字符
  
  - \f 显示窗体提要字符
  
  - \n 显示新行
  
  - \r 显示回车
  
  - \t 显示水平标签
  
  - \v 显示垂直标签
  
  - 这个-E 项禁用转义字符的解释。这是默认值
  
    