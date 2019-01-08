## GlusterFS

###服务结构:
        nginx

service service service

        nas(GlusterFS)

nas作用共享存储
nas盘直接挂载到机器的某个目录下

###存在问题:

GlsuterFS客户端的读写存在延迟，在A机器修改文件后，过一小段时间后B机器才能读取到更改


###原因：

>     为了简化Cache一致性，GlusterFS没有引入客户端写Cache，而采用了客户端只读Cache。GlusterFS采用简单的弱一致性，数据缓存的更新规则是根据设置的失效时间进行重置的。
> 对于缓存的数据，客户端周期性询问服务器，查询文件最后被修改的时间，如果本地缓存的数据早于该时间，则让缓存数据失效，下次读取数据时就去服务器获取最新的数据。
>     GlusterFS客户端读Cache刷新的时间缺省是1秒，可以通过重新设置卷参数Performance.cache-refresh-timeout进行调整。这意味着，如果同时有多个用户在读写一个文件，一个
> 用户更新了数据，另一个用户在Cache刷新周期到来前可能读到非最新的数据，即无法保证数据的强一致性。因此实际应用时需要在性能和数据一致性之间进行折中，如果需要更高的数
> 据一致性，就得调小缓存刷新周期，甚至禁用读缓存；反之，是可以把缓存周期调大一点，以提升读性能。

GlusterFS采用了弱一致性的策略，只实现了一个读缓存，该缓存定时更新。在缓存更新前，无法读到文件的更新。

###解决方法:

这个service的作用是操作文件,所以每个req都有一个path=xxx的参数.
然后前段是nginx，可以直接用根据path参数来作为nginx的一致性hash的key,这样同一文件的读写都会分配到同一台机器上，就避免了GlusterFS的读缓存问题.
假设前端没有nginx，则需要一个proxy来做一致性hash分派req.