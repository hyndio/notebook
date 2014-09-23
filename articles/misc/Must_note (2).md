
## 忽略已版本控制的条目
已版本控制的文件或目录不能够忽略，这是subversion的一个特性。
如果你错误的版本控制了一个文件，阅读“-[忽略已经版本控制的文件](http://tortoisesvn.net/docs/release/TortoiseSVN_zh_CN/tsvn-howto-unversion.html)”一节介绍怎样“取消版本控制(unversion)”。


## jsp:include不能解析EL表达式？

<%@ page isELIgnored="false" %>
<html>
<body>
    <jsp:include page="test2.jsp" flush="true">
        <jsp:param name="test" value="make it" />
    </jsp:include>
</body>
</html>

test2.jsp(将被导入的servlet)

<em><strong>${param.test}</strong></em>

el表达式没被解析。那就要看isELIgnored是否被禁用了，test.jsp的第一行就已经启用EL了。要找出问题还得从jsp:include的工作原理说起。jsp:include是动态导入servlet的。也就是在运行时插入test2.jsp的响应。我说的是插入的是test2.jsp的响应而不是插入test2.jsp的源代码。也就是说EL表达式要在test2.jsp中解析。这就要确保test2.jsp也启用了EL。你可能会说，EL表达式默认的不就是启用的吗？那是以前的servlet版本了，起码我现在用的默认的是禁用EL的。可以到这里找到更详细的说明。剩下的工作就是要在test2.jsp中启用EL表达式：

<%@ page isELIgnored="false" %>
<em><strong>${param.test}</strong></em>


## mvc:view-controller path 

两种用法

1、重定向
<mvc:view-controller path="/" view-name="redirect:/admin/index"/>
即如果当前路径是/ 则重定向到/admin/index

2、view name
<mvc:view-controller path="/" view-name="admin/index"/>
如果当前路径是/ 则交给相应的视图解析器直接解析为视图
如
<bean id="defaultViewResolver" class="org.springframework.web.servlet.view.InternalResourceViewResolver" p:order="2">
        <property name="viewClass" value="org.springframework.web.servlet.view.JstlView"/>
        <property name="contentType" value="text/html"/>
        <property name="prefix" value="/WEB-INF/jsp/"/>
        <property name="suffix" value=".jsp"/>
    </bean>

则得到的视图时 /WEB-INF/jsp/admin/index.jsp


## 解析 this.initialize.apply(this, arguments)

-[解析 this.initialize.apply(this, arguments)](http://www.cnblogs.com/uedt/archive/2010/06/24/1764561.html)

二、 Js的面向对象 
initialize是什么? 
只不过是个变量，代表一个方法，用途是`类的构造函数`。 
其具体功能靠js的面向对象支持，那么js的面向对象是什么样子的那？和java 的有什么相同与不同？ 

那么JS中的函数和类有什么不同呢？ 
其实是一样的，ClassName就是一个函数，当出现在new后面的时候就作为一个构造函数来构造对象。 

在ClassName函数中的`this`指的就是new之后构造出来的对象

---
var objectName2 = ClassName(“b”);

这样objectName2得到的是什么呢？显然是方法的返回值，这里ClassName只作为了一个普通的函数（虽然首字母大写了）。但是在之前写的ClassName中并没有返回值，所以objectName2会是undifinded那么“b”赋给谁了呢？在这并没有产生一个对象，而只是单纯的执行这个方法，所以这个“b”赋值给了调用这个方法的对象window，证据如下： 
var objectName2 = ClassName(“b”);//得到一个对象 
alert(window.value)；//对话框b 
所以JS中的所有function都是一样的，但是用途可能是不同的（用作构造对象抑或是执行一个过程）。 

---
A.prototype={ 
    initialize:function(v){ 
        this .value=v; 
    } 
    showValue:function(){ 
        alert(this.value); 
    } 
}

是什么意思呢？ 
Prototype是“原型”的意思。A是一个function()，那么A.prototype，就是function中的一个变量，其实是个对象。这个对象拥有什么方法，那么function产生的对象就拥有什么方法

---
三、 call()和apply() 
功能基本一样，`function().call(object,{},{}……)`或者`function().apply (object,[……])`的功能就是对象object调用这里的funciton()，不同之处是call参数从第二个开始都是传递给funciton的，可以依次罗列用“，”隔开。而apply只有两个参数，第二个是一个数组，其中存储了所有传递给function的参数。 
this.initialize.apply(this , arguments); 
是什么意思？ 
这里的第一个this，是指用new调用构造函数之后生成的对象，也就是前面的a，那么第二个this也当然应该是指同一个对象。那这句话就是this（也就是a）调用initialize方法，参数是arguments对象（参数的数组对象），所以在构造函数执行的时候，对象a就会去执行initialize方法来初始化，这样就和单词“initialize”的意思对上了。 
那么执行initialize方法的参数怎么传递进去的呢？

---
四、 Arguments对象 

arguments就是调用函数的实参数组

--- 
attributes

Definition and Usage
The attributes property returns a collection of the specified node's attributes, as a NamedNodeMap.

Tip: You can use the length property to determine the number of attributes, then you can loop through all attributes nodes and extract the info you want.

Tip: Each attribute is a Node object, with all the properties available for the Node object.

Note: In Internet Explorer 8 and earlier, the attributes property will return a collection of all possible attributes for an element.

Syntax
node.attributes

## SVN错误：Attempted to lock an already-locked dir

因为这两天频出这个现象，现在基本不怕这个问题了
我是这样解决的：
1 三令五申项目的组员必须先同步，合并，再提交
2 操作后经常地在父目录使用clean up命令
3 解决了locked问题后，还出现不能更新的现象时，就删除目录下的所有文件，包括.svn，再重新check out服务器同目录一次
4 总之，操作要规范，要强调组员每天开工时，先在ECLIPSE里同步，下班时，要提交（提交前，先在文件夹的右菜单中，选择小组>清除），保证每个人的机子里在开工前都是最新版本

老实讲，因为版本冲突，提交冲突，更新失败等等问题，耽误了好些时间，但我知道主要还是自身操作不熟练不规范的问题。我相信，只要坚持，大家包括我的组员一定都会喜欢上这个小海龟的  

## JMS

J2EE中，JMS（Java Message System）提供了一种异步处理机制的实现。JMS通过异步的、非阻塞的消息传递，将消息的生产者和使用者松散的联系在一起。对于使用者，它无所谓是谁产生了消息或者是在何时产生的。这就能够建立一种动态的、灵活的可靠的系统。所谓可靠，因为JMS将每个消息都保存起来，只有确保本消息处理后才会完全放弃。否则，将会反复提交处理。这种可靠的机制使得JMS能够成功的在证券、银行系统中得到广泛应用。 

JMS中的消息类型有两种：Topic和Queue。Topic的操作是使用发布/订阅（publish/subscribe）的方式；Queue的操作是点对点（ponit to point）的方式。 

·publish/subscribe：发布者（publisher）发布消息到Topic，订阅者（subsribe）从Topic订阅消息，订阅者的数量是不受限制的。 

· ponit to point：点对点传输消息，建立在消息队列Queue的基础上，每个消息使用者只对应一个消息队列，不像publish/subscribe那样可以有很多消息使用者。 

JMS在消息到达消息使用者，有两种——同步和异步。 

·同步是指消息使用者明确地主动地调用从Queue或Topic中得到消息，一直进行循环直至一个消息到达，或者也可以设定超时时间。很明显这个方法是比较耗费CPU资源的。 

·异步接受是指消息到达时，主动通知消息使用者，消息使用者可以实现message listener接口。这样每当消息到达时，JMS provider 会通过调用这个listener的onMessage方法来传输这个消息。 

## web service & RPC

-[unmarshalling-an-axis-generated-multiref-containing-soap-response-with-jax](http://stackoverflow.com/questions/266621/unmarshalling-an-axis-generated-multiref-containing-soap-response-with-jaxb)

**if you are dealing with MultiREFs , then you are probably consuming an RPC service. JAXB is suitable for Document style webservices.**

In order to consume an RPC style service, do not use any external binding like JAXB, JIBX or

use plain JAX-RPC , wsdl2java Ant task is available to generate the stubs, and specify nobinding option.

## svn cleanup

cleanup用于解除锁定 revert用于取消本地的编辑
关于解除锁定 下面这段就说的很清楚很好理解：

svn cleanup

当Subversion改变你的工作拷贝（或是.svn中的任何信息），它会尽可能的小心，在修改任何事情之前，它把意图写到日志文件中去，然后执行log文件中的命令，并且执行过程中在工作拷贝的相关部分保存一个锁— 防止Subversion客户端在变更过程中访问工作拷贝。然后删掉日志文件，这与记帐试的文件系统架构类似。如果Subversion的操作中断了（举个例子：进程被杀死了，机器死掉了），日志文件会保存在硬盘上，通过重新执行日志文件，Subversion可以完成上一次开始的操作，你的工作拷贝可以回到一致的状态。

这就是svn cleanup所作的：它查找工作拷贝中的所有遗留的日志文件，删除进程中工作拷贝的锁。如果Subversion告诉你工作拷贝中的一部分已经“锁定”了，你就需要运行这个命令了。同样，svn status将会使用L 显示锁定的项目：

$ svn status
  L    somedir
M      somedir/foo.c 

$ svn cleanup
$ svn status
M      somedir/foo.c

## Spring如何加载XSD文件(org.xml.sax.SAXParseException: Failed to read schema document错误的解决方法)

-[Spring如何加载XSD文件(org.xml.sax.SAXParseException: Failed to read schema document错误的解决方法)](http://blog.csdn.net/bluishglc/article/details/7596118)

>在很多spring的jar包里，在META-INF目录下都有一个spring.schemas，这是一个property文件.

>实际上，这个文件就是spring关于xsd文件在本地存放路径的映射，spring就是通过这个文件在本地（也就是spring的jar里）查找xsd文件的。那么，查找不到的原因排除URL输入有误之外，可能就是声明的xsd文件版本在本地不存在。一般来说，新版本的spring jar包会将过去所有版本(应该是自2.0以后)的xsd打包，并在spring.schemas文件中加入了对应项，出现问题的情况往往是声明使用了一个高版本的xsd文件，如3.0，但依赖的spring的jar包却是2.5之前的版本，由于2.5版本自然不可能包含3.0的xsd文件，此时就会导致spring去站点下载目标xsd文件，如遇断网或是目标站点不可用，上述问题就发生了。

>但是，在实现开发中，出现上述错误的几率并不高，最常见的导致这一问题的原因其实与使用了一个名为“assembly”的maven打包插件有关。很多项目需要将工程连同其所依赖的所有jar包打包成一个jar包，maven的assembly插件就是用来完成这个任务的。但是由于工程往往依赖很多的jar包，而被依赖的jar又会依赖其他的jar包，这样，当工程中依赖到不同的版本的spring时，在使用assembly进行打包时，只能将某一个版本jar包下的spring.schemas文件放入最终打出的jar包里，这就有可能遗漏了一些版本的xsd的本地映射，进而出现了文章开始提到的错误。如果你的项目是打成单一jar的，你可以通过检查最终生成的jar里的spring.schemas文件来确认是不是这种情况。而关于这种情况，解决的方法一般是推荐使用另外一种打包插件shade,它确实是一款比assembly更加优秀的工具，在对spring.schemas文件处理上，shade能够将所有jar里的spring.schemas文件进行合并，在最终生成的单一jar包里，spring.schemas包含了所有出现过的版本的集合！