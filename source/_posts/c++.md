---
author: baozi
title: c++
categories: c++
---

### const

const位于星号左侧，const用于修饰指针指向的变量；const位于星号右侧，const修饰指针本身

```c++
int b = 500;
const int* a = &b; [1]
int const *a = &b; [2]
int* const a = &b; [3]
const int* const a = &b; [4] 
```

1和2是等价的，都表示指向常量的指针，3表示指针本身不可变，但是指向的内容可变

```c++
int a = 10;
int* const p = &a;
*p = 20; //合法
int b = 20;
p = &b;	//不合法，Cannot assign to readonly type int * const
```

const int 必须用const int * p来指向

int* const p必须初始化

顶层const(top-level const)表示指针本身是一个常量，底层const(low-level const)表示指针所指的对象是一个常量，更一般的，顶层const可以表示任意的对象是常量

constexpr修饰指针，constexpr仅对指针有效

函数体外定义的变量存放在固定地址，函数体外的变量则不是，constexpr指针和引用只能用于函数体外的变量

### constexpr

常量表达式(const expression)是指值不会改变并且在编译阶段就会得到计算结果的表达式

将变量声明为`constexpr`类型，由编译器来验证变量的值是否为常量表达式

自定义类、IO库、string类型不能被定义为constexpr

```c++
constexpr std::string str = "abc";
std::cout << str << std::endl;
// error: constexpr variable cannot have non-literal type 'const std::string' (aka 'const basic_string<char>')
```

constexpr指针初值必须是nullptr或0

```c++
int num = 20;
constexpr int* p = &num;
std::cout << *p << std::endl;
// error: constexpr variable 'p' must be initialized by a constant expression
```



### static

被static修饰的变量只能在当前文件访问，函数同理

```c++
// a.cpp 文件
static int a = 10;  // static 修饰全局变量
int main() {
    a++;  // 合法，可以在当前文件中访问 a
    return 0;
}

// b.cpp 文件
extern int a;  // 声明 a
void foo() {
    a++;  // 非法，会报链接错误，其他文件无法访问 a
}
```

修饰局部变量

```c++
void foo() {
    static int count = 0;  // static 修饰局部变量
    count++;
    cout << count << endl;
}

int main() {
    foo();  // 输出 1
    foo();  // 输出 2
    foo();  // 输出 3
    return 0;
}
```



### extern

用于声明外部变量

File1.c

```c
#include <stdio.h>

int globalVar = 42;  // 定义全局变量

void printVar() {
    printf("globalVar = %d\n", globalVar);
}

```

file2.c

```c
#include <stdio.h>

extern int globalVar;  // 声明外部变量

void modifyVar() {
    globalVar = 100;  // 修改外部变量
}

```

函数同理，extern还可以链接c和c++，用extern声明一个函数是c语言，则该函数可以在c++文件中使用

c

```c
#include <stdio.h>

void hello() {
    printf("Hello from C!\n");
}

```

c++

```c++
#include <iostream>

extern "C" void hello();  // 告诉编译器这个函数是 C 语言的

int main() {
    hello();  // 调用 C 代码中的 hello() 函数
    return 0;
}

```

### vector

``` c++
#include<vector>

// 声明
vector<int> vec1; //声明空的vector
vector<int> vec2(5); // 声明大小为5的vector
vector<int> vec3(5, 10); //声明大小为5且值都为10的vector
vector<int> vec4{1, 2, 3, 4, 5}; //初始化
vector<int> vec5(vec4); // 用另一个vecotr初始化

// 用法
vec.push_back(x); //在末尾添加元素
vec.emplace_back(x);	//在末尾添加元素，比push_back更快，push_back需要先构造，再复制，emplace_back直接在容器内构造，不需要复制
vec.pop_back(); //删除最后一个元素
int num = vec.back(); //获取最后一个元素
vec.erase(vec.begin() + 1); //删除指定位置的元素
vec.erase(vec.begin() + 1, vec.edn() - 1); // 删除指定范围的元素
vec.clear(); // 清空vector
int n = vec.size(); // 获取vec的大小
vec.resize(x); //动态调整大小，x比n大补0， x比n小，超出的部分移除
sort(vec.begin(), vec.end()); // 升序
sort(vec.begin(), vec.end(), greater<int>()); // 降序
int it = find(vec.begin(), vec.end(), 3); //查找值为3的元素
vec.remove(vec.begin(), vec.end(), 5); // 将值为5的元素移动到容器末尾
if (!vec.empty())；	//判空
int sum = accumulate(vec.begin(), vec.end(), 0)	//求和，初始值为0
int max_num = *max_element(vec.begin(), vec.end())//数组中的最大值
vec.insert(vec.end(), vec.begin(), vec.end())	//在vec的后面添加vec例如123->123123z
//在一个vector的后面添加另一个vector
vector<int> vec1 = {1, 2, 3};
vector<int> vec2 = {4, 5, 6};
vec1.insert(vec1.end(), vec2.begin(), vec2.end());
// 二维数组
int row = 3;
int col = 4;
vector<vector<int>> nums(row, vector<int>(4));
```

