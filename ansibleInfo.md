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
  
  >>> 拷贝文件到目标机器 ansible web -m copy -a "src=nihao.txt dest=/wort/mnt/nihao.txt owner=root group=root mode=644"

  >>> 拷贝apache配置文件到目标机器，并备份目标文件 ansible web -m copy -a "src=nihao.txt dest=/wort/mnt/nihao.txt owner=root group=root mode=644 backup=yes"

  >>> 在远程主机创建一个文件并写入内容  ansible web -m copy -a "content='this is my ansible copy test' dest=/work/nihao.txt"
  >>> 
  >> get_url 命令

  参数 |	含义
  url	| 地址
  dest	| 目标文件
  mode	| 文件权限
  
  >>> 下载文件到本地  ansible web -m get_url -a "url=http://xx.xx.xx/ssss.txt dest=/work/xx.sh mode=755"
  
  >> file 命令
  >> 
  >>> 创建文件 ansible web -m file -a "path=/home/aaa.txt state=touch"
  >>> 
  >>> 创建目录 ansible web -m file -a "path=/home/test state=directory"
  >>> 
  >>> 递归修改目录权限 ansible web -m file -a "path=/home owner=nginx group=nginx mode=766 r

  >> 查看模块文档帮助 **ansible-doc 模块名**
  >> 
  >>> 例如查看git的文档 可直接使用 ansible-doc git

  > **playbook** 
  >> 
  >> Playbook与ad-hoc相比,是一种完全不同的运用ansible的方式，类似与saltstack的state状态文件。ad-hoc无法持久使用，playbook可以持久使用。playbook是由一个或多个play组成的列表， play的主要功能在于将事先归并为一组的主机装扮成事先通过ansible中的task定义好的角色。从根本上来讲，所谓的task无非是调用ansible的一个module。将多个play组织在一个playbook中，即可以让它们联合起来按事先编排的机制完成某一任务。是用yaml语法进行编排的。
  >> 
  >> 如下为一个简单的yaml
  >> 
    - hosts: web
    tasks:
        - name: install httpd server
        yum: name=httpd state=present
 
        - name: configure httpd server
        copy: src=httpd.conf dest=/etc/httpd/conf/httpd.conf

        - name: configure httpd server
        copy: src=index.html dest=/var/www/html/index.html

        - name: service httpd server
        service: name=httpd state=started enabled=yes
>>> hosts：需要执行的主机、组、IP
>>> 
>>> tasks：执行的任务
>>> 
>>> name：任务描述
>>> 
>>> yum/copy/service：执行模块

#### Task任务控制

> **关键字**
>> 
>> 条件判断 when; 循环语句 with_items; 触发器 handlers; 标签 tags; 包含 include; 忽略错误 ignore_error; 错误处理 change
>> 
> **条件判断 when**
>> 
>> 假设我们安装Apache，在centos上安装的是httpd，在Ubuntu上安装的是httpd2，因此我们需要判断主机信息，安装不同的软件。
>>> 
    - hosts: web
      tasks:
        - name: Install CentOS Httpd
          yum: name=httpd state=present
          when: ( ansible_distribution == "CentOS" )

        - name: Install Ubuntu Httpd
          yum: name=httpd2 state=present
          when: ( ansible_distribution == "Ubuntu" )
>>给task加上when条件，在执行的时候，就会先判断条件是否满足，如果满足则执行任务，不满足就不执行此任务。我们再看一个例子：如果Apache服务不正常就重启，否则跳过。
>>>
    - hosts: web
      tasks:
        - name: check httpd server
          command: systemctl is-active httpd
          register: check_httpd

        - name: httpd restart
          service: name=httpd state=restarted
          when: check_httpd.rc == 0
> **循环命令 with_items**
>> 
>> 如果需要启动多个服务，例如nginx、httpd
>>> 
    - hosts: web
      tasks:
        - name: Service Start
          service: name={{item}} state=restarted
          with_items:
            - nginx
            - httpd
>> 拷贝多个配置文件
>>> 
    - hosts: web
      tasks:
        - name: Copy Configure File
          copy:
            src: {{item.src}}
            dest: {{item.dest}}
            mode: {{item.mode}}
          with_items:
            - { src: './nginx.conf', dest: '/etc/nginx/conf/nginx.conf' }
            - { src: './httpd.conf', dest: '/etc/httpd/conf/httpd.conf' }
