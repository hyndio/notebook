# struts2与springMVC对比

来源：
- [struts2 与 Spring MVC比较](http://www.zhenhua.org/article.asp?id=700)

struts2框架是类级别的拦截，每次来了请求就创建一个Action，然后调用setter getter方法把request中的数据注入 
struts2实际上是通过setter getter方法与request打交道的 
struts2中，一个Action对象对应一个request上下文 

spring3 mvc不同，spring3mvc是方法级别的拦截，拦截到方法后根据参数上的注解，把request数据注入进去 
在spring3mvc中，一个方法对应一个request上下文 

好了 我们来整理一下 
struts2是类级别的拦截， 一个类对应一个request上下文， 
springmvc是方法级别的拦截，一个方法对应一个request上下文，而方法同时又跟一个url对应 
所以说从架构本身上 spring3 mvc就容易实现restful url 
而struts2的架构实现起来要费劲 
因为struts2 action的一个方法可以对应一个url 
而其类属性却被所有方法共享，这也就无法用注解或其他方式标识其所属方法了 

=================================== 
spring3mvc的方法之间基本上独立的，独享request response数据 
请求数据通过参数获取，处理结果通过ModelMap交回给框架 
方法之间不共享变量 

而struts2搞的就比较乱，虽然方法之间也是独立的，但其所有Action变量是共享的 
这不会影响程序运行，却给我们编码 读程序时带来麻烦