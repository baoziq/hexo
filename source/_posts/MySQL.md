---
title: MySQL
author: baozi
categories: MySQL
---
# 如何进入MySQL控制台

```
win + R -> 输入cmd -> 输入 -uroot -p -> 输入密码
```

输入密码即可

# create

#### 建数据库：create database dbname;

例如：create database student;

#### 建表: create table tablename(列定义|表约束)

```sql
CREATE TABLE  StudentInfo
(	
    Sno char(9) PRIMARY KEY,
    Sname char(20) UNIQUE,
    Sage SAMLLINT,
    Sdept char(20)
 );
```

---



## ALTER TABLE

```sql
alter table table_name
[修改事项 [,修改事项]...]
```

常用的:

```sql
	ADD [COLUMN] 列名 数据类型 [列约束]
       [FIRST | AFTER col_name]
  | ADD {INDEX|KEY} [索引名] [类型] (列1,...) 
  | ADD [CONSTRAINT [约束名]] 主码约束
  | ADD [CONSTRAINT [约束名]] UNIQUE约束
  | ADD [CONSTRAINT [约束名]] 外码约束
  | ADD [CONSTRAINT [约束名]] CHECK约束
  | DROP {CHECK|CONSTRAINT} 约束名
  | ALTER [COLUMN] 列名 {SET DEFAULT {常量 | (表达式)} | DROP DEFAULT}
  | CHANGE [COLUMN] 列名 新列名 数据类型 [列约束]
        [FIRST | AFTER col_name]
  | DROP [COLUMN] 列名
  | DROP {INDEX|KEY} 索引名
  | DROP PRIMARY KEY
  | DROP FOREIGN KEY fk_symbol
  | MODIFY [COLUMN] 列名 数据类型 [列约束]
        [FIRST | AFTER col_name]
  | RENAME COLUMN 列名 TO 新列名
  | RENAME {INDEX|KEY} 索引名 TO 新索引名
  | RENAME [TO|AS] 新表名
```

---



总结:

- ADD用来添加列和约束 (主码、外码、CHECK、UNIQUE)
- DROP用来删除列、约束
- MODIFY用来修改列的定义 
- RENAME用来修改列、索引、和表的名称
- CHANGE用来修改列的名称、还可以修改列的定义 
