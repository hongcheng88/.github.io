## python

#### 装饰器
  > 
  > 装饰器，顾名思义用于函数或者类的装饰，在不改变函数本身代码的情况下，对函数的功能进行拓展
  
  > 简单定义装饰器
  
      def printLog(func):
  
          def wrapper(*args, **kwargs):
      
              print("正在执行的函数是:%s"%func.__name__) #打印信息
          
              f = func(*args, **kwargs) #执行函数
          
              return f
          
          return wrapper
  
  > 调用
  
      @printLog
      
      def xxx(xx, xxx):
  
      ...
      
  > **注意：python中的\*\*args和\*\*kwargs一定要保持严格的先后顺序，否则会导致解析报错,args为数组，kwargs为字典，统计参数个数均可以直接用len(args/kwargs)**

#### python的二分查找(耗时为log2 n)
    import os，sys
  
    def binarySearch(my_list,num):
  
        low = 0
      
        hight = len(my_list)-1
      
        i = 1
      
        while low < hight:
      
            mid = (int)(low + hight)//2
          
            print("the %s time,my guess is %s"%(i, my_list[mid]))
          
            if my_list[mid] < num:
          
                low = mid
              
            elif mylist[mid] > num:
          
                hight = mid
              
            else:
          
                print("got it...")
              
            i=i+1
          
        return None
      
      
    def main():
  
        my_list=[1,2,3,5,7,9,14,18,21]
      
        num = 14
      
        binarySearch(my_list,num)
  
  
    if __name__ == "__main__":
  
         main()
    
#### python的插入排序(耗时为n*log2 n)

    #coding=utf-8
    
    import os,sys

    def insert_sort(alist):
    
        # 插入排序（逆序）
        
        #从前往后
        
        for i in range(1, len(alist)):
        
        #从后往前
        
            for j in range(i,0,-1):
            
            # 如果后面的比前面的小
            
                if alist[j] < alist[j-1]:
                
                #就把后面数值往前
                
                    alist[j], alist[j-1] = alist[j-1], alist[j]
                    
                else:
                
                    break
                    
        return alist

    def main():
    
        alist = [2,5,7,4,6,9,1,3,8,7]
        
        insert_sort(alist)
        
        print(insert_sort(alist))

    if __name__ == '__main__':
    
        main()

#### python的全局锁GIL

> GIL是实现Python解析器(CPython)时所引入的一个概念，一般并不能让python使用者直接调用。GIL最直接的体现是一个时间段，只能有一个线程在执行。
>
> GIL的存在导致多线程无法很好的实现多核CPU的并发处理能力。即Python的多线程在多核CPU上，只对于IO密集型计算产生正面效果；而当有至少有一个CPU密集型线程存在，那么多线程效率会由于GIL而大幅下降。
> 
> 解决方法，一是用multiprocessing替代Thread，一定程度能解决问题；二是换解析器，如JPython和IronPython
>> 多线程实现一： 
>> ```python
    from mutilprocessing import pool 
    ps = Pool(24)
    ps.apply_async(func, args=(xxx,xxx,...))
    ps.close()
    ps.join()
    ```

>> 多线程实现二：
>> ```python
    from mutilprocessing import Process 
    ps = Process(target=func, args=(xxx,xxx,...))
    ps.start()
    ps.close()
```
  
#### python的is 和 == 的区别

> 在 Python 中一切都是对象，毫无例外整数也是对象，对象之间比较是否相等可以用==，也可以用is。
> 
| 符号 | 定义
| ---  | ---
Is  |  比较的是两个对象的id值是否相等，也就是比较俩对象是否为同一个实例对象，是否指向同一个内存地址。
==  |  比较的是两个对象的内容是否相等，默认会调用对象的__eq__()方法。

#### python的变量创建与消亡过程

> 如name="hongson" 先开辟一个内存空间，把hongson存入，然后将name的指针指向此存储地址；若是重新定义name="hongsonmore"，则是开辟另外一个内存空间将hongsonmore存入，之后断开name此前的指向链接，将指针指向最新的hongsonmore的存储地址。
>
> python自身的回收机制会将长期没有指针引用的内存空间释放，或者手动将变量置None，也会将此前开辟的空间释放。

#### python的垃圾回收机制

> **引用计数**
> 每个引用对象维护一个ob_ref，来记录对象被引用的数量
>> 
>> 数量+1：
>> 
    对象被创建  a=14
    对象被引用  b=a
    对象被作为参数,传到函数中   func(a)
    对象作为一个元素，存储在容器中   List={a,”a”,”b”,2}
    
>> 数量-1：
>> 
    当该对象的别名被显式销毁时  del a
    当该对象的引别名被赋予新的对象，   a=26
    一个对象离开它的作用域，例如 func函数执行完毕时，函数里面的局部变量的引用计数器就会减一（但是全局变量不会）
    将该元素从容器中删除时，或者容器被销毁时。
    
>> *优点*
>> 
    高效
    运行期没有停顿 可以类比一下Ruby的垃圾回收机制，也就是 实时性：一旦没有引用，内存就直接释放了。不用像其他机制等到特定时机。实时性还带来一个好处：处理回收内存的时间分摊到了平时。
    对象有确定的生命周期
    易于实现
    
