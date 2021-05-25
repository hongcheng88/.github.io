## python

#### 装饰器
  > 
  > 装饰器，顾名思义用于函数或者类的装饰，在不改变函数本身代码的情况下，对函数的功能进行拓展
  
  > 简单定义装饰器
  
      def printLog(func):
  
          def wrapper(**args, **kwargs):
      
              print("正在执行的函数是:%s"%func.__name__) #打印信息
          
              f = func(**args, **kwargs) #执行函数
          
              return f
          
          return wrapper
  
  > 调用
  
      @printLog
      
      def xxx(xx, xxx):
  
      ...
      
  > **注意：python中的\*\*args和\*\*kwargs一定要保持严格的先后顺序，否则会导致解析报错,args为数组，kwargs为字典，统计个数均可以直接用len(args/kwargs)**


  
