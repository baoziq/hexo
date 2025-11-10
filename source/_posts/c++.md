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

如果想按值捕获所有外部变量，`[=]`

#### 引用捕获

```c++
int x = 10;
auto f = [&x] (int y ) -> int {return x + y;};
x = 20;
cout << f(5) << endl;	//25
```

如果想按引用捕获外部所有变量`[&]`

#### 递归

lamda函数写递归函数

```c++
auto dfs = [&](this auto&& dfs, int i, int j) -> void {}
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

#### auto

c++11中引入了auto，它能让编译器分析表达式所属的类型

```c++
auto item = val1 + val2;
```

根据val1与val2相加的值来推断出item的值



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

#### `static_cast`

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

### 数组指针 todo，(primer 6.3)

可在c中实现多态

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

### move
```c++
int a = 20;
int b = move(20);
```
b和a分别有自己的地址，a和b各存一份数据，int没有动态分配，所以只能复制，所以move对于基本类型没有实际作用
```c++
class vector{
    int* data;
    size_t size;
    size_t capacity;
}
```
这是vector的定义，所以对于下面的代码
```c++
vector<int> vec1 = {1, 2, 3, 4, 5};
vector<int> vec2 = std::move(vec1);
```
会执行下面的操作
```c++
vec2.data = vec1.data;
vec1.data = nullptr;
vec1.size = 0;
vec1.capacity = 0;
```
它会将vec1的内容“偷”过来，避免复制。

### 多态

多态分为两种，一种是运行时多态，一种是编译时多态

#### 运行时多态

运行时多态就是虚函数+继承

```c++
#include <iostream>

class Base {
public:
    virtual void foo() {cout << "base foo" << endl;}
};

class Derived : public Base {
public:
    void foo() {cout << "derived foo" << endl;}
};

int main() {
    Base* p = new Derived();
   p -> foo();
}
```

在上面的例子中，base中foo定义为虚函数，所以在p调用foo时，实际调用的时derived中的foo

```c++
Derived* p = new Derived();
p->derivedOnlyMethod(); // ✅ 直接访问派生类独有成员
delete p;   
```

```c++
Base* p = new Base();
p->foo();  // 调用 Base::foo()
delete p;  // 调用 Base::~Base()
```

```c++
Base* p = new Derived();  // upcast
p->foo();  // 如果 foo 是 virtual，调用 Derived::foo()
delete p;  // 如果 ~Base 是 virtual，调用 Derived::~Derived() + Base::~Base()

```

上面这三种定义指针的方式

​	第一种限制死了p的类型，只能是derived，如果后续想要更换其他派生类的话，需要该所有Derived

​	第二种p只能是基类

​	第三种是多态的标准写法，p的类型是Base*，所以只能通过p访问基类中的接口，但是如果Base中的接口定义为虚函数，调用时会动态绑定到Derived中的实现



在c++中，析构函数可以定义为虚函数，而且当析构函数定义为虚函数之后，delete p会调用派生类中的析构函数，否则，只会调用基类中的析构函数；构造函数不能定义为虚函数，虚函数依赖虚函数表，虚表指针在构造函数中初始化的

#### 编译时多态

模板+函数重载

函数重载

```c++
void print(int x) { std::cout << "int\n"; }
void print(double x) { std::cout << "double\n"; }

int main() {
    print(10);   // 编译期决定调用 print(int)
    print(3.14); // 编译期决定调用 print(double)
}

```

模板

```c++
template <typename T>
struct Base {
    void call() {
        static_cast<T*>(this)->impl(); // 静态多态
    }
};

struct Derived : Base<Derived> {
    void impl() { std::cout << "Derived\n"; }
};

int main() {
    Derived d;
    d.call();  // 编译期决定调用 Derived::impl()
}

```

### `noexcept`

用于说明一个函数不会抛出异常，或者用来检测一个表达式是否可能抛异常

```c++
void foo() noexcept{}
```

```c++
struct A {
    A(const A&) { std::cout << "copy\n"; }
    A(A&&) noexcept { std::cout << "move\n"; }
};

std::vector<A> v;
v.emplace_back();
v.push_back(A{});  // 如果移动构造是 noexcept，vector 扩容时用 move，否则可能用 copy

```

```c++
noexcept(expression)
```

这是一个常量表达式，结果是true或者false，表示expression在当前上下文是否可能抛异常

```c++
#include <iostream>

void might_throw();
void never_throw() noexcept;

int main() {
    std::cout << noexcept(might_throw()) << "\n";  // 可能抛异常 => 输出 0
    std::cout << noexcept(never_throw()) << "\n";  // 承诺不抛 => 输出 1
}
```

### 纯虚函数

纯虚函数是一种特殊的虚函数，在声明时写成=0

```c++
struct Base {
    virtual void hello() = 0;  // 纯虚函数
};
```

它的实现必须由派生类提供

含有至少一个虚函数的类叫做抽象类，它不能直接实例化

```c++
#include <iostream>

struct Base {
    virtual void hello() = 0;  // 纯虚函数
};

struct Derived : Base {
    void hello() override { std::cout << "Derived\n"; }
};

int main() {
    // Base b;         // ❌ 错误：抽象类不能实例化
    Base* b = new Derived();
    b->hello();          // ✅ 输出 "Derived"
}
```

### Rule of three

如果类定义了析构函数、拷贝构造函数、或拷贝赋值运算符中的一个，几乎总是需要显式的定义另外两个。

因为当你显式定义了其中一个的时候，意味着类涉及到一些资源管理，

```c++
#include <iostream>

