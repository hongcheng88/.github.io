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
    
#### python的二分排序(耗时为n*log2 n)

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
        
        # for li in alist[6::-1]:
        
        #     print(li)

    if __name__ == '__main__':
    
        main()
  
  
