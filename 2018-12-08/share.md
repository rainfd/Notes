## About TiDB



### TiDB 架构的演进和开发哲学

Link: https://segmentfault.com/a/1190000008288188

详细地介绍了TiDB从零实现的技术选型、需求、架构等等的方面



### TiDB 原理三部曲

TiKV存储 https://pingcap.com/blog-cn/tidb-internal-1/

TiDB计算 https://pingcap.com/blog-cn/tidb-internal-2/

PD调度 https://pingcap.com/blog-cn/tidb-internal-3/





## 一次IPS防火墙导致的传输失败

出去安全的考虑，服务部署分为两个区域，一个dmz用于连接外网，一个业务区在内网。

从dmz到业务区需要经过IPS防火墙。

现在有一个业务需要从dmz区通过HTTP PUT请求上传文件到业务区。上传文件时会失败，文件只有一部分内容。

然后开始找问题：

1. 文件请求使用的是chunked编码，不使用chunked直接将内存中的数据上传是没问题的。

2. 使用nodejs curl python分别写了一个使用chunked上传文件的请求，只有python的可以

3. 在两边抓包，在dmz发现握手完成，传了一个包后，就接受到RST了，然后看ttl，是127，而两边系统的默认值都只有64，基本可以确定是防火墙了。跟管理员联系，他那边有警报。

   具体规则：[CVE-2013-4322](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2013-4322)
    Apache.Tomcat.Large.Chunked.Transfer.DoS

   tomcat处理chunked传输大文件时没有做好处理，可能会被入侵。

   因为服务跟tomcat无关，让管理员直接加例外就行了。

