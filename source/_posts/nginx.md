---
title: nginx

---

```nginx
server {
        listen 8080;

        location /foo {
            echo "foo = [$foo]";
        }

        location /bar {
            set $foo 32;
            echo "foo = [$foo]";
        }
   }
$ curl 'http://localhost:8080/foo'
foo = []

$ curl 'http://localhost:8080/bar'
foo = [32]

$ curl 'http://localhost:8080/foo'
foo = []
```

Nginx 变量一旦创建，其变量名的可见范围就是整个 Nginx 配置，甚至可以跨越不同虚拟主机的 `server` 配置块，但是赋值操作在bar中实现，foo中的foo为空

```nginx
server {
    listen 80;
    server_name www.example.com;

    location /api/ {
        proxy_pass http://backend_api;
    }

    location /static/ {
        root /var/www/html;
    }

    location /admin {
        return 403;
    }
}
# server的作用是匹配域名和端口号，location的作用是匹配路径
```

```nginx
map $args $foo {
        default     0;
        debug       1;
}
# map为映射，args为自变量，foo为因变量，第一列为args的值，第二列卫foo对应的值，default类似于switch case中的default，当其他条件都不满足时，foo为0
# 注意： map不能在server中，与server是并列关系
server {
        listen 8080;

        location /test {
            set $orig_foo $foo;
            set $args debug;

            echo "original foo: $orig_foo";
            echo "foo: $foo";
        }
}
# $ curl 'http://localhost:8080/test'
#   original foo: 0
#   foo: 0
# 原因：$foo 变量在第一次读取时，根据映射规则计算出的值被缓存住了
```

```nginx
# nginx有11个阶段 postread -> server_rewrite -> find_config -> rewrite -> post_rewrite -> preaccess -> access -> postaccess -> precontent -> content -> log
location /test {
  set $a 32;
  echo $a;
  set $a 50;
  echo $a;
}
# 输出结果为 50 50 
# set输入rewrite；echo属于content，所有set都在echo之前执行
```

