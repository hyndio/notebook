
-[JVM监控命令](http://blog.csdn.net/flyhawk1010/article/details/7803238)

-jps
-jps 192.168.0.77
-jinfo 2083
-jstack 2083
-jmap（linux下特有，也是很常用的一个命令）
观察运行中的jvm物理内存的占用情况。
参数如下：
	-heap：打印jvm heap的情况
	-histo：打印jvm heap的直方图。其输出信息包括类名，对象数量，对象占用大小。
	-histo：live ：同上，但是只答应存活对象的情况
	-permstat：打印permanent generation heap情况

命令使用：
jmap -heap 2083
jmap -histo 2083 ｜ jmap -histo:live 2083
可以观察heap中所有对象的情况（heap中所有生存的对象的情况）。包括对象数量和所占空间大小。

-jstat

这是jdk命令中比较重要，也是相当实用的一个命令，可以观察到classloader，compiler，gc相关信息
具体参数如下：
-class：统计class loader行为信息
-compile：统计编译行为信息
-gc：统计jdk gc时heap信息
-gccapacity：统计不同的generations（不知道怎么翻译好，包括新生区，老年区，permanent区）相应的heap容量情况
-gccause：统计gc的情况，（同-gcutil）和引起gc的事件
-gcnew：统计gc时，新生代的情况
-gcnewcapacity：统计gc时，新生代heap容量
-gcold：统计gc时，老年区的情况
-gcoldcapacity：统计gc时，老年区heap容量
-gcpermcapacity：统计gc时，permanent区heap容量
-gcutil：统计gc时，heap情况
-printcompilation：不知道干什么的，一直没用过。

一般比较常用的几个参数是：
jstat -class 2083 1000 10 （每隔1秒监控一次，一共做10次）
jstat -gc 2083 2000 20（每隔2秒监控一次，共做10）