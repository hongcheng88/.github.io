## linux more

#### 字串处理

  > str=nihaobuhaoa
  > 
  > %从右往左截取输出第一个指定字符之前的字段    ${str%a*}  输出 nihaobuhao ;
  > 
  > %%从右往左截取输出最后一个指定字符之前的字段    ${str%%a*}  输出 nih ；
  > 
  > #从左往右截取输出第一个指定字符之后的字段    ${str#*a}  输出 aobuhaoa ；
  > 
  > ##从左往右截取输出最后指定字符之后的字段    ${str##*a}  输出 aoa
  >  
  > echo $str|cut -c 2-5  截取输出字串的第二位到第五位 输出 ihao
  > 
  > echo $str|tr -d 'a' 删除字串中的a字符 输出nihobuho ; echo $str|tr 'a' 'b' 字串b替代字串a，输出nihbohuhbob
  
#### 文件处理
  > 查找并统计文件行数 find . -name "*.java"|xargs cat |wc -l
  
  > 逐行对比找出两个文件不同内容 awk '{print NR, $0}' file1 file2 |sort -k2|uniq -u -f 1|sort -k1|awk '{print $2}'或者：awk '{print $0}' file1 file2 |sort|uniq -

  > sed查找替换文件内容
  >> sed -i "2s/hongson/hongsonmore/" nihao.txt 修改文件中第二行的hongson 为hongsonmore
  >> 
  >> sed -i "2,5s/hongson/hongsonmore/" nihao.txt 修改文件中第二到第五行所有匹配到的hongson 为hongsonmore
  >> 
  >> sed -i "2,/^myname/s/hongson/hongsonmore/" nihao.txt 修改文件第二行开始到所有以myname开头的行中，匹配到的hongson变为hongsonmore
  >> 
  >> sed -i "s/[0-9]*//g" nihao.txt  删除文件中的数字字符

#### 挂载处理
  > smb 挂载 mount -t cifs -o username=xxx,password=xxx //xxx/ /mnt/xxx
  > 
  > nfs 挂载 mount -t nfs nolock,rw xxxx.com:/ifs/data/xxxx  /mnt/xxxx

#### top命令展示
  > ![image](https://user-images.githubusercontent.com/84756119/119453451-069bf800-bd6a-11eb-8dee-d5f7c98d03dd.png)
  >> 17:29:09  表示当前时间 
  >> 
  >> up 53days 系统运行时间 格式为时：分
  >> 
  >> 1 users 当前登录用户数
  >> 
  >> load average: 0.00, 0.01, 0.05  系统负载，即任务队列的平均长度。 三个数值分别为 1分钟、5分钟、15分钟前到现在的平均值。
  >> 
  >> 69 total    进程总数
  >> 
  >> 2 running    正在运行的进程数
  >> 
  >> 158 sleeping    睡眠的进程数
  >> 
  >> 0 stopped    停止的进程数
  >> 
  >> 0 zombie    僵尸进程数
  >> 
  >> **0.0 us    用户空间占用CPU百分比**
  >> 
  >> **0.0 sy    内核空间占用CPU百分比**
  >> 
  >> 0.0 ni    用户进程空间内改变过优先级的进程占用CPU百分比
  >> 
  >> 100.0 id    空闲CPU百分比
  >> 
  >> 0.0 wa    等待输入输出的CPU时间百分比
  >> 
  >> 0.0 hi    硬中断（Hardware IRQ）占用CPU的百分比
  >> 
  >> 0.0 si    软中断（Software Interrupts）占用CPU的百分比
  >> 
  >> 0.0 st    用于有虚拟cpu的情况，用来指示被虚拟机偷掉的cpu时间。
  >> 
  >> **KiB Mem: 1016168 total   物理内存总量**
  >> 
  >> 567720 used   已经使用的物理内存总量
  >> 
  >> 68820 free   空闲内存总量
  >> 
  >> 379628 buffers（buff/cache）  用作内核缓存的内存量
  >> 
  >> **KiB Swap: 0 total  交换区总量（可简单理解为磁盘转内存）**
  >> 
  >> 0 used 使用的交换区总量
  >> 
  >> 0 free  空闲交换区总量
  >> 
  >> 0 cached Mem 缓冲的交换区总量。
  >> 
  >> 293196 avail Mem  代表可用于进程下一次分配的物理内存数量
  >> PID 进程id
  >> 
  >> PPID  父进程id
  >> 
  >> RUSER  Real user name
  >> 
  >> UID  进程所有者的用户id
  >> 
  >> USER  进程所有者的用户名
  >> 
  >> GROUP  进程所有者的组名
  >> 
  >> TTY  启动进程的终端名。不是从终端启动的进程则显示为
  >> 
  >> **PR  优先级**
  >> 
  >> **NI  nice值。负值表示高优先级，正值表示低优先级**
  >> 
  >> P  最后使用的CPU，仅在多CPU环境下有意义
  >> 
  >> **%CPU  上次更新到现在的CPU时间占用百分比**
  >> 
  >> TIME  进程使用的CPU时间总计，单位秒
  >> 
  >> TIME+  进程使用的CPU时间总计，单位1/100秒
  >> 
  >> **%MEM  进程使用的物理内存百分比**
  >> 
  >> VIRT  进程使用的虚拟内存总量，单位kb。VIRT=SWAP+RES
  >> 
  >> SWAP  进程使用的虚拟内存中，被换出的大小，单位kb
  >> 
  >> RES  进程使用的、未被换出的物理内存大小，单位kb。RES=CODE+DATA
  >> 
  >> CODE  可执行代码占用的物理内存大小，单位kb
  >> 
  >> DATA  可执行代码以外的部分(数据段+栈)占用的物理内存大小，单位kb
  >> 
  >> SHR  共享内存大小，单位kb
  >> 
  >> nFLT  页面错误次数
  >> 
  >> nDRT  最后一次写入到现在，被修改过的页面数。
  >> 
  >> **S  进程状态。D=不可中断的睡眠状态 R=运行 S=睡眠 T=跟踪/停止 Z=僵尸进程**
  >> 
  >> COMMAND  命令名/命令行
  >> 
  >> WCHAN  若该进程在睡眠，则显示睡眠中的系统函数名
  >> 
  >> Flags  任务标志

#### 进程与线程的关系和区别
  > 进程，是计算机中的程序关于某数据集合上的一次运行活动，是系统进行资源分配和调度的基本单位，是操作系统结构的基础。它的执行需要系统分配资源创建实体之后，才能进行。
  > 
  > 在Linux内核2.4版以前，线程的实现和管理方式就是完全按照进程方式实现的。在2.6版内核以后才有了单独的线程实现
  > 
  > 进程是资源分配的基本单位，线程是调度的基本单位。
  > 
  > **进程的实现是调用fork系统调用：pid_t fork(void);**
  > 
  > **线程的实现是调用clone系统调用** ：
  > 
    int clone(int (*fn)(void *), void *child_stack, int flags, void *arg, ...
  
    /* pid_t *ptid, struct user_desc *tls, pid_t *ctid */
    
    );
  > 
  > 更多信息：https://www.cnblogs.com/fah936861121/articles/8043187.html
