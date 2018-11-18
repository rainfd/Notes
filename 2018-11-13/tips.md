## git新建空白分支

link: https://segmentfault.com/a/1190000004931751

```bash
git checkout --orphan name
```
这个命令会新建一个没有父节点的分支，并且保留前一个分支下的所有文件

接下来删除所有文件(or 保留)，再提交就可以获取一个新的空白分支。
要留意的是，如果该分支没有任何文件，`git branch -a`是看不到该分支的