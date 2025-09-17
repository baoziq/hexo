---
author: baozi
title: Linux
categories: linux
---

### exit

执行exit系统调用后，进程会从运行状态转为僵尸状态(zombie),操作系统会销毁当前进程，释放资源

`exit`是c标准库的函数，`_exit`是系统调用，直接终止进程，不进行清理工作

`僵尸进程`: 进程已经终止，但是父进程还未回收其状态信息

### exec

将当前进程的地址空间替换为新的程序，但保留当前进程的pid

与`fork`配合使用，可以在子进程中运行一个新的程序

### fork

fork的作用是在当前进程下，创建一个新的进程，通常把这两个进程称为父进程和子进程，子进程的内存是复制父进程的，它们有独立的内存空间，fork在父进程中返回的值为子进程的pid，在子进程中返回的值为0,这就是为什么pid == 0可以判断它是子进程

```c++
int pid;
pid = fork();
if (pid == 0) {
  std::cout << "this is child process" << std::endl;
} else {
  std::cout << "this is parent process" << std::endl;
}
```

通过fork实现父子进程之间的读和写

 `read(fd[0], buf, sizeof(buf));`

`write(fd[1], buf, sizeof(buf));`

注意：默认情况下读用0，写用1，管道是单方向的，要实现两端的读和写需要两个管道，buf是指向缓冲区的指针

### wait

用于让父进程等待子进程结束的系统调用

### xargs

xargs的作用是读取标准输入，将其作为后面命令的参数

```bash
echo hello |xargs echo bye
```

上述命令的输出为`bye hello`





