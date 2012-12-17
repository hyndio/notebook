# POJO & JavaBeans & EJB

===================================================
来源：[Pojo和JavaBean的区别](http://xy117510.blog.163.com/blog/static/649324292009101631427398/)

参考
http://en.wikipedia.org/wiki/POJO
http://en.wikipedia.org/wiki/JavaBean

- POJO(Plain Old Java Object)这个名字用来强调它是一个普通java对象，而不是一个特殊的对象。
2005年11月时，“POJO”主要用来指代那些没用遵从特定的Java对象模型，约定或框架如EJB的Java对象.
理想地讲，一个POJO是一个不受任何限制的Java对象（除了Java语言规范）。例如一个POJO不应该是
	- 扩展预定的类，如     public class Foo extends javax.servlet.http.HttpServlet { ...
	- 实现预定的接口，如   public class Bar implements javax.ejb.EntityBean { ...
	- 包含预定的标注，如   @javax.ejb.Entity public class Baz{ ...
然后，因为技术上的困难及其他原因，许多兼容POJO风格的软件产品或框架事实上仍然要求使用预定的标注，譬如用于更方便的持久化。

- JavaBean 是一种JAVA语言写成的可重用组件。它的方法命名，构造及行为必须符合特定的约定：
	- 这个类必须有一个公共的缺省构造函数。
	- 这个类的属性使用getter和setter来访问，其他方法遵从标准命名规范。
	- 这个类应是可序列化的。 
因为这些要求主要是靠约定而不是靠实现接口，所以许多开发者把JavaBean看作遵从特定命名约定的POJO。

简而言之，当一个Pojo可序列化，有一个无参的构造函数，使用getter和setter方法来访问属性时，他就是一个JavaBean。

=====================================================
来源：[JavaBeans、EJB和POJO详解](http://developer.51cto.com/art/200906/130814.htm)

=====================================================
来源：[Javabean，POJO，PO，VO，DTO](http://hi.baidu.com/wolfdyp/item/2009dc0c58b6c9cb2e4c6bf9)
