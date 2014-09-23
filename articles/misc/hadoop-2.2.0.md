# hadoop 2.2.0

-[hadoop杂记-为什么会有Map-reduce v2 (Yarn)](http://www.cnblogs.com/LeftNotEasy/archive/2012/02/18/why-yarn.html)
-[Hadoop MapReduceV2(Yarn) 框架简介](http://www.ibm.com/developerworks/cn/opensource/os-cn-hadoop-yarn/)

-[腾讯大规模Hadoop集群实践](http://www.csdn.net/article/2014-02-19/2818473-Tencent-Hadoop)

-[如何使用vagrant在虚拟机安装hadoop集群](http://blog.csdn.net/wf1982/article/details/8798870)

-[Vagrant 知识澄清与杂症诊治](http://wushaobo.info/?p=83)

-[windows如何传文件到linux虚拟机 （方法1）](http://jingyan.baidu.com/article/647f01159b86e17f2148a891.html)

安装方法： apt-get install lrzsz

上传文件：rz
下载文件: sz 文件

-[VirtualBox的四种网络连接方式](http://www.cnblogs.com/adforce/p/3363373.html)

-[Debian中配置静态IP](http://blog.csdn.net/shooter556/article/details/919776)

-[Hadoop2.2.0单节点安装及测试](http://my.oschina.net/u/931751/blog/172666)

-[Hadoop2.2.0多节点分布式安装及测试](http://www.ituring.com.cn/article/63927)
-[Ubuntu系统(64位)下安装并配置Hadoop-2.2.0集群](http://blog.csdn.net/canlets/article/details/18716645)

曾经被这个选项配置折磨：
<property>  
	<name>yarn.nodemanager.address</name>  
	<value>0.0.0.0:8034</value>  
	<description>the nodemanagers bind to this port</description>  
</property>  

-[配置SSH免密码登录](http://book.51cto.com/art/201110/298592.htm)

创建hadoop用户。
(1)   sudo addgroup hadoop
(2)   sudo adduser –ingroup hadoop hduser

建立SSH信任关系，登录localhost就不需要密码
$ cd /home/hduser
$ ssh-keygen -t rsa -P ""    #直接回车
$cat .ssh/id_rsa.pub >>.ssh/authorized_keys

注：可通过ssh localhost命令验证。

-[Linux 下安装配置 JDK7 配置环境(debian 7)](http://www.cnblogs.com/xusir/p/3325965.html)

export JAVA_HOME=/usr/lib/jvm/jdk7
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH

source ~/.bashrc

### chown & chmod
chown 修改文件和文件夹的用户和用户组属性

将目录 /tmp/sco 这个目录的所有者和组改为user和组group
chown -R user:group /tmp/sco

## 查看网络连接端口
telnet IP Port
netstat -napt

hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.2.0.jar pi 10 10

## 运行单词计算
$ wget http://www.gutenberg.org/cache/epub/20417/pg20417.txt
$ hadoop fs -mkdir /input
$ hadoop fs -copyFromLocal pg20417.txt /input
$ hadoop fs -ls /input
Found 1 items
-rw-r--r--   1 phenix supergroup     674570 2014-01-06 11:51 /input/pg20417.txt
$ hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.2.0.jar wordcount /input /output
$ hadoop fs -ls /output
-rw-r--r--   1 phenix supergroup          0 2014-01-06 1ww1:53 /output/_SUCCESS
-rw-r--r--   1 phenix supergroup     196192 2014-01-06 11:53 /output/part-r-00000
$ hadoop fs -cat /output/part-r-00000
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.2.0.jar wordcount /input /output

-[namenode format做了些什么](http://blog.csdn.net/jiangheng0535/article/details/12906509)

http://192.168.56.100:50070/dfshealth.jsp

http://192.168.56.100:8088/clusterw


### YARN执行作业遇到Unauthorized request to start container问题

datanode与namenode之间未设置时间同步，所以引起该异常。
解决方案：多个datanode与namenode进行时间同步。

## 设置Debian/Ubuntu/Centos服务器时间为北京时间
http://blog.dighost.me/archives/2481.html

1. 设置服务器时区

rm -rf /etc/localtime
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

2. 安装ntpdate软件包

Debian/Ubuntu：apt-get install -y ntpdate

Centos：yum install -y ntp

3. 同步最新的时间
ntpdate -u pool.ntp.org
date

通过如下命令可以检查当前设置：

$ cat /etc/adjtime

硬件时间可以用 hwclock 命令设置，将硬件时间设置为 localtime：
hwclock -w --localtime

硬件时间设置成 UTC：
hwclock -w --utc

上述命令会自动生成/etc/adjtime，无需单独设置。 