> **触发器 handlers**
>> 
>> 当某个任务发生变化时，触发另一个任务的执行，例如如果httpd的配置文件发生了变化，就执行重启任务
>>> 
    - hosts: web
      tasks:
        - name: install httpd server
          yum: name=httpd state=present

        - name: configure httpd server
          copy: src=httpd.conf dest=/etc/httpd/conf/httpd.conf
          notify: # 条用名称为Restart Httpd Server的handlers，可以写多个
            - Restart Httpd Server

        - name: service httpd server
          service: name=httpd state=started enabled=yes

      handlers:
        - name: Restart Httpd Server
          service: name=httpd state=restarted
>>> handlers执行的时候需要注意，虽然是在某个任务被触发的，但是它必须等到所有的task执行完成后，才会执行handlers里面被触发过的命令，如果在执行前，有另一个task执行失败了，那么被触发的handlers也不会执行。

> **tags标签**
>> 
>> 对任务指定标签后，我们在使用ansible-playbook执行的时候就可以指定标签来执行任务，不需要执行所有的任务，标签的设置有三种情况：1. 一个任务设置一个标签 2.一个任务设置多个标签 3. 多个任务设置一个标签
>>>  
    - hosts: web
      tasks:
        - name: install httpd server
          yum: name=httpd state=present
          tags: install

        - name: configure httpd server
          copy: src=httpd.conf dest=/etc/httpd/conf/httpd.conf
          notify: # 条用名称为Restart Httpd Server的handlers，可以写多个
            - Restart Httpd Server
          tags: configure

        - name: service httpd server
          service: name=httpd state=started enabled=yes
          tags: start
      handlers:
        - name: Restart Httpd Server
          service: name=httpd state=restarted
>>> 执行指定tags的命令：ansible-playbook httpd.yml -t "configure"
>>> 
>>> 跳过指定tags的命令：ansible-playbook httpd.yml --skip-tags "install"

> **include包含**
>> 
>>我们可以把任务单独写在一个yaml文件中，然后在其他需要用到的任务中通过include_tasks: xxx.yml引入，举例如下：
>>>
    # a.yml
    - name: restart httpd service
      service: name=httpd state=restarted
    # b.yml
    - hosts: web
      tasks:
        - name: configure httpd server
          copy: src=httpd.conf dest=/etc/httpd/conf/httpd.conf

        - name: restat httpd
          include_tasks: ./a.yml
>> 当然我们也可以把两个完整的playbook合并起来
>>> 
    # a.yml
    - hosts: web
      tasks:
        - name: install httpd server
          yum: name=httpd state=present
    # b.yml
    - hosts: web
      tasks:
        - name: configure httpd server
          copy: src=httpd.conf dest=/etc/httpd/conf/httpd.conf
    # total.yml
    - import_playbook: ./a.yml
    - import_playbook: ./b.yml
>> 在执行total.yml的时候，实际上就是先执行a.yml，然后再执行b.yml，里面的内容实际并不是真正的合并

> **忽略错误ignore_errors**
>>我们知道，在执行playbook的时候，如果其中某个任务失败了，它下面的任务就不会再执行了，但是有时候我们并不需要所有任务都成功，某些任务是可以失败的，那么这个时候就需要进行容错，就是在这个任务失败的时候，不影响它后面的任务执行。
>>>
    - hosts: web
      tasks:
        - name: check httpd status
          command: ps aux|grep httpd
          register: httpd_status
          ignore_errors: yes  # 如果查询语句执行失败，继续向下执行重启任务

        - name: restart httpd
          service: name=httpd state=restarted
>> 错误处理force_handlers: yes 强制调用handlers,只要handlers被触发过，无论是否有任务失败，均调用handlers
>>>
    - hosts: web
      force_handlers: yes
      tasks:
        - name: install httpd
          yum: name=httpd state=present

        - name: install fuck
          yum: name=fuck state=present

      handlers:
        - name: restart httpd
          service: name=httpd state=restarted
>>> change_when当任务执行的时候，如果被控主机端发生了变化，change就会变化，但是某些命令，比如一些shell命令，只是查询信息，并没有做什么修改，但是一直会显示change状态，这个时候我们就可以强制把change状态关掉。
>>>> 
    - hosts: web
      tasks:
        - name: test task
          shell: ps aux
          change_when: false
>> 再看一个例子，加入我们修改配置文件成功了，就执行重启命令，否则不执行重启
>>> 
    - hosts: web
      tasks:
        - name: install nginx server
          yum: name=nginx state=present

        - name: configure nginx
          copy: src=./nginx.conf dest=/etc/nginx/conf/nginx.conf

        # 执行nginx检查配置文件命令
        - name: check nginx configure
          command: /usr/sbin/nginx -t
          register: check_nginx
          changed_when: ( check_nginx.stdout.find('successful') )

        - name: service nginx server
          service: name=nginx state=restarted
