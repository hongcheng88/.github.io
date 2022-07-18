**python自带进制转化**

  
  s = '1001'
  
  print(int(s,n))  // n进制转十进制
  
  print(bin(s))  // 十进制转二进制
  
  print(hex(s))  // 十进制转十六进制

  print(oct(s))  // 十进制转八进制
  
  
  **自定义十进制转n进制**

```python
import os
import sys


def num_2_transfor(num, hex):
    if num == 0:
        print(0)
    if num < 0:
        a = '-'
    if num > 0:
        a = ''
    s = ''

    while abs(num):
        s, num = str(abs(num) % hex)+s, num//hex
    result = int(a+s)
    print("%s 转化成 %s 进制结果为：%s" % (num, hex, result))


if __name__ == "__main__":
    num = int(sys.argv[1])
    hex = int(sys.argv[2])
    num_2_transfor(num, hex)
```