###  atoi stoi

``` c++
const char* str = "abc";

// atoi
int result = atoi(str); //将字符串转换为数字

// stoi
try {
  std::string str = "abc";
  int result = std::stoi(str);
} catch (const std::invalid_argument& e) {
  std::cout << "Invalid argument:" << e.what() << std::endl;
}
```

stoi提供了更安全的方式

### tolower, toupper

```c++
#include <cctype>
string str = "Hello World";
string res;
for (char ch : str) {
  res += tolower(ch); //转为小写
}
for (char ch : str) {
  res += toupper(ch); //转为大写
}

// 更简单的方法
for (char ch : str) {
  ch ^= 32;
}
// 'A'(65) ⊕ 32 = 'a'(97)
// 'a'(97) ⊕ 32 = 'A'(65)
```

### unordered_map

哈希表

```c++
// 声明
unordered_map<char ch, int n> my_map;
my_map.insert({'a', 2}); 	// 插入元素
my_map[b] = 1; // 如果键不存在会创建并初始化
// 遍历
for (const auto& pair: my_map) {
  cout << pair.first << pait.second << endl;
}
// find的用法
auto it = umap.find("a");
if (it != umap.end()) {
    std::cout << "Found: " << it->first << " -> " << it->second << std::endl;
} else {
    std::cout << "Not found!" << std::endl;
}
// count,返回键是否存在（0 或 1）
if (umap.count("a") > 0) {
    std::cout << "Key exists!" << std::endl;
}
// 清除特定元素
umap.erase(target);
// 在滑动窗口题目中可以这样使用
if (--cnt[nums[i - k + 1]] == 0) {
	cnt.erase(nums[i - k + 1]);
 }
```

### sort

```c++
//基础用法
vector<int> nums = {2, 3, 1, 0, 4};
sort(nums.begin(), nums.end());	// 默认升序
sort(nums.begin(), nums.end(), std::greater());	//降序排列
// 自定义排序
struct Student {
    std::string name;
    int score;
};

// 自定义排序规则
bool compareStudents(const Student& a, const Student& b) {
    if (a.score == b.score)  // 分数相同，按姓名排序
        return a.name < b.name;
    return a.score > b.score; // 分数降序
}

```



### 引用和指针

```c++
int a = 10;
int &b = a;
b = 20;
cout << a << endl;	// 20
```

b是a的引用，就是给a起个别名，对b进行操作实际上就是对a进行操作

```c++
int* a = null;
int& b;	//error
```

指针可以指向空，但是引用不能为空

```c++
int a = 10;
int &b = a;
int c = 30;
int &b = c;	//error
```

指针可以随意改变（除const修饰外），引用一旦绑定就不可以再改变

### 静态链接和动态链接

.cpp文件经过预处理成为.i文件，.i文件经过编译后成为.s文件，.s文件经过汇编后成为目标文件，即.o，静态链接将该.o文件和其他目标文件以及库文件链接起来，这个过程称为静态链接。

而动态链接将这个过程推迟到了运行时，由操作系统装载程序加载库

静态链接的代码装载速度快，但是文件体积大

动态链接的速度慢，但是文件体积小

### c和c++的区别

1. c只支持基本数据类型，还有结构体、枚举、联合；c++支持类和对象
2. c++有封装的特性、有构造函数和析构函数、c++支持函数重载，可以定义同名但是参数列表不同的函数；c都做不到
3. c++有异常处理机制；c没有
4. c没有引用&

### delete

释放new申请的空间，会调用析构函数

```c++
#include <iostream>

class MyClass {
public:
    MyClass() {
        std::cout << "构造函数" << std::endl;
    }
    ~MyClass() {
        std::cout << "析构函数" << std::endl;
    }
};

int main() {
    MyClass* obj = new MyClass();
    delete obj;
    return 0;
}
```

### 作用域解析操作符

访问全局变量

```c++
#include <iostream>

int num = 20;

void test() {
    int num = 10;
    std::cout << "test1:" << num << std::endl;
    std::cout << "test2" << ::num << std::endl;
}

int main() {
    int num = 30;
    test();
    std::cout << "test3:" << num << std::endl;
    std::cout << "test4:" << ::num << std::endl;
    return 0;
}
```

访问命名空间中的标识符

```c++
#include <iostream>

namespace MyNamespace {
    int val = 20;
}

int main() {
    std::cout << MyNamespace::val << std::endl;
    return 0;
}
```

### 访问修饰符

`public`:可以在任何函数中访问

`protected`:只能在类中或者类的子类中访问

`private`：只能在类中访问

### strlen 和sizeof

