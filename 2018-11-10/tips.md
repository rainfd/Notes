## 在一台机器上管理多个git账号

因为需要在自己的机器上同时使用公司的gitlab账号和自己的github账号，所以就需要一种方法来管理。

Step:
1.  ssh-keygen -t rsa -b 4096 -C "your@email.com"
    rename your public key like: ib_rsa_work
2.  eval "(ssh-agent -s)" # start the ssh-agent in the background
3.  edit your git config
4.  ssh-add ~/.ssh/ib_rsa_work

```
Host git.server
	Hostname git.server
	User liangjialin
	Identityfile ~/.ssh/id_rsa_work

Host git@github.com
	Hostname github.com
	User rainfd
	Identityfile ~/.ssh/id_rsa
```
