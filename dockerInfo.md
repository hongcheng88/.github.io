## 容器相关知识点

#### 容器间通信方式

>  **IP访问**
>>   
>> 容器创建时通过 --network 指定相应的网络，或者通过 docker network connect 将现有容器加入到指定网络，保证容器在同一个网络段即可直接通过ip进行访问
>  
>  **Docker DNS Server**
> > 
>> 容器启动时用 --name 为容器命名，之后通过docker 自带的dns server，通过访问容器名实现访问
>> 
>  **joined 容器**
>>  
>> 创建容器时并通过 --network=container:xxx 指定jointed 目标容器xxx，即可实现容器间的通信 
