#### redis是一个数据存储系统，大型的跨平台

#### 性能优化

转自：https://www.cnblogs.com/moonandstar08/p/7282108.html

**尽量使用短的key**

> 当然在精简的同时，不要为了key的“见名知意”。对于value有些也可精简，比如性别使用0、1。

**避免使用keys**

> keys *, 这个命令是阻塞的，即操作执行期间，其它任何命令在你的实例中都无法执行。当redis中key数据量小时到无所谓，数据量大就很糟糕了。所以我们应该避免去使用这个命令。可以去使用SCAN,来代替。

**在存到Redis之前先把你的数据压缩下**

> redis为每种数据类型都提供了两种内部编码方式，在不同的情况下redis会自动调整合适的编码方式。

**设置key有效期**

> 我们应该尽可能的利用key有效期。比如一些临时数据（短信校验码），过了有效期Redis就会自动为你清除！

**选择回收策略(maxmemory-policy**

> 当Redis的实例空间被填满了之后，将会尝试回收一部分key。根据你的使用方式，强烈建议使用 volatile-lru（默认） 策略——前提是你对key已经设置了超时。但如果你运行的是一些类似于 cache 的东西，并且没有对 key 设置超时机制，可以考虑使用 allkeys-lru 回收机制，具体讲解查看 。maxmemory-samples 3 是说每次进行淘汰的时候 会随机抽取3个key 从里面淘汰最不经常使用的（默认选项）。

    maxmemory-policy 六种方式 :
    volatile-lru：只对设置了过期时间的key进行LRU（默认值）
    allkeys-lru ： 是从所有key里 删除 不经常使用的key
    volatile-random：随机删除即将过期key
    allkeys-random：随机删除
    volatile-ttl ： 删除即将过期的
    noeviction ： 永不过期，返回错误

**使用bit位级别操作和byte字节级别操作来减少不必要的内存使用**
> bit位级别操作：GETRANGE, SETRANGE, GETBIT and SETBIT

> byte字节级别操作：GETRANGE and SETRANGE

**尽可能地使用hashes哈希存储**

**当业务场景不需要数据持久化时，关闭所有的持久化方式可以获得最佳的性能**

> 数据持久化时需要在持久化和延迟/性能之间做相应的权衡.

**想要一次添加多条数据的时候可以使用管道**

**限制redis的内存大小（64位系统不限制内存，32位系统默认最多使用3GB内存） **

> 数据量不可预估，并且内存也有限的话，尽量限制下redis使用的内存大小，这样可以避免redis使用swap分区或者出现OOM错误。（使用swap分区，性能较低，如果限制了内存，当到达指定内存之后就不能添加数据了，否则会报OOM错误。可以设置maxmemory-policy，内存不足时删除数据）

**SLOWLOG [get/reset/len]**

> slowlog-log-slower-than 它决定要对执行时间大于多少微秒(microsecond，1秒 = 1,000,000 微秒)的命令进行记录。

>slowlog-max-len 它决定 slowlog 最多能保存多少条日志，当发现redis性能下降的时候可以查看下是哪些命令导致的。

#### 具体优化策略

1.**修改tcp最大监听容纳数量**

> echo 511 > /proc/sys/net/core/somaxconn

2.**修改linux内核内存分配策略**

> 0， 表示内核将检查是否有足够的可用内存供应用进程使用；如果有足够的可用内存，内存申请允许；否则，内存申请失败，并把错误返回给应用进程。
> 
> 1， 不管需要多少内存，都允许申请。
> 
> 2， 只允许分配物理内存和交换内存的大小(交换内存一般是物理内存的一半)。
> 
 3.**关闭Transparent Huge Pages(THP)**
