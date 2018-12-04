## mongo shell 连接集群

如果mongo shell的版本低于v3.4.10，mongo shell无法通过
```
mongo "user:password@host:port,host2:port2/db?replicaSet=daprps0"
```
来连接到集群。
