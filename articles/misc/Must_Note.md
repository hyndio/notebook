
# Note

## 敏捷：什么是用户故事（User Story）

- [敏捷：什么是用户故事（User Story）](http://www.cnblogs.com/henryhappier/archive/2011/02/23/1962617.html)

## jsp1.2 标签

1 TagSupport与BodyTagSupport的区别  

TagSupport与BodyTagSupport的区别主要是标签处理类是否需要与标签体交互，如果不需要交互的就用TagSupport，否则如果需要交互就用BodyTagSupport。

交互就是标签处理类是否要读取标签体的内容和改变标签体返回的内容。  
用TagSupport实现的标签，都可以用BodyTagSupport来实现，因为BodyTagSupport继承了TagSupport。 

2 doStartTag(),doEndTag()  

doStartTag()方法是遇到标签开始时会呼叫的方法，其合法的返回值是EVAL_BODY_INCLUDE与SKIP_BODY,前者表示将显示标签间的文字，后者表示不显示标签间的文字；

doEndTag()方法是在遇到标签结束时呼叫的方法，其合法的返回值是EVAL_PAGE与SKIP_PAGE，前者表示处理完标签后继续执行以下的JSP网页，后者是表示不处理接下来的JSP网页  

doAfterBody(),这个方法是在显示完标签间文字之后呼叫的，其返回值有EVAL_BODY_AGAIN与SKIP_BODY，前者会再显示一次标签间的文字，后者则继续执行标签处理的下一步。  

预定的处理顺序是：
doStartTag()返回SKIP_BODY,doAfterBodyTag()返回SKIP_BODY,doEndTag()返回EVAL_PAGE.  

如果继承了TagSupport之后，如果没有改写任何的方法，标签处理的执行顺序是：  
doStartTag() ->不显示文字 ->doEndTag()->执行接下来的网页  

如果您改写了doStartTag(),则必须指定返回值，如果指定了EVAL_BODY_INCLUDE,则执行顺序是  
doStartTag()->显示文字->doAfterBodyTag()->doEndTag()->执行下面的网页  

## eclipse project desc

.project是项目文件，项目的结构都在其中定义，比如lib的位置,src的位置,classes的位置
	- 工程名<name></name>
	- 工程注释描述<comment></comment>
	- 运行时需要的额外Eclipse插件<natures></natures>，及其具体加载方式信息<buildSpec></buildSpec>

	nature是工程特性的一种标识，eclipse中有如此多种类的project，系统是如何识别他们的。IProject对象本身没有什么特别的标识，所以区分各种不同的project，主要是nature来进行区分。例如，如果两种不同的project对象，如果有同样的一种nature特性，如果我们只需要考虑这种nature特性的时候，这两种project其实是可以等同的。可以借鉴equals方法来进行理解。

	一个nature里面可以包含多个builder，并且用builder的id进行识别.

	刚才说到nature是用来标识project的特性的，但是特性不能当饭吃。new一个工程里面那么多东西，而且算不是new，是其他改变工程里面资源的操作。如果说nature只是标识，那么builder就是实实在在的构建了。

.classpath的位置定义了你这个项目在编译时所使用的$CLASSPATH
	- 源文件的具体位置（kind="src"）
	- 运行的系统环境（kind="con"）
	- 工程的library的具体位置信息(kind="lib")
	- 在每个lib的xml子节点中，有关于它的其它配置信息（例如我配置的那个"javadoc_location"）
	- 项目的输出目录(kind="output")

.settings 文件
	里面存放各种插件的配置文件。

## ant build.xml

>Eclipse 自动生成 Ant的Build.xml 配置文件,生成的方法很隐蔽
选择你要生成Build.xml文件的项目,右键. Export-> General -> Ant Buildfiles .

- build.properties

build.properties文件是存储一些公共变量的，比如你机子上tomcat的绝对路径。
其实也用到了面向对象的原理，如果你的环境变了，只需要更改build.properties文件就可以了。而不用去更改build.xm里的相关属性。build.properties也可以加上你想加的东西，比如公共的jar文件。

- build.xml
	2.1 build.xml的project
		project代表一个工程，有4个常见属性:
		(1). default 表示默认的运行目标，是必须的
		(2). basedir 表示工程的基准目录，"."表示和build.xml所在的目录。
		(3). name 表示工程的名字
		(4). description 对工程的描述，可写可不写，写上更清楚对以后的debug

	2.2 project 的property
	    每个property都有name和value两个属性，name是对该property的声明，而value就是值了！也是为了后边方便而设置的。
	2.3 build.xml的target
		每个build.xml只有个project，但是可以有多个target（目标).
		target 有5个属性：
		（1） name 自然是标识了，代表一个特定的target
		（2） depends 表示所依赖的target。即执行该target时，必须先执行depends 后边跟那个target。 
		（3） if  表示仅当属性设置时才执行
		（4） unless 表示当属性没有设置时才执行
		（5） Description 对target的描述

