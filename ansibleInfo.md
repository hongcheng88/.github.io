## Ansible
## 转载自https://www.imooc.com/article/309728
#### 安装（apt-get or pipe）

    apt-get install software-properties-common
    
    apt-add-repository ppa:ansible/ansible
    
    apt-get update
    
    apt-get install ansible
    
    or
    
    pip install ansible
    
#### ansile的配置文件有ansible.cfg，host，roles（默认为空）

> host是主机配置清单，用来配置我们需要管理的主机的相关信息。主要包括IP、用户、密码，SSH key配置

>> 配置方式一
>> 
    [web]
    
    192.168.133.111 ansible_ssh_user=root ansible_ssh_pass=123456
    
    192.168.133.112 ansible_ssh_user=root ansible_ssh_pass=123456
    
    192.168.133.123 ansible_ssh_user=root ansible_ssh_pass=123456 
    
>> 方式二
    [web]
    
    192.168.133.111
    
    192.168.133.112
 
    194.168.133.123
  
    [web:vars]
    
    ansible_ssh_user=root
    
    ansible_ssh_pass=123456
  
>> 方式三
    [web]
    192.168.133.111

    192.168.133.112

    192.168.133.123
  
    然后在/etc/ansible目录下创建目录group_vars，然后再创建文件web.yml，以组名命名的yml文件，配置对应信息

    ansible_ssh_user: root
    
    ansible_ssh_pass: 123456

> ansible.cfg是ansible的配置文件，在多个路径下都存在，按以下顺序读取：

>> ANSIBLE_CONFIG：环境变量
>> 
>> ansible.cfg：当前执行目录下
>> 
>> .ansible.cfg：~/.ansible.cfg
>> 
>> /etc/ansible/ansible.cfg

#### 常用指令

  > **ad-hoc**类似于shell的指令，单条执行
  > 
  >> ansible web -m command -a 'df -h' 。直接在主机上展示我们管理的机器的挂载信息
  >> 
  >>> ansible：命令
  >>> 
  >>> web：主机名/IP/分组
  >>> 
  >>> -m：指定模块（默认是command，所以可以把-m command这个去掉）
  >>> 
  >>> command：模块名称
  >>> 
  >>> -a：模块参数
  >>> 
  >>> ‘df -h’：参数值
  >>> 
  >>> **执行命令返回的结果颜色代表的含义**
  >>> 
  >>>> 绿色：被管理端没有被修改
  >>>> 
  >>>> 黄色：被管理端发生变更
  >>>> 
  >>>> 红色：执行出现故障

  > **常用模块**

  模块名 | 说明
  --- | :--:
  command（默认）| 不支持管道过滤grep |
  shell | 支持管道过滤grep |
  script | 不用把脚本复制到远程主机就可以在远程主机执行脚本 
  yum | 安装软件 y
  yum_repository | 配置yum源 
  copy | 拷贝文件到远程主机 
  file | 在远程主机创建目录或者文件 
  service | 启动或停止服务 
  mount | 挂载设备  
  cron | 执行定时任务 
  firewalld | 防火墙设置 
  get_url |下载软件或访问网页  
  git | 执行git命令
  
  >> copy命令
  
  参数 | 选项 | 含义
  --- | --- | ---
  src | |源目录或文件 
  dest | |  目标目录或文件
  remote_src | True、False | src是远程主机上还是在当前主机上，仅在mode=preserve有效 
  owner | |  所属用户 
  group | |  所属组 
  mode |0655、u=rw、u+rw | 设置文件权限 
  backup | yes、no | 是否备份目标文件 
  content | | 写入目标文件的内容
  
  >>> # 拷贝文件到目标机器 ansible web -m copy -a "src=nihao.txt dest=/wort/mnt/nihao.txt owner=root group=root mode=644"

  >>> # 拷贝apache配置文件到目标机器，并备份目标文件 ansible web -m copy -a "src=nihao.txt dest=/wort/mnt/nihao.txt owner=root group=root mode=644 backup=yes"

  >>> # 在远程主机创建一个文件并写入内容  ansible web -m copy -a "content='this is my ansible copy test' dest=/work/nihao.txt"
  >>> 
  >> get_url 命令

  参数 |	含义
  url	| 地址
  dest	| 目标文件
  mode	| 文件权限
  
  >>> # 下载文件到本地  ansible web -m get_url -a "url=http://xx.xx.xx/ssss.txt dest=/work/xx.sh mode=755"
