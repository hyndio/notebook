# Something You must note

##  eclipse中的task管理

[来源](http://hi.baidu.com/jinxv1987/item/64496f6e68ea162568105b0f)

	// TODO —— 表示尚未完成的待办事项。
	// XXX —— 表示被注释的代码虽然实现了功能，但是实现方案有待商榷，希望将来能改进。
	// FIXME —— 表示被注释的代码需要被修正。

## java.util.ConcurrentModificationException

	/* 这种remove法会异常多线程修改异常
        for (LogPool logPool : pools) {
            if (logPool.getPool().size() == 0 && i <= clearNum) {
                pools.remove(logPool);
                i++;
            }
        }*/

- [java.util.ConcurrentModificationException](http://stackoverflow.com/questions/8189466/java-util-concurrentmodificationexception)
- [java.util.ConcurrentModificationException 时的解决办法](http://sundful.iteye.com/blog/379520)

## 多线程并发

Thread-1 ---------instance1--------------instance2----------
Thread-2 ---------instance1--------------instance2----------

- 线程与对象实例不是一个级别的概念。
- 如果对象实例（尤其是单例的）被多个线程所有共享，必须小心处理对象实例读写问题。
- 页面过来的每一个http请求，中间件都会单独新开一个线程处理。

## 异常处理

- [funcreal小灶：web中全局的异常处理](http://bbs.csdn.net/topics/80244903)

**以下是部分引用：**

	你的工具包中的异常应该倾向于捕获还是倾向于抛出。我的观点是倾向于抛出。因为工具包一般不会仅为一个工程服务，而你并不知道下一个工程会如何处理异常。**异常的处理应该是和业务相关的。**即使不是工具包，这条规则同样适用，我经常像下面这样写代码：
	public void load() throws SQLException{
	  try{
	    …  
	  }finally{
	    DBUtil.close(conn, stat, rs);
	  }
	}
	如果异常太多怎么办？有时候一系列操作可能抛出n多个异常，这时候，我倾向于使用异常转译，这也是《effective java》中提倡的做法。下面是我在项目中的一个代码片断：
	try{
	  …做MISC订购接口请求包的解析
	} catch (javax.xml.parsers.ParserConfigurationException e) {
	throw new ProvisionException("解析定购请求包异常：" + e.getMessage());
	} catch (org.xml.sax.SAXException e) {
	throw new ProvisionException("解析定购请求包异常：" + e.getMessage());
	} catch (IOException e) {
	throw new ProvisionException("解析定购请求包异常：" + e.getMessage());
	}

**Discuss:**

	内部的异常都要抛出到上层函数处理，对于与业务没有直接关系的异常不用总抛出到最外层吧

	与业务没关系，不一定不能抛出，只是需要做异常转译。
	尤其是第三方工具包，我曾经用过一个，当它出错的时候，就自己捕获了自己的异常，没有抛出来，使我失去了对他的控制。当然这个工具包是小公司做的，它的部分源代码我看过，水平一般。


- [java web项目整体异常处理机制](http://www.iteye.com/topic/1073599)

**以下是部分引用：**

	【补充】ajax也可以进行拦截，但是因为ajax属于异步操作，action通过response形式直接把数据返回给ajax回调函数，如果发生异常，ajax是不会执行页面跳转的，所以必须把错误信息返回给回调函数，我针对json数据的ajax是这样做的：

- [深入探索高效的Java异常处理框架](http://www.sunwei.org/archives/196)
- [使用Spring MVC统一异常处理实战](http://cgs1999.iteye.com/blog/1547197)

## java.util.concurrent.ConcurrentLinkedQueue

参考：
- [对ConcurrentLinkedQueue进行的并发测试](http://www.iteye.com/topic/68279)

	线程安全
	
	poll也是要有等待算法的,也就是说,如果poll这后的业务逻辑运行时间小的话,多线程序没有任何意义,反之如果poll这后的业务逻辑运行时间相当于Thread.sleep(1);哈哈,多线程确实起作用!
	
	MS多线程不是用来加速的，只是更有效利用被阻塞时间而已，你在业务逻辑加上外部IO再试试
	没错 减少一个线程对cpu的独占时间 让多个线程轮换使用cpu 提高cpu的使用率

## logback日志级别

**低 TRACE->DEBUG->INFO->WARN->ERROR 高**

- [Logback浅析](http://www.cnblogs.com/yongze103/archive/2012/05/05/2484753.html)

>Logger可以被分配级别。级别包括：TRACE、DEBUG、INFO、WARN和ERROR，定义于ch.qos.logback.classic.Level类。程序会打印高于或等于所设置级别的日志，设置的日志等级越高，打印出来的日志就越少。如果设置级别为INFO，则优先级高于等于INFO级别（如：INFO、 WARN、ERROR）的日志信息将可以被输出,小于该级别的如DEBUG将不会被输出。为确保所有logger都能够最终继承一个级别，根logger总是有级别，默认情况下，这个级别是DEBUG。

## logback日志文件默认输出路径

- [logback配置日志文件位置](http://kyfxbl.iteye.com/blog/1550408)

logback输出的日志文件，默认会放到“启动进程”的目录下面 

比如说程序直接在eclipse里跑，就会输出到eclipse.exe所在的目录下，如果是在tomcat中跑，就会输出到%TOMCAT_HOME%/bin目录下 

**不建议使用相对路径**

tomcat下可以用：${catalina.base}/logs/your_log.log

## IE的洁癖！！404, 500 

**1024b = 1KB = 512个中文汉字**

关于web.xml中配置404错误跳转页面 在ie不能显示自定义错误页面的问题
<error-page>
  <error-code>404</error-code>
  <location>/error_pages/404.html</location>
</error-page>
本来自己定义了一个错误页面，不过在ie中怎么也显示不出来，firefox一点问题都没有，几经查询才知道原来是ie自作聪明给换掉了，对错误页面的处理在ie来看页面大小小于1024b会被认为十分不友好，所以ie就将改页面给替换成自己的错误提示页面了，解决办法就是充实一下页面,让大小超过1024即可。

## unchecked Exception & checked Exception

- [unchecked Exception & checked Exception](http://blog.csdn.net/pengchua/article/details/2610324)

>- Unchecked Exception.：包括 Error与RuntimeException. 这类异常都是RuntimeException的子类。
- Checked Exception:除了Error与RuntimeException，其他剩下的异常. 这类异常都是Exception的子类 。在编译时在语法上必须处理的异常，因此必须在语法上以try..catch加以处理；

- unchecked Exception：不能处理，抛到上层处理。最好能提供明确的信息。
- checked Exception：如果能处理，就近处理，否则抛到上层处理。

>记住，只在要会抛出异常的地方进行异常处理。

>Use checked expections for recoverable conditions and runtime exceptions for programming errors (Effective Java: Item 58 in 2nd edition)

- [stackoverflow Java: checked vs unchecked exception explanation](http://stackoverflow.com/questions/6115896/java-checked-vs-unchecked-exception-explanation)

- spring读jar里面的文件

ClassPathResource resource = new ClasspathResource("testMediaExif", getClass())
resource.getInputStream();

One more thing: ClasspathResource.getFile() will only work in the resource really is a file. If it's packed in a JAR, then it won't work.

Maybe the text file is inside a jar? In that case you will have to use getInputStream() to read its contents.

## JSON.stringify

- [JSON.stringify语法讲解](http://www.cnblogs.com/damonlan/archive/2012/03/13/2394787.html)

## getOutputStream() has already been called for this response异常的原因和解决方法

- [getOutputStream() has already been called for this response异常的原因和解决方法[转]](http://www.cnblogs.com/jorton/archive/2012/05/04/2482609.html)

jsp页面上写java程序的时候出现。解决办法：在后面加

	out.clear();
	out = pageContext.pushBody();

## java.io.tmpdir

>java.io.tmpdir Default temp file path

On Windows: java.io.tmpdir:[C:\DOCUME~1\joshua\LOCALS~1\Temp\]
On Solaris: java.io.tmpdir:[/var/tmp/]
On Linux: java.io.tmpdir: [/tmp]
On Mac OS X: java.io.tmpdir: [/tmp]

The default temporary-file directory is specified by the system property java.io.tmpdir. On UNIX systems the default value of this property is typically "/tmp" or "/var/tmp"; on Microsoft Windows systems it is typically "c:\temp". A different value may be given to this system property when the Java virtual machine is invoked, but programmatic changes to this property are not guaranteed to have any effect upon the the temporary directory used by this method.

To specify the java.io.tmpdir System property, you can invoke the JVM as follows:
java -Djava.io.tmpdir=/path/to/tmpdir  

By default this value should come from the TMP environment variable on Windows systems

## java.net.SocketException

- [java.net.SocketException四大异常解决方案](http://developer.51cto.com/art/201003/189724.htm)

## private static final变量详解
- private是私有的，只在同一个类或内部类里可以访问。
- static是静态的，静态的变量是类的变量，不是对象的特性。
- final修饰的变量一次赋值将不能被改变。

## Volatile & synchronized

- [Java 理论与实践: 正确使用 Volatile 变量](http://www.ibm.com/developerworks/cn/java/j-jtp06197.html)

>Volatile变量具有synchronized 的可见性特性，但是不具备原子特性。这就是说线程能够自动发现 volatile 变量的最新值。Volatile 变量可用于提供线程安全，但是只能应用于非常有限的一组用例：多个变量之间或者某个变量的当前值与修改后值之间没有约束。因此，单独使用 volatile 还不足以实现计数器、互斥锁或任何具有与多个变量相关的不变式（Invariants）的类（例如 “start <=end”）。
出于简易性或可伸缩性的考虑，您可能倾向于使用 volatile 变量而不是锁。当使用 volatile 变量而非锁时，某些习惯用法（idiom）更加易于编码和阅读。此外，volatile 变量不会像锁那样造成线程阻塞，因此也很少造成可伸缩性问题。**在某些情况下，如果读操作远远大于写操作，volatile 变量还可以提供优于锁的性能优势。**

- [如何使用java synchronized进行线程同步](http://blog.csdn.net/soartju/article/details/2840491)

>1、synchronized关键字的作用域有二种： 
1）是某个对象实例内，synchronized aMethod(){}可以防止多个线程同时访问这个对象的synchronized方法（如果一个对象有多个synchronized方法，只要一个线程访问了其中的一个synchronized方法，其它线程不能同时访问这个对象中任何一个synchronized方法）。这时，不同的对象实例的synchronized方法是不相干扰的。也就是说，其它线程照样可以同时访问相同类的另一个对象实例中的synchronized方法； 
2）是某个类的范围，synchronized static aStaticMethod{}防止多个线程同时访问这个类中的synchronized static 方法。它可以对类的所有对象实例起作用。 

>2、除了方法前用synchronized关键字，synchronized关键字还可以用于方法中的某个区块中，表示只对这个区块的资源实行互斥访问。用法是: synchronized(this){/*区块*/}，它的作用域是当前对象； 

>3、synchronized关键字是不能继承的，也就是说，基类的方法synchronized f(){} 在继承类中并不自动是synchronized f(){}，而是变成了f(){}。继承类需要你显式的指定它的某个方法为synchronized方法；

## window.eval

- [BX9056: 各浏览器下 window.eval 方法的执行上下文存在差异](http://w3help.org/zh-cn/causes/BX9056)
- [JavaScript Essence: 傳送與接收 JSON](http://openhome.cc/Gossip/JavaScript/JSON.html)
- [解決IE 'JSON' 未被定義 的錯誤](http://www.dotblogs.com.tw/joysdw12/archive/2011/08/01/32414.aspx)

## Servlet 工作原理解析

- [Servlet 工作原理解析](http://www.ibm.com/developerworks/cn/java/j-lo-servlet/)

##  实际应用中JSP页面的异常处理

- [实际应用中JSP页面的异常处理](http://blog.csdn.net/lonelyroamer/article/details/7350292)

## 代码之谜（二）- 语句与表达式  每个表达式都有一个值

- [代码之谜（二）- 语句与表达式](http://justjavac.com/codepuzzle/2012/10/28/codepuzzle-expression-and-statement.html)

>"表达式"（expression）是一个单纯的运算过程，总是有返回值；
"语句"（statement）是执行某种操作，没有返回值。

## Java正则表达式

- [Java程序员：一刻钟精通正则表达式](http://webservices.ctocio.com.cn/tips/331/7643831.shtml)
	- ^ 和 $ 匹配字符串的`开始`和`结束`
	-  *, +, ?, 表示`一个字符`可以出现的`次数`或者`顺序`
		- * : "zero or more"相当于{0,}
　　	- + : "one or more"相当于{1,}
　　	- ? : "zero or one."相当于{0,1}
		- 要点：只管它前面那个字符

- [Java URL正则表达式](http://blog.csdn.net/jiaguanghan123/article/details/5217511)

## JavaScript 只有函数作用域

由于 JavaScript 只有函数作用域，没有块级作用域，因此在 `for`、`if/else`、`do/while`、`switch/case`、`try/catch` 这些块中定义的变量，实际在块之外也可以使用。

```js
function functionScope() {
 for (var i = 0, l = 5; i < l; i++) {
   var blockVariable = i;
 }
 alert(i); // 5
 alert(blockVariable); // 4
}
```

**就近原则：**
>文档、注释尽可能的靠近代码。变量声明应尽可能的靠近变量使用。应尽量限制变量的作用域。

## SQL: case when then end

- [SQL中Case的使用方法(上篇)](http://www.cnblogs.com/Ronin/archive/2006/07/20/455388.html)
- [SQL中Case的使用方法(下篇)](http://www.cnblogs.com/Ronin/archive/2006/07/20/455756.html)

Case具有两种格式。简单Case函数和Case搜索函数。 

	--简单Case函数
	CASE sex
	         WHEN '1' THEN '男'
	         WHEN '2' THEN '女'
	ELSE '其他' END
	--Case搜索函数
	CASE WHEN sex = '1' THEN '男'
	     WHEN sex = '2' THEN '女'
	ELSE '其他' END
 
这两种方式，可以实现相同的功能。简单Case函数的写法相对比较简洁，但是和Case搜索函数相比，功能方面会有些限制，比如写判断式。 
还有一个需要注意的问题，Case函数只返回第一个符合条件的值，剩下的Case部分将会被自动忽略。 
--比如说，下面这段SQL，你永远无法得到“第二类”这个结果

	CASE WHEN col_1 IN ( 'a', 'b') THEN '第一类'
	     WHEN col_1 IN ('a')       THEN '第二类'
	ELSE'其他' END

## 断言

断言的英文是assertion，断言检查的英文是assertion checking。
断言是指定一个程序必须已经存在的状态的一个逻辑表达式，或者一组程序变量在程序执行期间的某个点上必须满足的条件。
断言检查是用户在程序中嵌入的断言的检查。

断言语句指定希望为 true 在您的程序的点的行为。 如果该条件未得到满足，则断言失败，中断程序的执行。

true: do nothing. Execute continue!
false: Execute interrupt. Print tips!

- [JAVA断言使用](http://77488710.blog.163.com/blog/static/21486300200822934236644/?COLLCC=1631265529&)

## java反射详解

- [java反射详解](http://www.cnblogs.com/rollenholt/archive/2011/09/02/2163758.html)

## oralce 建快表

	create table tmp_resource as
	SELECT T.RES_ID, T.RES_PID, T.MENU_ID 
	  FROM BASE_RESOURCE T
	 ORDER BY T.RES_ID ASC

## java.util.Date和java.sql.Date的区别及应用

-[java.util.Date和java.sql.Date的区别及应用](http://www.cnblogs.com/lvjianjun/archive/2010/08/24/1807501.html)

java.util.Date 就是在除了SQL语句的情况下面使用
java.sql.Date 是针对SQL语句使用的，它只包含日期而没有时间部分
它都有getTime方法返回毫秒数，自然就可以直接构建
java.util.Date d = new java.util.Date(sqlDate.getTime());

java.util.Date 是 java.sql.Date 的父类（注意拼写）
前者是常用的表示时间的类，我们通常格式化或者得到当前时间都是用他
后者之后在读写数据库的时候用他，因为PreparedStament的setDate()的第2参数和ResultSet的getDate()方法的第2个参数都是java.sql.Date 
转换是
java.sql.Date date=new Java.sql.Date();
java.util.Date d=new java.util.Date (date.getTime());
反过来是一样的

继承关系：java.lang.Object --》 java.util.Date --》 java.sql.Date
具体的转换关系就是java.util.Date d=new java.util.Date (new Java.sql.Date());

java.sql.Date主要是用于sql中的！
而java.util.Date用语一般的环境下都行！

SimpleDateFormat f=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
       java.util.Date utilDate=new Date();      
       java.sql.Date sqlDate=new java.sql.Date(utilDate.getTime());        
       java.sql.Time sTime=new java.sql.Time(utilDate.getTime());   
       java.sql.Timestamp stp=new java.sql.Timestamp(utilDate.getTime());
      System.out.println(utilDate.getYear());

这里所有时间日期都可以被SimpleDateFormat格式化format()

f.format(stp);f.format(sTime);f.format(sqlDate);f.format(utilDate)
java.sql.Date sqlDate=java.sql.Date.valueOf("2005-12-12");
utilDate=new java.util.Date(sqlDate.getTime());


## Eclipse中关于JRE System Library、Web App Libraries的疑惑

   当我们在Eclipse中建立java的web工程时，会产生JRE System Library和Referenced Libraries，Web App Libraries不生成，下面会

简要说明一下。

   其实，这三个都是jar包的存放集合。

   JRE System Library主要存放J2SE的标准jar，一般不需要调整。

   Referenced Libraries是存放第三方的jar包，也就是自己导入的jar包。在项目属性的Java Build Path中的Libraries中配置。本人理解，

这里导入和配置jar包，都是为了让web工程能够在eclipse开发环境可以正常编译，不报错而已。。如果该web工程利用eclipse生成war包，

是不会导出其jar包到WEB-INF/lib文件夹下的。

  Web App Libraries的主要作用是让eclipse导出war包的时候，会把其目录下的所有jar或者项目中的工程引用都导出到WEB-INF/lib文件

夹下。Web App Libraries中的jar包在eclipse中项目属性的Java EE Module Dependencies配置的。如果你勾上了，或者添加了外部jar

包，都会在WEB-INF/lib文件夹下生成。当然，如果你直接在WEB-INF/lib文件夹下，copy一个jar进入，刷新一下，Web App Libraries

也会自动增加一个jar的引用。简单说，Java EE Module Dependencies的配置只针对Web App Libraries的。