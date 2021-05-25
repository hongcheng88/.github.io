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
      
  > **注意：python中的\*\*args和\*\*kwargs一定要保持严格的先后顺序，否则会导致解析报错,args为数组，kwargs为字典，统计参数个数均可以直接用len(args/kwargs)**

#### python的二分查找(耗时为log2n)
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
    
  
