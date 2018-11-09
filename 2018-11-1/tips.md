## crontab %的坑

crontab文档:

> The “sixth” field (the rest of the line) specifies the command to be run. The entire command portion of the line, up to a newline or % character, will be executed by /bin/sh or by the shell specified in the SHELL variable of the cronfile. Percent-signs (%) in the command, unless escaped with backslash (), will be changed into newline characters, and all data after the first % will be sent to the command as standard input.

简单来说就是百分号会被转义成换行要使用百分号就要提前转义：

```
* * * * * y=`date "+\%Y\%m\%d"`; x.sh > y.log
```