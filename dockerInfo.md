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
> docker  **export** 1e560eoca3906 > testenv.tar，可以将容器导出快照到本地
> 
> cat docker/testenv.tar | docker **import** - test/testenv:v1，可以将快照文件 testenv.tar 导入到镜像 test/testenv:v1
> 
> docker **rm** 容器id，可以删除容器
> 
> docker **system prune**，可以清理当前无效的docker容器及镜像
> 
> docker images，列出当前所有的镜像
> 
> docker **commit** -m="update images" -a="hongson" e98gfrb10161 test/testenv:v2，将容器e98g推到仓库test/testenv，tag名为v2
> 
> docker build -t test/testnew:1.1 Dockerfile，将dockerfile打成镜像
> 
> docker tag 8664fdrd2fec test/testenv:dev，用8664的镜像打标签dev
> 
> docker run -d **-P** test/webapp python3 hello.py，容器运行flask应用，随机映射容器端口到主机端口
> 
> docker run -d **-p 5000:5000** test/webapp python3 hello.py，容器运行flask应用，固定映射容器5000端口到主机5000端口
> 
> docker run -d **-p 127.0.0.1:5000:5000** test/webapp python3 hello.py，容器运行flask应用，指定容器绑定的网络地址127.0.0.1，固定映射容器5000端口到主机5000端口
> 
> 以上默认绑定tcp端口，如需绑定udp，则可以用-p port1:port2/udp

#### Dockerfile

> Dockerfile 的指令每执行一次都会在 docker 上新建一层。所以过多无意义的层，会造成镜像膨胀过大。所以常用&&连接，保证创建尽量少的层数

> **指令**
>> FROM，基准镜像
>> 
>> RUN，执行shell指令（docker build的时候执行）
>> 
>> COPY，复制宿主机的文件或目录到容器指定目录
>> 
>> ADD，类似copy，只不过常用来拷贝压缩文件，此指令会拷贝并解压缩
>> 
>> CMD,类似RUN（docker run的时候执行），此外一个dockerfile中只有最后一个CMD会生效
>> 
>> ENV，设置环境变量，定义了环境变量，那么在后续dockerfile这种的指令，就可以使用这个环境变量。
>> 
>> ARG，构建参数，与 ENV 作用一至。不过作用域不一样。ARG 设置的环境变量仅对 Dockerfile 内有效，也就是说只有 docker build 的过程中有效，构建好的镜像内不存在此环境变量。
>> 
>> WORKDIR，指定工作目录。用 WORKDIR 指定的工作目录，会在构建镜像的每一层中都存在。（WORKDIR 指定的工作目录，必须是提前创建好的）。docker build 构建镜像过程中的，每一个 RUN 命令都是新建的一层。只有通过 WORKDIR 创建的目录才会一直存在。
>> 
>> USER，用于指定执行后续命令的用户和用户组，这边只是切换后续命令执行的用户（用户和用户组必须提前已经存在）。
