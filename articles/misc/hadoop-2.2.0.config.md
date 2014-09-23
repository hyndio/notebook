# hadoop-2.2.0.config

## 环境变量

## 配置文件

>Hadoop configuration is driven by two types of important configuration files:

>Read-only default configuration - core-default.xml, hdfs-default.xml, yarn-default.xml and mapred-default.xml.

>Site-specific configuration - conf/core-site.xml, conf/hdfs-site.xml, conf/yarn-site.xml and conf/mapred-site.xml.

>Additionally, you can control the Hadoop scripts found in the bin/ directory of the distribution, by setting site-specific values via the conf/hadoop-env.sh and yarn-env.sh.


### core-site.xml

### hdfs-site.xml

### mapred-site.xml

### yarn-site.xml

## ./start-dfs.sh
NameNode/DataNode
SecondaryNameNode

NameNode
- dfs.name.dir 存储元数据信息
- dfs.name.edits.dir 存储操作日志

## ./start-yarn.sh
ResourceManager/NodeManager

## 机器

master 192.168.56.100 hadoop-master
slave  192.168.56.101 hadoop-slave


Applications http://192.168.56.100:8088/
NameNode http://192.168.56.100:50070/
JobTracker http://192.168.56.100:50030/
Task Tracker http://192.168.56.100:50060
Second NameNode http://192.168.56.100:50090

hadoop-hadoop-namenode-hadoop-master.log
hadoop-hadoop-secondarynamenode-hadoop-master.log
hadoop-hadoop-datanode-hadoop-slave.log

yarn-hadoop-resourcemanager-hadoop-master.log
yarn-hadoop-nodemanager-hadoop-slave.log

## 节点工作情况

ResourceManager 是一个中心的服务，它做的事情是调度、启动每一个 Job 所属的 ApplicationMaster、另外监控 ApplicationMaster 的存在情况。细心的读者会发现：Job 里面所在的 task 的监控、重启等等内容不见了。这就是 AppMst 存在的原因。ResourceManager 负责作业与资源的调度。接收 JobSubmitter 提交的作业，按照作业的上下文 (Context) 信息，以及从 NodeManager 收集来的状态信息，启动调度过程，分配一个 Container 作为 App Mstr

ResourceManager 中有一个模块叫做 ApplicationsMasters( 注意不是 ApplicationMaster)，它是监测 ApplicationMaster 的运行状况，如果出问题，会将其在其他机器上重启。

NodeManager 功能比较专一，就是负责 Container 状态的维护，并向 RM 保持心跳。

ApplicationMaster 负责一个 Job 生命周期内的所有工作，类似老的框架中 JobTracker。但注意每一个 Job（不是每一种）都有一个 ApplicationMaster，它可以运行在 ResourceManager 以外的机器上。

