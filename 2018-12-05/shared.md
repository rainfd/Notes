## ELK日志系统之通用应用程序日志介入方案

link: https://mp.weixin.qq.com/s?__biz=MzU5MDY1MzcyOQ==&mid=2247483784&idx=1&sn=5d8d6b6834ea8d78a3eb5e52aa267ff5&scene=19&ascene=7&devicetype=android-25&version=2607033a&nettype=WIFI&abtest_cookie=BAABAAoACwANABQABAAjlx4AWZkeAIiZHgCNmR4AAAA=&lang=zh_CN&pass_ticket=tfdA7eoN0NAxzLZ7VAveyTk2rU52NSHv5fu2t0egrlBTaKSW8LZoYTPfdnnjhrfd&wx_header=1

日志定为json格式，再加上一些简明的规范。
使用容器自带的Filebeat采集日志，
最后通过ELK查看日志

整体方案：
docker+app -> log -> filebeat -> kafka -> logstask -> elasticsearch <- kibana

整个流程简单，但看起来的效果不错。


## 又拍云OpenResty/Nginx服务优化实践

link: https://zhuanlan.zhihu.com/p/50873792?hmsr=toutiao.io&utm_medium=toutiao.io&utm_source=toutiao.io

文中提到nginx的常见的upstream使用方式:

```nginx
upstream backend {
    server x.com;
}

server {
    listen *:8080;
    location / {
        proxy_pass http://backend;
    }
}
```

upstream的server解析在nginx启动的时候就已经完成,
可以使用以下方式强制每次访问都进行解析.

```nginx
server {
    listen *:8080;
    resolver x.x.x.x:80 y.y.y.y:80;
    location / {
        set $backend x.com;
        proxy_pass http://$backend;
    }
}
```

但是还有问题，dns不会故障转移，出故障时使用旧数据，等等等。
