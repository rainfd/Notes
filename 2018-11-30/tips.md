## 在linux下将windows的^M换行符转为linux的换行符

在windows的默认换行符是\r
在linux的默认换行符是\r\n

如果直接将winsows的脚本放到linux执行，bash会识别不出这种换行符.

解决方法有两个:

1. 使用dos2unix xx.txt
   对应的还有unix2dos


2. 使用vim

```vim
:%s/^M$//g # 去掉行尾的^M。
:%s/^M//g # 去掉所有的^M。
:%s/^M/[ctrl-v]+[enter]/g # 将^M替换成回车。（我是用这个方法调好的）
:%s/^M/\r/g # 将^M替换成回车。
```

3. 使用sed

```bash```
$ sed -e ‘s/^M/\n/g’ myfile.txt
``````
