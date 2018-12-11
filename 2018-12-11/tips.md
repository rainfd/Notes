# [记一次KUBERNETES/DOCKER网络排障](https://coolshell.cn/articles/18654.html)



## arping

man arping解释

```bash
NAME
	arping - send ARP REQUEST to a neighbour host
DESCRIPTION
	Ping destination on device interface by ARP packets, using source address source.
```

往某个就是发送ARP请求，获取mac地址

```bash
$ arping -D -I eth0 -c 2 xx.xx.xx.xx
$ echo $?
```

`-D`检测IP地址冲突，如果返回0就表示有冲突。

`-I`制定设备

## nsenter

可以进入namespace执行一些命令

`$ nsenter -net=/var/run/docker/netns/dfjsklfkal/ ifconfig -a`

## lsns

列出namespace



## 总结

文中提到在裸机上运行docker，只考虑了性能成本，没有考虑运维成本。

如果出现文中类似的问题，机器的docker基本不可能重启。类似这样的问题都会导致一整台机器上的容器瘫痪。所以在裸机上加上一层虚拟机还是很有必要的。