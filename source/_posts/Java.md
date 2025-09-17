---
title: Java
author: baozi
categories: Java
---

**`System.arraycopy`**的用法

```java
System.arraycopy(Object src, int srcPos, Object dest, int destPos, int length)
```

src： 原数组

srcPos： 原数组要复制的起始位置

dest： 目的数组

destPos: 目的数组放置的起始位置

length: 复制的长度

**`removeIf`**的用法

```java
boolean removeIf(Predicate<? super E> filter)
```

`Predicate`是一个函数式接口，它定义一个带有参数的`bool`类型表达式，`removeIf`根据该表达式的值决定是否移除集合中的元素

示例：

```java
import java.util.ArrayList;
import java.util.List;

public class RemoveIfExample {
    public static void main(String[] args) {
        List<Integer> numbers = new ArrayList<>();
        numbers.add(1);
        numbers.add(2);
        numbers.add(3);
        numbers.add(4);
        numbers.add(5);

        // 使用 removeIf 移除偶数
        numbers.removeIf(n -> n % 2 == 0);

        // 打印剩余的元素
        System.out.println(numbers);  // 输出 [1, 3, 5]
    }
}

```