class MyArray {
public:
	MyArray(size_t n) : size(n), data(new int[n]) {}
	~MyArray() { delete[] data; }
private:
	std::size_t size;
	int* data;
};

int main() {
	MyArray a(10);
	MyArray b = a;
	
}
```

在上面这段代码中，如果不写拷贝构造和拷贝赋值的话，编译器会自动写，但是这样，a和b中的data指向的是一个地址，data会被释放两次，导致程序崩溃。

### 虚函数

​	对于虚函数的调用在运行时才会被解析，直到运行时才能确定使用哪个版本的虚函数，所以每个虚函数必须有定义。

​	一个函数被声明成虚函数，则在所有的派生类中，它都是虚函数，但是如果派生类中的虚函数参数列表和基类中函数参数列表不相同，编译器不会报错，所以需要在派生类的虚函数中显示的写出override

​	虚函数中可以有默认实参，该实参值由本次调用的静态类型决定，如果使用基类的指针调用函数，则使用基类中定义的默认实参。

```c++
class Base {
public:
	virtual void print(int a = 3) {
		std::cout << "num = " << a << std::endl;
	}
};

class Derived : public Base {
public:
	void print(int a = 4) override {
		std::cout << "num = " << a << std::endl;
	}
};

int main() {
	Base* p = new Derived();
	p->print();	// 输出3
}
```

### 设计模式

#### LSP（里氏替换）

子类能够替换所有父类出现的地方，而且代码能够正常运行

```c++
#include <iostream>
using namespace std;

class Bird {
public:
    virtual void fly() {
        cout << "Bird flies" << endl;
    }
};

class Sparrow : public Bird {
public:
    void fly() override {
        cout << "Sparrow flies quickly" << endl;
    }
};

void makeBirdFly(Bird* b) {
    b->fly();
}

int main() {
    Bird b;
    Sparrow s;

    makeBirdFly(&b);  // 输出 Bird 版本
    makeBirdFly(&s);  // 输出 Sparrow 版本
    return 0;
}

```

在上述代码中，父类指针接收子类对象，代码仍然可以正常运行，这就是里氏替换

下面是一个不符合里氏替换的例子

```c++
#include <iostream>
using namespace std;

class Rectangle {
public:
    virtual void setWidth(int w) { width = w; }
    virtual void setHeight(int h) { height = h; }

    int getWidth() const { return width; }
    int getHeight() const { return height; }

protected:
    int width = 0;
    int height = 0;
};

class Square : public Rectangle {
public:
    void setWidth(int w) override {
        width = w;
        height = w;   // 强制保持正方形性质
    }
    void setHeight(int h) override {
        width = h;
        height = h;   // 同上
    }
};

void test(Rectangle* r) {
    r->setWidth(4);
    r->setHeight(5);
    cout << r->getWidth() << " " << r->getHeight() << endl;
}

int main() {
    Rectangle r;
    Square s;

    test(&r);  // 输出 4 5
    test(&s);  // 输出 5 5  逻辑被破坏
    return 0;
}

```

在这个例子中，test函数要分别设置矩形的长和宽，但是square保持了正方形的特性，子类不能替代父类，违背里氏替换原则

#### ISP（接口隔离）

不要让一个类被迫依赖它不需要的功能，大接口要拆成小接口

```c++
class IWorker {
public:
    virtual void work() = 0;
    virtual void eat() = 0;
    virtual void sleep() = 0;
    virtual ~IWorker() = default;
};

class Robot : public IWorker {
public:
    void work() override { cout << "Robot working" << endl; }
    void eat() override {}    // 机器人不会吃
    void sleep() override {}  // 机器人不会睡
};

```

正确使用方法

```c++
class IWork {
public:
    virtual void work() = 0;
    virtual ~IWork() = default;
};

class IEat {
public:
    virtual void eat() = 0;
    virtual ~IEat() = default;
};

class ISleep {
public:
    virtual void sleep() = 0;
    virtual ~ISleep() = default;
};

class Human : public IWork, public IEat, public ISleep {
public:
    void work() override { cout << "Human working" << endl; }
    void eat() override { cout << "Human eating" << endl; }
    void sleep() override { cout << "Human sleeping" << endl; }
};

class Robot : public IWork {
public:
    void work() override { cout << "Robot working" << endl; }
};

```

#### DIP（依赖倒置）

高层模块不依赖底层模块，大家一起依赖抽象；抽象不依赖细节，细节依赖抽象

```c++
class MySQL {
public:
    void connect() {
        cout << "Connect to MySQL" << endl;
    }
};

class UserService {
public:
    void login() {
        db.connect();  // 直接写死数据库类型
    }
private:
    MySQL db;
};

```

UserService绑定mysql，之后如果要更换数据库，都需要改UserService

正确方法

```c++
class IDatabase {
public:
    virtual void connect() = 0;
    virtual ~IDatabase() = default;
};

class MySQL : public IDatabase {
public:
    void connect() override {
        cout << "Connect to MySQL" << endl;
    }
};

class PostgreSQL : public IDatabase {
public:
    void connect() override {
        cout << "Connect to PostgreSQL" << endl;
    }
};

class UserService {
public:
    UserService(IDatabase* db) : db_(db) {}

    void login() {
        db_->connect();
    }
private:
    IDatabase* db_;
};
int main() {
    MySQL mysql;
    PostgreSQL pg;

    UserService service1(&mysql);
    service1.login();

    UserService service2(&pg);
    service2.login();
    return 0;
}


```

新加数据库直接添加就可以，不需要修改原本的代码，
