# Linux Note

## Linux技巧：一次删除一百万个文件的最快方法

- [Linux技巧：一次删除一百万个文件的最快方法](http://web.itivy.com/article-797-1.html)

Command	Elapsed	System Time	%CPU	cs (Vol/Invol)
rsync -a –delete empty/ a	10.60	1.31	95	106/22
find b/ -type f -delete	28.51	14.46	52	14849/11
find c/ -type f | xargs -L 100 rm	41.69	20.60	54	37048/15074
find d/ -type f | xargs -L 100 -P 100 rm	34.32	27.82	89	929897/21720
rm -rf f	31.29	14.80	47	15134/11


## 上传下载工具 lrzsz

rz 选择要上传的文件。
sz [文件名] 下载到本地

更多使用详解，请输入 rz --help 或 sz --help 查阅。


## zip

压缩：zip -r archive_name.zip directory_to_compress
解压：nzip archive_name.zip

## tar

压缩：tar -cvf archive_name.tar directory_to_compress
解压：tar -xvf archive_name.tar.gz
	上面这个解包命令将会将文档解开在当前目录下面。当然，你也可以用这个命令来捏住解包的路径：
	 tar -xvf archive_name.tar -C /tmp/extract_here/

## tar.gz

压缩：tar -zcvf archive_name.tar.gz directory_to_compress
解压：tar -zxvf archive_name.tar.gz
	  tar -zxvf archive_name.tar.gz -C /tmp/extract_here/

## tar.bz2

压缩：tar -jcvf archive_name.tar.bz2 directory_to_compress
解压：tar -jxvf archive_name.tar.bz2
	  tar -jxvf archive_name.tar.bz2 -C /tmp/extract_here/


