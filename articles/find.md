1.1命令选项
-name ：照文件名查找文件。
-perm：照文件权限来查找文件。
-user：照文件属主来查找文件。
-group：照文件所属的组来查找文件。
-mtime -n +n：照文件的更改时间来查找文件， - n表示文件更改时间距现在n天以内，+ n表示文件更改时间距现在n天以前。find命令还有-atime和-ctime 选项，但它们都和-m time选项。
-nogroup：找无有效所属组的文件，即该文件所属的组在/etc/groups中不存在。
-nouser:找无有效属主的文件，即该文件的属主在/etc/passwd中不存在。
-newer file1 ! file2 :找更改时间比文件file1新但比文件file2旧的文件。
-type :找某一类型的文件，诸如：
b - 块设备文件。
d - 目录。
c - 字符设备文件。
p - 管道文件。
l - 符号链接文件。
f - 普通文件。
-size n：[c] 查找文件长度为n块的文件，带有c时表示文件长度以字节计。
-depth：在查找文件时，首先查找当前目录中的文件，然后再在其子目录中查找。
-fstype：查找位于某一类型文件系统中的文件，这些文件系统类型通常可以在配置文件/etc/fstab中找到，该配置文件中包含了本系统中有关文件系统的信息。
-mount：在查找文件时不跨越文件系统mount点。
-follow：如果find命令遇到符号链接文件，就跟踪至链接所指向的文件。
-cpio：对匹配的文件使用cpio命令，将这些文件备份到磁带设备中。


另外,下面三个的区别:
-amin n：系统中最后N分钟访问的文件
-atime n：系统中最后n*24小时访问的文件
-cmin n：　查找系统中最后N分钟被改变文件状态的文件
-ctime n：　查找系统中最后n*24小时被改变文件状态的文件
-mmin n：　查找系统中最后N分钟被改变文件数据的文件
-mtime n：　查找系统中最后n*24小时被改变文件数据的文件


1.2  结合其他命令
-print： find命令将匹配的文件输出到标准输出。
-exec： find命令对匹配的文件执行该参数所给出的shell命令。相应命令的形式为'command' { } \;，注意{ }和\；之间的空格。
例如：
a. 列出当前目录下所有文件：
bash-2.03＄ find . -type f -exec ls -l {} \;
-rwxr-xr-x  1 ismg282  aisoft      5026  1月  9 15:40 ./wangzl/aimgtrace.ismg
-rwxr-xr-x  1 ismg282  aisoft      1310  1月 10 16:07 ./wangzl/smsICP.sh
-rw-r--r--  1 ismg282  aisoft        15  5月 31 16:14 ./aa.txt
-rw-r--r--  1 ismg282  aisoft        15  5月 31 16:15 ./bb.txt
-rw-r--r--  1 ismg282  aisoft        15  5月 31 16:15 ./bak/aa.txt


b. 删除满足要求的目录下的所有文件：
find . -type d -name "LogBak" -exec rm -rf {}/* \;
find . -type d -name "BillBak" -exec rm -rf {}/* \;
find . -type d -name "BillTmpBak" -exec rm -rf {}/* \;
find . -type d -name "Data" -exec rm -fr {}/* \;
find . -type d -name "Trap" -exec rm -fr {}/* \;

-ok： 和-exec的作用相同，只不过以一种更为安全的模式来执行该参数所给出的shell命令，在执行每一个命令之前，都会给出提示，让用户来确定是否执行。

Xargs：但有些系统对能够传递给exec的命令长度有限制，这样在find命令运行几分钟之后，就会出现溢出错误。错误信息通常是“参数列太长”或“参数列溢出”。这就是xargs命令的用处所在，特别是与find命令一起使用。例子：用grep命令在当前目录下的所有普通文件中搜索hostnames这个词：
bash-2.03＄ find . -name \* -type f -print | xargs grep "test"
./aa.txt:test
./bb.txt:test
./bak/aa.txt:test


3) find
find命令是功能最强的命令之一，但同时也是命令行结构最难以掌握的命令之一。
# find / -print | wc -l 显示系统中所有文件和目录的数目。
# find / -user $LOGNAME -print 显示系统中该用户所有文件和目录。
# find / -size 100 -print 显示文件大小为100 blocks。
# find / -size -100 -print 显示文件大小小于100 blocks 。
# find / -size +100 -print 显示文件大小大于100 blocks 。
# find / -name core -exec rm {} ；查找并删除core文件。
# find . -exec chown $LOGNAME {} ； 修改一个目录下的所有文件的用户所属。
# find .-type d -exec chmod 770 {} ；修改一个目录下的所有目录的权限。
# find . -ctime +3 -exec ls -l {} \; 查找当前目录下3天前创建的文件并列出(ctime 创建,atime 访问,mtime 修改)
  find /home/m_collect_b_hdc/top/ -ctime +3 -exec rm {} \;