下面就介绍每个target中可以用那些命令，ant就是依靠这些命令去完成project 构建的。

**ant内置任务常用的有7个**
	1.mkdir----创建目录
	2.copy----copy文件
	3.delete---delete文件
	4.javac----编译java文件
	5.war-----打包发布
	6.javadoc---javadoc文件
	7.move---移动文件

ant还有其他内置的任务，不如zip等等，但是不常用就不介绍了

1.mkdir---make a new directory
创建一个目录，如果该目录存在，则设么也不做。

2.copy--copy文件
copy文件从指定的目录或者文件到目的目录。如果文件没有更新，则不会发生copy。
如果想覆盖，可以通过设置属性才达到覆盖。
Atribution:
(1) file 要copy的文件
(2) preservelastmodified 给出所要copy文件最近修改的时间
	默认是false，不常用
(3) tofile   copy的文件
(4) todir  copy 到那里
(5) overwrite 是否覆盖已经原有的文件加入该文件没有更新，就是和所copy的文件一模一样
	default 是false，即不overwrite
(6) filtering  过滤文件

## 修改tomcat的webapps发布路径

默认情况下访问tomcat的项目，需要在域名后添加项目名称才可以访问，如：http://localhost/project
可以修改配置文件
#vim server.xml
<Host name="localhost"  appBase="webapps"
            unpackWARs="true" autoDeploy="true"
            xmlValidation="false" xmlNamespaceAware="false">
</Host>
在<host></host>标签之间添加上：
<Context path="" docBase="atte" debug="0" reloadable="true" />

**说明：**

- path是说明虚拟目录的名字，如果你要只输入ip地址就显示主页，则该键值留为空；
- docBase是虚拟目录的路径，它默认的是$tomcat/webapps/目录，现在我在webapps目录下建了一个atte目录，让该目录作为我的默认项目。
- debug和reloadable一般都分别设置成0和true，重启tomcat应该就可以生效了

## EXTjs作用域是什么（What is that Scope all about ）

