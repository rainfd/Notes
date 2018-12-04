## Nginx Learing

Link: [极客时间Nginx陶谦视频课](https://time.geekbang.org/course/intro/138)

### feature

- 32Core/64G 千万并发
- 第三方模块生态丰富
- 多个版本: nginx, nginx plus, tengine, openresty(API 服务器，防火墙), openresty 商业

### Nginx组成

Core + Conf + Access log + Error log

### Nginx Tips

将nginx目录contrib下的vim复制到~/.vim/下，就可以让vim支持nginx的语法高亮了(mac osx无效？？)

#### Nginx 热部署&日志切割

##### 热部署

```bash
#backup
mv /usr/local/bin/nginx /usr/local/bin/nginx.old
cp obj/nginx /usr/local/bin
# 创建新的master process
# 新老master/worker 并存，只是旧的worker不再监听端口
kill -USR2 $old.pid 
# 优雅关闭旧的worker进程
# 旧的master还在，可以回滚nginx -s reload
kill -WINCH $old.pid
# 关闭旧的master
kill -QUIT $old.pid
```

##### 日志切割

```bash
# 1. 转移日志文件
# 可以直接转移日志的原因是，在linux的文件系统中，改名不会影响已经打开的文件写入操作，内核inode不变，
# 这样就不会丢日志了
mv /usr/local/nginx/logs/access.log xxx
mv /usr/local/nginx/logs/error.log xxx
# 发送信号新建日志文件
nginx -s  reopen
```

### 日志切割延伸：Linux文件系统

*参考资料:*

[mv操作深入浅出](http:blog.51cto.com/baidutech/743731)
[Linux文件系统剖析](https://www.ibm.com/developerworks/cn/linux/l-linux-filesystem/)

Linux挂载一个新的磁盘文件的步骤:

1. 创建一个虚拟文件
2. 将其与一个循环设备关联，让它看起来像有一个块设备
3. 用循环设备创建文件系统
4. 创建挂载点 （目录），通过循环设备挂载

高层次结构

![filesystem](filesysteem.gif)

supreblock： 文件系统结构，文件内容

inode：文件相关属性，元数据

dentry：文件名（实现了文件名到indoe的映射）

f

mv 移动文件的时候，先新建目录项（dentry），将新文件对应到inode，然后再解除旧的链接。

mv只改变dentry，不改变文件的inode和内容。



