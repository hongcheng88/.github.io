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

#### docker容器与虚拟机的区别

> 传统虚拟化方式需要有额外的虚拟机管理程序和虚拟机操作系统 。而Docker 容器是直接在宿主机操作系统层面上实现虚拟化，所以属于轻量级虚拟化方案。
 
| 特性	| Docker 容器	|传统虚拟机
|  -   | -           | -
| 启动速度	| 秒级 |	分钟级
| 性能 |	接近原生 |	较差
| 消耗内存 |	很小	| 较多
| 硬盘容量 |	MB 级	| GB 级
| 单机运行密度	| 上千个容器	| 几十个容器
| 隔离性	| 安全隔离	| 完全隔离
| 迁移性 | 	好	| 一般

#### 常用指令

> docker pull xxx，载入远程镜像到本地
> 
> docker run myubuntu /bin/bash启动镜像为myubuntu的容器，执行指令为/bin/bash
> 
> 可以增加 **-ti**，交互式操作终端，i(交互式操作stdin)，t（terminal终端）。即当前直接进入容器中，可以接受输入输出
> 
> 可以增加 **-d**，让容器在后台运行
> 
> 需要进入后台运行的容器，使用**exec或者attach**。前者为推荐使用，进入退出不影响容器运行，后者退出会导致容器的stop。推荐同步搭配 -ti（docker exec -ti 容器id /bin/bash）
> 
> docker ps 查看当前容器运行情况（包含容器id，对应镜像，启动时执行的命令，创建时间，状态，端口信息，启动时的名字）
> 
> docker stop/start 容器id可以停止启动容器
> 
> docker  **export** 1e560fca3906 > ubuntu.tar，可以将容器导出快照到本地
> 
> cat docker/ubuntu.tar | docker **import** - test/ubuntu:v1，可以将快照文件 ubuntu.tar 导入到镜像 test/ubuntu:v1
> 
> docker **rm** 容器id，可以删除容器
> 
> docker **system prune**，可以清理当前无效的docker容器及镜像
> 
> docker images，列出当前所有的镜像
> 
> docker **commit** -m="has update" -a="runoob" e218edb10161 runoob/ubuntu:v2，将容器e218e推到仓库runoob/ubuntu，tag名为v2
> 
> docker build -t runoob/centos:6.7 Dockerfile，将dockerfile打成镜像
> 
> docker tag 860c279d2fec runoob/centos:dev，用860c的镜像打标签dev

