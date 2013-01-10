# linux+httpd+svn搭建

## 一、环境
Linux: Linux 2.6.18-194.1.AXS3 #1 x86_64 x86_64 x86_64 GNU/Linux
httpd: 2.2.22
subversion: 1.6.18 （里面包含apr-1.4.6, apr-util-1.4.1）

## 二、安装
   全部采用源代码（*.tar.gz）安装。
#### 1、解压

	tar -zvxf httpd-2.2.22.tar.gz
	tar -zvxf subversion-1.6.18.tar.gz
	tar -zvxf  subversion-deps-1.6.18.tar.gz
注：subversion-1.6.18.tar.gz 与 subversion-deps-1.6.18.tar.gz 会解压到同一个subversion-1.6.18中。

#### 2、安装过程
1）apr-1.4.6

	> cd subversion-1.6.18/apr
	>./configure （注：自动安装到/usr/local/apr）
	>make
	>make install
	2）apr-util-1.4.1
	>cd subversion-1.6.18/apr-util
	>./configure --with-apr=/usr/local/apr
	>make
	>make install
	3）httpd-2.2.22
	>cd httpd-2.2.22
	>./configure --prefix=/usr/local/apache2 --enable-dav --enable-so --enable-maintainer-mode --with-apr=/usr/local/apr --with-apr-util=/usr/local/apr
	>make
	>make install
注：--enable-dav --enable-so这两个参数必须加，不然启动httpd服务时报错。
具体看：http://jimingsong.iteye.com/blog/1186620

4）subversion-1.6.18

	>cd subversion-1.6.18
	>./configure --prefix=/usr/local/svn --with-apxs=/usr/local/apache2/bin/apxs --with-apr=/usr/local/apr --with-apr-util=/usr/local/apr --with-ssl --enable-maintainer-mode
	>make
	>make install

注：--with-apr=/usr/local/apr --with-apr-util=/usr/local/apr必须与httpd-2.2.22中configure中--with-apr=/usr/local/apr --with-apr-util=/usr/local/apr相同。
具体看：http://liuzg-521.blog.163.com/blog/static/12931652010101113710688/

5）启动httpd服务
必须这样启动：`>/usr/local/apache2/bin/apachectl -k start`
不能这样启动：`>cd /usr/local/apache2/bin`
    		  `>apachectl -k start`

6）关于安装后的相关配置不再详细，请参考第三部分的首两篇文章。

## 三、参考文章（感谢各位！）

1）SVN服务器的搭建和基础配置--Linux环境 http://blog.csdn.net/tbkken/article/details/7629209
2）Linux下apache+SVN搭建完美版 http://blog.csdn.net/laiahu/article/details/6691419
3）装个svn真TM费劲，SVN+apache配置 总算启动没报错，麻烦 http://liuzg-521.blog.163.com/blog/static/12931652010101113710688/
4）apache安装常见问题 http://sndapk.blog.51cto.com/5385144/922732
补充一篇（主要是针对Linux用户权限的问题）：
Linux(centos)下apache与svn整合安装 http://www.phpwebgo.com/2012/06/20/371.html