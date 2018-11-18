## redis内存优化

link: 
​      - https://my.oschina.net/nalenwind/blog/897744
​      - https://www.cnblogs.com/colorfulkoala/p/5783556.html

之前的redis内存优化的那篇文章没有细看，一直误认为是使用hashmap的方式比k/v的方式要省内存。

在打算实际测试之前，重温了这两篇相关的文章。发现hashmap的使用上，还要加上一个桶的概念,将原来设备id/value的方式转为压缩的id/value: 即文章提到的

```
get(key1) -> hget(md5(key1), key1)
```

e.q.
设备id是abcdefgbkbknklbk， md5值是123456, value是1
设备id是zxcvbnkjbnknkjbb， md5值也是123456， vlaue是2
这样id作为field，就将多个id挂到同一个key下，这时候再将设备id进行压缩，用更少的字节存储
原：
​    k/v abcdefgbkbknklbk/1
​        zxcvbnkjbnknkjbb/2
​    key/field/value 123456/abc/1
​                    123456/zxc/2
​                
这样就很直观地看到在存储字节上的减少。
在实际实现时需要考虑的问题还有很多，例如：应该尽量平均分配key，否则会导致内存碎片的问题等等

## YAML作为一种配置文件，并没有想象中的那么好

link: https://arp242.net/weblog/yaml_probably_not_so_great_after_all.html

### Insecure by default
yaml.load() vs yaml.safe_load()，github直接使用load的数量远大于safe_load

### Can be hard to edit, especially for large files
由于配置的层级划分是通过缩进，假设配置文件很大，层级非常多，这个yaml配置就很难编辑和看下去了

### It’s pretty complex
yaml的标准描述文件有23449个英文单词，而json只有1969个单词。很明显，我们都没有对yaml了如指掌，即使是读过了yaml的这份标准，也很难记清它的每一个细节

### Surprising behaviour
例如数字有的实现识别为字符串，Yes识别为True

### It’s not portable
有时候的yaml太复杂，某些实现都识别不了

### Conclusion
文章的最后推荐了TOML，个人认为和mysql的配置有点类似，可读性比yaml还要强。
假设必须使用yaml，文中还推荐使用ScriptYaml。