- [EXTjs作用域是什么（What is that Scope all about ）](http://www.cnblogs.com/meetrice/archive/2008/05/23/1206173.html)

- [Ext之事件处理（作用域）](http://lwq030409.blog.hexun.com/23536509_d.html)

**在Ext中指定作用域**

调用函数时，你可以把this想象为每个函数内的一个特殊（躲起来的）参数。无论什么时候，JavaScript都会把this放到function内部。它是基于一种非常简单的思想：如果函数直接是某个对象的成员，那么this的值就是这个对象。如果函数不是某个对象的成员那么this的值便设为某种全局对象（常见有，浏览器中的window对象）。下面的内部函数可以清晰的看出这种思想。

一个函数，若是分配到某个变量的，即不属于任何对象下的一员，那么this的参数就变为windows对象。

可以看到，没有分配作用域的函数，它的this"指向的是浏览器的window对象（如事件句柄event handler等等），——除非我们改变this的指针。Ext的很多类中 scope是一个配置项（configuration）能够进行指针的绑定。相关的例子参考Ajax.request。

*除了内建的call/apply方法，Ext还为我们提供-- 辅助方法createDelegate。 该函数的基本功能是绑定this指针但不立刻执行。传入一个参数，createDelegate方法会保证函数是运行在这个参数的作用域中。

## HTTP POST GET 本质区别详解

- [HTTP POST GET 本质区别详解](http://blog.csdn.net/gideal_wang/article/details/4316691)

## tomcat 热部署

<Host name="localhost"  appBase="webapps"
            unpackWARs="true" autoDeploy="true"
            xmlValidation="false" xmlNamespaceAware="false">
		
	<!-- Add by HYD: Hot deploy configs -->
	<Context path="/" docBase="/ROOT" debug="99" reloadable="true" />

</Host>

- [class卸载、热替换和Tomcat的热部署的分析](http://www.blogjava.net/heavensay/archive/2012/11/13/389685.html)

Tomcat中与其说有热加载，还不如说是热部署来的准确些。因为对于一个应用，其中class文件被修改过，那么Tomcat会先卸载这个应用(Context)，然后重新加载这个应用，其中关键就在于自定义ClassLoader的应用。这里有篇文章很好的介绍了tomcat中对于ClassLoader的应用，请点击here。

Tomcat启动的时候，ClassLoader加载的流程：
1 Tomcat启动的时候，用system classloader即AppClassLoader加载{catalina.home}/bin里面的jar包，也就是tomcat启动相关的jar包。
2 Tomcat启动类Bootstrap中有3个classloader属性，catalinaLoader、commonLoader、sharedLoader在Tomcat7中默认他们初始化都为同一个StandardClassLoader实例。具体的也可以在{catalina.home}/bin/bootstrap.jar包中的catalina.properites中进行配置。
3 StandardClassLoader加载{catalina.home}/lib下面的所有Tomcat用到的jar包。
4 一个Context容器，代表了一个app应用。Context-->WebappLoader-->WebClassLoader。并且Thread.contextClassLoader=WebClassLoader。应用程序中的jsp文件、class类、lib/*.jar包，都是WebClassLoader加载的。

当Jsp文件修改的时候，Tomcat更新步骤：
1 但访问1.jsp的时候，1.jsp的包装类JspServletWrapper会去比较1.jsp文件最新修改时间和上次的修改时间，以此判断1.jsp是否修改过。
2 1.jsp修改过的话，那么jspservletWrapper会清除相关引用，包括1.jsp编译后的servlet实例和加载这个servlet的JasperLoader实例。
3 重新创建一个JasperLoader实例，重新加载修改过后的1.jsp，重新生成一个Servlet实例。
4 返回修改后的1.jsp内容给用户。

当app下面的class文件修改的时候，Tomcat更新步骤：
1 Context容器会有专门线程监控app下面的类的修改情况。
2 如果发现有类被修改了。那么调用Context.reload()。清楚一系列相关的引用和资源。
3 然后创新创建一个WebClassLoader实例，重新加载app下面需要的class。

在一个有一定规模的应用中，如果文件修改多次，重启多次的话，java.lang.OutOfMemoryErrorPermGen space这个错误的的出现非常频繁。主要就是因为每次重启重新加载大量的class，超过了PermGen space设置的大小。两种情况可能导致PermGen space溢出。一、GC(Garbage Collection)在主程序运行期对PermGen space没有进行清理(GC的不可控行)，二、重启之前WebClassLoader加载的class在别的地方还存在着引用。

## Extjs 扩展

-[移花接木扩展 Ext JS 控件](http://www.ibm.com/developerworks/cn/web/1005_fanjing_extjs/)

扩展 Ext 组件
扩展 (extension) 在 Ext中就是指衍生的子类。假设我们已经有一个附有一些方法的基类，现在欲加入新方法。我们可以利用框架的继承特性和 JavaScript 创建新类的语言特性组合新的一个类。
Ext 提供了这样的一个实用函数 Ext.extend 在 Ext 框架中实现类继承的机制。这赋予了扩展任何 JavaScript 基类的能力，而无须对类自身进行代码的修改，扩展 Ext 组件这是个较理想的方法。
要从一个现有的类创建出一个新类，首先要通过一个函数声明新类的构造器，然后调用新类属性所共享的扩展方法。这些共享的属性通常是方法，但是如果要在实例之间共享数据，应该也一同声明。
JavaScript 并没有提供一个自动的调用父类构造器的机制，所以必须通过属性 superclass 在构造器中显式调用父类。第一个参数总是 this，以保证构造器工作在调用函数的作用域。

## EXTJS 事件机制的探究

- [EXTJS 事件机制的探究](http://zhangxing119.iteye.com/blog/1808077)

## javascript Arguments对象——函数的实际参数

- [javascript Arguments对象——函数的实际参数](http://www.xiaoxiaozi.com/2009/06/10/827/)

## javascript call & apply

- [关于JavaScript中apply与call的用法意义及区别](http://www.cnitblog.com/yemoo/archive/2007/11/30/37070.html)

call 方法
调用一个对象的一个方法，以另一个对象替换当前对象。

call([thisObj[,arg1[, arg2[,   [,.argN]]]]])

参数
thisObj
可选项。将被用作当前对象的对象。

arg1, arg2,  , argN
可选项。将被传递方法参数序列。

>call 方法可以用来代替另一个对象调用一个方法。call 方法可将一个函数的对象上下文从初始的上下文改变为由 thisObj 指定的新对象。
如果没有提供 thisObj 参数，那么 Global 对象被用作 thisObj。
说明白一点其实就是更改对象的内部指针，即改变对象的this指向的内容。这在面向对象的js编程过程中有时是很有用的。

>call函数和apply方法的第一个参数都是要传入给当前对象的对象，及函数内部的this。后面的参数都是传递给当前对象的参数。

>对于apply和call两者在作用上是相同的，但两者在参数上有区别的。
对于第一个参数意义都一样，但对第二个参数：
apply传入的是一个参数数组，也就是将多个参数组合成为一个数组传入，而call则作为call的参数传入（从第二个参数开始）。
如 func.call(func1,var1,var2,var3)对应的apply写法为：func.apply(func1,[var1,var2,var3])

>同时使用apply的好处是可以直接将当前函数的arguments对象作为apply的第二个参数传入

## Ext中Grid得到选择行数据的方法总结

- [Ext中Grid得到选择行数据的方法总结](http://blog.csdn.net/ljleiwf/article/details/5733792)

(1)grid.getStore().getRange(0,store.getCount());    //得到grid所有的行 
 
(2)grid.getSelectionModel().getSelections();        //得到选择所有行    
注：如果不声明var sm = new Ext.grid.CheckboxSelectionModel();则会报此句没有该对象或属性
Var selectRows = grid.getSelectionModel().getSelections();
selectRows[0].get(“gird中某列的dataIndex属性值”)        //取选中行记录的某列的值
 
(3)grid.selModel.selections.items;              //得到选择所有行
 
(4)grid.getSelectionModel().getSelected();      //得到选择行的第一行
 
 
单击gird中某一行时取得该行的数据
proLevelGrid.on('rowclick', function(proLevelGrid,rowIndex,event){
       var record = proLevelGrid.getStore().getAt(rowIndex);
    addProductLevel_form.getForm().loadRecord(record);
    alert(record.get('id'));
});

//取多选记录方法 用逗号分开  后台处理

 var rows=this.getSelectionModel().getSelections(); //获取所有选中行， 
      var str = '';
   for(var i=0;i <rows.length;i++){ 
    str = str + rows[i].get('id') + ','; 
   } 
   alert(str);

getSelectedModel : function() {
  return this.getSelectionModel();
 }

## Ext 表单元素值

1. textfield 
	getValue();

2. combobox

>hiddenName : String 
如果指定，将自动创建一个表单隐藏域来存储输入项的值 (默认值为底层DOM元素的名称)。 如...
如果指定，将自动创建一个表单隐藏域来存储输入项的值 (默认值为底层DOM元素的名称)。 如果想要在表单提交时自动提交combo的值，该配置项是必须的。 注意：如果没有指定hiddenId，隐藏域的id默认和这个名称相同。 combo的id和隐藏域的id应该不同， 因为两个DOM节点不应该共用同一个id，所以，如果combo和隐藏域的名称相同时，你必须指定一个唯一的hiddenId。（译者注：请特别注意这一个配置项，一般写脚本时习惯指定combo的id和hiddenName，根据这里的说明可以知道 id和hiddenName是不能相同的，否则自动创建出来的底层DOM元素就使用了同一个id，这样的话下拉选择框就渲染不出来了。当你发现你的下拉选择框出现渲染不正常时，可以先检查是不是id和hiddenName设置成一样的了。更详细的截图和描述参见这里：ComboBox的恶心显示问题 ） 

-[EXTJS /取ComboBox里的文本displayField值和实际valueField值](http://blog.csdn.net/kangkai2003/article/details/5611446)

使用ComboBox时，它有一个hiddenName的属性，
专门用于提交 ComboBox中valueField域中的值，（如果不配置hiddenName属性，就会把displayField的值传过去）
例如：
一个ComboBox的Id为IdValue，
hiddenName属性的值为hiddenValue，
那么，使用Ext.get('IdValue').dom.value方法获取的是ComboBox中选中项的文本displayField值，
而使用 Ext.get('hiddenValue').dom.value获取的才是ComboBox中需要提交的valueField的值。

3. radiogroup

new Ext.form.RadioGroup({
	name:'selectsex',
	id:'selectsex',
	fieldLabel:'select',
	hideLabel:true,
	columns:2,
	vertical:false,
	items:[{
	 boxLabel:'男',inputValue:'1',name:'sex',checked:true
	 },{
	 boxLabel:'女',inputValue:'0',name:'sex'
	}]
})

获取RadioGroup的值

var sex=Ext.getCmp('selectsex');
sex.eachItem(function(item){
    if(item.checked===true){
        alert(item.inputValue);
    }
});

// 我测试的结果
if(obj.xtype === 'checkboxgroup' || obj.xtype === 'radiogroup') {
	var group = Ext.getCmp(obj.id);
	console.log(group);
	Ext.each(group.items.items, function(item){
	    if(item.checked===true){
	    	gstr += item.inputValue;
	    }
	});
	alert(gstr);
}


##  Ext.getCmp() 和Ext.get()区别

- [Ext.getCmp() 和Ext.get()区别](http://supercharles888.blog.51cto.com/609344/1184594)

对于Ext.get()，它返回的是Ext.dom.Element对象
Ext.get = function(el){ 
   return Ext.dom.Element.get(el); 
} 
对于Ext.getCmp(),它返回的是Ext.component对象，它有xtype.
如下定义：
getCmp: function(id) { 
       return Ext.ComponentManager.get(id); 
}, 

## 原以为start值为页码的概念，实际为查询记录起始行的值

 采用Ext.PagingToolbar做分页控件时，一直没有达到效果，原以为start值为页码的概念，实际为查询记录起始行的值，费了好长时间！

参考ext API如下：

Ext.PagingToolbar is a specialized toolbar that is bound to a Ext.data.Store and provides automatic paging control. This Component loads blocks of data into the store by passing paramNames used for paging criteria.

PagingToolbar is typically used as one of the Grid's toolbars。（依据Ext.store的paramNames进行分页）

Ext.store.paramNames属性说明如下：

paramNames : Object

An object containing properties which specify the names of the paging and sorting parameters passed to remote servers...
An object containing properties which specify the names of the paging and sorting parameters passed to remote servers when loading blocks of data. By default, this object takes the following form:

{    start : 'start',  // 注意是记录开始行数The parameter name which specifies the start row    limit : 'limit',  // The parameter name which specifies number of rows to return    sort : 'sort',    // The parameter name which specifies the column to sort on    dir : 'dir'       // The parameter name which specifies the sort direction}
The server must produce the requested data block upon receipt of these parameter names. If different parameter names are required, this property can be overriden using a configuration property.

A PagingToolbar bound to this Store uses this property to determine the parameter names to use in its requests.

## Ext.Window 最大化 maximized :true,

## Ext JS FormPanel 提交数据总结

- [Ext JS FormPanel 提交数据总结....](http://witcheryne.iteye.com/blog/335577)
- [extjs表单FormPanel提交数据和加载数据](http://liuna718-163-com.iteye.com/blog/805522)
- [ext 上传文件表单类型获取不对，前台设置表单属性为：fileUpload:true](http://bbs.csdn.net/topics/320178205)
- [FormPanel的fileUpload选项引发的返回值解析问题](http://jlcon.iteye.com/blog/905284)

>result : Object 
解码好的响应对象，包含一个布尔型的success参数和其他详细的操作说明参数。 

>如果FormPanel的fileUpload属性为ture即上传表单类型，Window提交后返回的JSON数据会当作document类型而非JSON类型解析，会引发脚本错误。解决方法：设置返回类型问text/html


## createChild( Object config, [HTMLElement insertBefore], [Boolean returnDom] ) : Ext.Element 
创建传递进来的DomHelper配置，并将其添加到当前元素后面，或者可以选择将 其插入到所传递的子元素的前面。
创建传递进来的DomHelper配置，并将其添加到当前元素后面，或者可以选择将 其插入到所传递的子元素的前面。 
参数:

config : Object 
DomHelper元素配置对象。如果没有指定tag (例如： {tag:'input'})， 那么将用指定的属性自动创建一个div。 
insertBefore : HTMLElement 
(可选) 当前元素的一个子元素 
returnDom : Boolean 
(可选) 设置为true将返回dom节点而不是创建一个 Element
返回值:
 
Ext.Element 
新的子元素 

## Ext.Element 

- [Ext.Element](http://docs.sencha.com/core/manual/content/element.html)

DomHelper configs

In the examples above, perhaps you notice the following:
.insertFirst({
	tag: 'p',
	html: 'Hi I am the new first child'
});
You may have wondered what the 1st argument to insertFirst is. This is a DomHelper config which represents the markup to be created. DomHelper configs support many properties for specifying child nodes, such as html fragments and DomNode attributes (css classes, url, src, id, etc). Here are some of the API's available on Ext.Element that allow you to interact directly with Ext.DomHelper:

createChild
Creates the passed DomHelper config and appends it to this element or optionally inserts it before the passed child element.
var el = Ext.get('elId');
var dhConfig = {
	tag: 'p',
	cls: 'myCls',
	html: 'Hi I have replaced elId'
};

// creates a new node and appends it to 'elId'.
el.createChild(dhConfig); 
// creates a new node and inserts before el's first child.
el.createChild(dhConfig, el.first());
wrap
Wraps this element with a newly created element
Ext.fly('elId').wrap(); // wraps elId with a div
		
// wraps elId with the newly create element
Ext.fly('elId').wrap({
	tag: 'p',
	cls: 'myCls',		
	html: 'Hi I have replaced elId'
});


## jar包中有中文名

java.lang.IllegalArgumentException  
    at java.util.zip.ZipInputStream.getUTF8String(ZipInputStream.java:284)  
    at java.util.zip.ZipInputStream.readLOC(ZipInputStream.java:237)  
    at java.util.zip.ZipInputStream.getNextEntry(ZipInputStream.java:73)  


    看到异常信息中的 getUTF8String 函数，应该是与字符编码方式有关，会不会是中文字符导致的呢，我看了一个jar包中有个说明文件的文件名中有中文字符，我把中文字符删除，再测试，异常不再出现！！


## oracle

关于左连接、右连接、外接连总结
在9i以前可以这么写:
左联：
select a.id,a.name,b.address from a,b 
where a.id=b.id(+)

右联:
select a.id,a.name,b.address from a,b 
where a.id(+)=b.id

外联
SELECT a.id,a.name,b.address
FROM a,b
WHERE a.id = b.id(+)
UNION
SELECT b.id,'' name,b.address
FROM b
WHERE NOT EXISTS (
SELECT * FROM a
WHERE a.id = b.id);

在9i以上，已经开始支持`SQL99标准`，所以，以上语句可以写成：
默认内部联结：
select a.id,a.name,b.address,c.subject
from (a inner join b on a.id=b.id) 
inner join c on b.name = c.name
where other_clause
左联
select a.id,a.name,b.address
from a left outer join b on a.id=b.id 
where other_clause
右联
select a.id,a.name,b.address
from a right outer join b on a.id=b.id 
where other_clause
外联
select a.id,a.name,b.address
from a full outer join b on a.id=b.id 
where other_clause
or
select a.id,a.name,b.address
from a full outer join b using (id)
where other_clause


ORACLE中左联（右联，内联，外联）语句如何写？

左联：

     select a.*,b* from A1,A2 b where a.id(+)=b.id

右联：
     select a.*,b* from A1,A2 b where a.id=＋b.id

     注意：右联时不能加括弧。


## Ext ajax GBK乱码：

Ext.onReady(function(){   
	//编码方式 这个也不行！！！
	Ext.lib.Ajax.defaultPostHeader += '; charset=GBK';    
})

- [EXT2.0的FORM乱码问题](http://www.cnitblog.com/hopesfish/archive/2008/07/15/46745.aspx)


## Ext.Window中iframe的相关操作 

html:"<iframe id='openwin' src='one.jsp' scrolling='auto' style='width:100%;height:100%;margin:0;padding:0'></iframe>",  

ext window中的iframe如何操作父窗口(关闭窗口win)
var win = parent.Ext.getCmp('openwin');win.close();

或者
var win = top.Ext.getCmp('openwin');win.close();