```c++
char ch[] = "Hello World";
std::string str = "Hello World";
std::cout << sizeof(ch) << std::endl;	//12
std::cout << strlen(ch) << std::endl;	//11
std::cout << sizeof(str) << std::endl;	//24(windows|macos) 32(linux)
```

对于char ch[]类型，是c风格的字符串，在末尾会自动加\0

sizeof会统计末尾的\0

strlen不统计

### string 和char ch[]

string在堆上分配内存，sizeof获取的是string类的大小

char ch[]在栈上分配内存

### lambda函数

```c++
[capture list] (parameter list) -> return type { function body }

```

`capture list` 表示获取列表用于表示lambda可以访问的外部变量

`paramete list`表示lambda的参数

`return type`表示返回类型

`function body 表示函数体

#### 值捕获

```c++
int x = 10;
auto f  = [x] (int y) -> int {return x + y;};
x = 20;
cout << f(5) << endl;	//15
```

#### 引用捕获

```c++
int x = 10;
auto f = [&x] (int y ) -> int {return x + y;};
x = 20;
cout << f(5) << endl;	//25
```

### 类型别名

#### typedef

```c++
typedef double wages;	// wages是double的同义词
typedef wages base, *p;	//base是double的同义词，p是double*的同义词
```

#### using

```c++
using SI = Sales_item;
```

### explicit

防止隐式类型转换

```c++
class MyClass {
  public:
  	MyClass(int x){}
}
void doSomething(MyClass obj) {
  
}
int main() {
  dosomething(5);	// 合法，但是隐式构造了一个MyClass(5);
}

// 有explicit
class MyClass {
  public:
  	explicit MyClass(int x){}
}
void doSomething(MyClass obj) {
  
}
int main() {
  dosomething(5);	// 编译错误
  dosomething(MyClass(5));	// 正确
}
```

### string_view

```c++
#include <string_view>
#include <iostream>

// 它是对字符串的一个视图，指向一段连续的字符序列，但不拥有数据。类似于一个只读的“窗口”
void print(std::string_view sv) {
    std::cout << "String view: " << sv << '\n';
}

```

### 类型转换

#### static_cast

```c++
#include <iostream>

using namespace std;

int main() {
	int num = 97;
	char ch = static_cast<char>(num);
	cout << ch << endl;	// a
}
```

`static_cast`用法，`static_cast<要转换的类型>（变量）`

#### `dynamic_cast`

1. 上行转换，从子类转换成父类
2. 下行转换，从父类转换成子类， 且要求父类中至少有一个虚函数

#### `const_cast`

1. 移除`const`修饰符
2. 添加`const`修饰符

#### `reinterpret_cast`

1. 指针类型的转换
2. 指针和整数之间的转换
3. 非相关类型的转换

### 数组指针 todo，primer6.3
数组不能被拷贝，所以在函数中无法返回数组，但是可以返回数组的指针或引用
在写一个返回数组指针的函数时，可以用别名来声明
```c++
typedef int arrT[10];   // 为int[10]起一个别名
using arrT = int[10];   // 等价上面
// 有了别名，可以定义返回数组指针的函数了
arrT* function(int n);  //接受一个int类型的参数，返回一个指向包含十个int数组的指针
```
如果不想使用别名来声明函数，需要了解下面三个的区别
```c++
int *arr[5] = {1, 2, 3, 4, 5};  // 声明了一个大小为5的数组
int *p1[5]; // 声明了一个包含5个指针的数组，它是一个指针数组，数组元素是指针
int (*p2)[5] = &arr;    // 声明了一个指针，它指向arr
```

### deep copy and shallow copy
```c++
class Person {
private:
    int age_;
    string name_;
public:
    Person(int age, string name) : age_(age), name_(name);
    // 拷贝构造函数
    Person(const Person& person);
   
}
Person::Person(const Person& person) {
    age_ = person.age_;
    name_ = person.name_;
}
```
对于基本数据类型，浅复制可以实现，但是当类中有引用或者指针时，就需要用到深复制
在写拷贝构造函数的时候，必须将参数写成引用，一是引用可以避免拷贝，二是c++语法要求，否则，在传参的时候就会调用拷贝构造函数，进入无限循环
而且最好写成`const`类型，这样非`const`类型也可以传入

### rvalue
`int a = 5`在这句代码中，a表示左值(`lvalue`)，5表示右值(`rvalue`)，左值表示在内存中可以找到它，右值在内存中找不到，
右值是一个立即数(`immediate number`)，
```c++
int a = 20; // correct, a is a lvalue
20 = 30;    // incorrect, 20 is a rvalue
int &lref = a; // 左值引用
int &&rref = 20;    //右值引用
```
在写函数的参数时，最好将参数定义为const引用类型，首先可以保证函数内部不会对参数做出修改，而且引用不会进行拷贝操作；其次，const引用可以传入右值引用，而非const的左值引用只能传入左值。例如，当传入的参数为具体的数字的时候，此时参数为右值，如果函数参数定义为const引用，可以传入，否则会出错
