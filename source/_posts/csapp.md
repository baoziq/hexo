---
author: baozi
title: csapp
categories: 课程
---

```c
#include <stdio.h>
int main() {
  printf("hello world\n");
  return 0;
}
```

预处理阶段：预处理器根据#开头的命令，读取头文件，并插入到程序中，得到.i文件

```c
# 1 "hello.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 31 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 32 "<command-line>" 2
# 1 "hello.c"






include <stdio.h>

int main()
{
 printf("hello world\n");
 return 0;

}
```

编译阶段：编译器将hello.i翻译成文本文件hello.s

```c
	.arch armv8-a
	.file	"hello.c"
	.text
	.section	.rodata
	.align	3
.LC0:
	.string	"hello world"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB0:
	.cfi_startproc
	stp	x29, x30, [sp, -16]!
	.cfi_def_cfa_offset 16
	.cfi_offset 29, -16
	.cfi_offset 30, -8
	mov	x29, sp
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	bl	puts
	mov	w0, 0
	ldp	x29, x30, [sp], 16
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
```

 汇编阶段：汇编器将hello.s翻译成机器语言的指令，将结果保存在.o文件中

链接阶段：hello.c文件中调用了printf()函数，printf函数存在于printf.o的程序中，链接器负责处理合并，得到可执行文件
