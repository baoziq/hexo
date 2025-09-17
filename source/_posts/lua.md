---
title: lua的使用
---

```lua
print("2" + 8)
-- 输出结果为10， 类型为number，lua中只有number这一种数字类型
```

```lua
-- 字符串连接
str = 123 .. 456
-- 输出结果为123456，类型为string
```

```lua
-- 获取字符串长度
str = "this is a test."
print(type(str))
```

```lua
local x = 10	-- 局部变量
x = 10 -- 全局变量
```

```lua
-- lua中的函数可以当作变量
function factorial1(n) 
  if n == 0 then
    return 0
  else 
    return n * factorial1(n - 1)
  end
end
print(factorial1(10))
factorial2 = factorial1;
print(factorial2(10))
```

```lua
-- if ip is true return ip, if ip is nil return "unknow"
return ip or unknow
```

### `lua`的八种数据类型
`nil`：空类型
`boolean`
`number`:整数和浮点数都用number表示
`string`：可以有三种表示方式
```lua
str1 = 'this is test1'
str2 = "this ia test2"
-- 第三种方式可以换行
str3 = [[
    this
    is
    test3
]]
```
`function`：function表示lua中的函数，可以接受多个参数，也可以用`...`表示可变数目的参数，function可以返回多个参数
`userdata`：用户自定义数据
`thread` -- todo
`table` 相当于数组，下标从1开始，里面的元素可以是各种类型的，函数也可以作为元素
```lua
tb = { 
        function() return '123' end,
        fucntion() print("abc) end,
        function(a, b) return a + b end,
    }
```
table还可以当作哈希表
```lua
tb = {
    apple = 3,
    banana = 4,
    ["tt"] = 5,
}
print(tb["apple"])
print(tb.banana)
print(tb.["tt"])
```