>> *缺点*
>> 
    维护引用计数消耗资源，维护引用计数的次数和引用赋值成正比，而不像mark and sweep等基本与回收的内存数量有关。
    无法解决循环引用的问题。A和B相互引用而再没有外部引用A与B中的任何一个，它们的引用计数都为1，但显然应该被回收。
    
> **标记-清除**
>> 
    是一种基于追踪回收（tracing GC）技术实现的垃圾回收算法。它分为两个阶段：第一阶段是标记阶段，GC会把所有的『活动对象』打上标记，第二阶段是把那些没有标记的对象『非活动对象』进行回收。那么GC又是如何判断哪些是活动对象哪些是非活动对象的呢？
    对象之间通过引用（指针）连在一起，构成一个有向图，对象构成这个有向图的节点，而引用关系构成这个有向图的边。从根对象（root object）出发，沿着有向边遍历对象，可达的（reachable）对象标记为活动对象，不可达的对象就是要被清除的非活动对象。根对象就是全局变量、调用栈、寄存器。
>> ![image](https://user-images.githubusercontent.com/84756119/119758045-716b4180-bed8-11eb-842b-abc11f589f9e.png)
>> 
    在上图中，我们把小黑圈视为全局变量，也就是把它作为root object，从小黑圈出发，对象1可直达，那么它将被标记，对象2、3可间接到达也会被标记，而4和5不可达，那么1、2、3就是活动对象，4和5是非活动对象会被GC回收。

> **分代回收**
>>
    分代回收是一种以空间换时间的操作方式，Python将内存根据对象的存活时间划分为不同的集合，每个集合称为一个代，Python将内存分为了3“代”，分别为年轻代（第0代）、中年代（第1代）、老年代（第2代），他们对应的是3个链表，它们的垃圾收集频率与对象的存活时间的增大而减小。新创建的对象都会分配在年轻代，年轻代链表的总数达到上限时，Python垃圾收集机制就会被触发，把那些可以被回收的对象回收掉，而那些不会回收的对象就会被移到中年代去，依此类推，老年代中的对象是存活时间最久的对象，甚至是存活于整个系统的生命周期内。同时，分代回收是建立在标记清除技术基础之上。分代回收同样作为Python的辅助垃圾收集技术处理那些容器对象.
    
#### 可变数据类型和不可变数据类型

> **不可变数据类型更改后地址发生改变，可变数据类型更改地址不发生改变**
> 
> 不可变类型：数字类型、字符串类型和元组类型

> 可变类型：列表类型、字典类型和集合类型

#### python2 与python3的区别

python2 | python3
--- | --- 
用的asscii编码 | 用的UTF-8编码
print是命令, print "xxx" | print是函数 print("xxx")
未明确区分字串类型unicode 和 str | 严格区分unicode和str，字节是字节，字串是字串
true/false为变量，可赋值改变 | true/false为关键字，不再可变
迭代器的差别 |
嵌套函数中的全局变量无法实现 | 新增关键字 nonlcoal，使得非局部变量成为可能
/结果为整型，如 1/2结果为0 | /结果为浮点型，1/2结果为0.5

#### lambda表达式
> 定义一个匿名函数，函数中不能包含命令，且只能有一个表达式
> 如，h=lambda x:x+1 , h(1)输出2。即x作为表达式的参数入口，x+1为函数主题
> 如下为几个定义好的全局函数，filter, map, reduce
    >>>foo = [2, 18, 9, 22, 17, 24, 8, 12, 27]
    >>>
    >>>print filter(lambda x: x % 3 == 0, foo)
    [18, 9, 24, 12, 27]
    >>>print map(lambda x: x * 2 + 10, foo)
    [14, 46, 28, 54, 44, 58, 26, 34, 64]
    >>> print reduce(lambda x, y: x + y, foo)
    139

#### 三目运算符(python3中)
> 
> expr1 if condition else expr2
> 
> 如 print("a is 3"）if a==3 else print("a is not 3")
> 
> java中用?: , a==b?c:d，如a==b则输出c，否则输出d

#### try exception else和finally
> 如下
> 
    try:
        normal condition
    except:
        abnormal condition 
    else:
        if normal condition
    finally:
        Do it anyway

#### 解析xml文件

> **1.SAX标准库解析**
> 
>> SAX 用事件驱动模型，通过在解析XML的过程中触发一个个的事件并调用用户定义的回调函数来处理XML文件。 

> **2.DOM （Document Object Model）解析**
> 
>> 将 XML 数据在内存中解析成一个树，通过对树的操作来操作XML
> 
> **ElementTree 解析**
> 
>> ElementTree就像一个轻量级的DOM，具有方便友好的API。代码可用性好，速度快，消耗内存少。
> 
> 另：因DOM需要将XML数据映射到内存中的树，一是比较慢，二是比较耗内存，而SAX流式读取XML文件，比较快，占用内存少，但需要用户实现回调函数（handler）
