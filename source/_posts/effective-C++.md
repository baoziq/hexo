---
title: effective-C++
---



### 1 view c++ as a federation of languages

#### c

pass by value比pass by reference更高效，c中的引用实质上还是指针

#### object-oriented c++

有构造函数和析构函数存在，传值会调用拷贝构造函数和析构函数

#### template c++

pass by reference 更高效，在使用模版时，并不知道是什么类型，使用reference不用拷贝

pass by reference-to-const

#### STL

### 2 prefer const enum inline to define

```c++
#define PI 3.14
const pi =3.142 
```

const 比define更好

```c++
class foo{
  private:
  	static const int num = 5;
  	int score[num];
}
```

num是类中的专属常量，如果在类外取它的地址的话，需要在类外给出定义式

```c++
const int foo::num;
```

```c++
#include <iostream>

class foo {
public:
    static const int num;
};
const int foo::num = 5;
int main() {
    const int* p = &foo::num;
    std::cout << *p << std::endl;
}

```

如果不在类外给出定义式，在类外访问num的地址会出现错误，原因是并没有给num分配内存

```c++
class foo {
public:
    static const int num = 9;
};
```

也没分配地址，所以要在外面给出定义式，在类中仅仅只是声明式

```c++
class foo {
public:
    static const int num = 5;
};

int main() {
    std::cout << foo::num << std::endl;
}
```

像这样，虽然能够输出num的值，但是并没有给num分配内存，仅仅只是替换成5

也可以这样写

```c++
class foo{
  private:
  	enum {num = 5};
  	int score[num];
}
```

使用`inline`替换'#define'

### 3 use const whenever possible



