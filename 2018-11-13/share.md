## Redis百亿级Key存储方案

link: https://www.cnblogs.com/colorfulkoala/p/5783556.html

主要将的是如何压缩内存使用，几个关键的点：
1. 数据的淘汰
2. 减少由hash表引起的内存膨胀
3. 减少内存碎片
