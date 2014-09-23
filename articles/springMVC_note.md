# spring-MVC-3.2

## jdk要求

- [关于spring启动加载的问题](http://www.oschina.net/question/99751_70578)

spring mvc 必须在1.6的版本上运行的

## 关于请求参数（传入的参数类）型

通过注解区分类型，如下：

- @RequestParam
- @PathVariable
- @RequestHeader
- @CookieValue
- @RequestBody
- javaBean，字段对应，直接封装

## @ModelAttribute

	Providing a link to data from the model with @ModelAttribute
	@ModelAttribute  has  two  usage  scenarios  in  controllers.  When  placed  on  a  method  parameter,
	@ModelAttribute is used to map a model attribute to the specific, annotated method parameter (see
	the populateSite() method below). This is how the controller gets a reference to the object holding
	the data entered in the form. In addition, the parameter can be declared as the specific type of the form
	backing object rather than as a generic java.lang.Object, thus increasing type safety.

	@ModelAttribute is also used at the method level to provide reference data for the model (see the
	getPetSites() method below). For this usage the method signature can contain the same types as
	documented above for the @RequestMapping annotation.

	Note: @ModelAttribute annotated methods will be executed before the chosen @RequestMapping
	annotated handler method. They effectively pre-populate the implicit model with specific attributes, often
	loaded from a database. Such an attribute can then already be accessed through @ModelAttribute
	annotated  handler  method  parameters  in  the  chosen  handler  method,  potentially  with  binding  and
	validation applied to it.

SpringMVC3中没有@ModelAndView这个注解，只有@ModelAttribute注解。
ModelAndView是SpringMVC中的一个重要概念。代表了Spring Web MVC中呈现页面时所使用Model与View，由于Java代码中一次只能返回一个参数，所以ModelAndView的作用封装这两个对象，以方便您一次返回Model与View这两个对象。
ModelAndView的addObject会向其Model中加入属性。

@ModelAttribute是SpringMVC的一个注解，具体作用如下：
1. 绑定请求参数到命令对象：放在功能处理方法的入参上时，用于将多个请求参数绑定到一个命令对象，从而简化绑定流程，而且自动暴露为模型数据用于视图页面展示时使用；
2. 暴露表单引用对象为模型数据：放在处理器的一般方法（非功能处理方法）上时，是为表单准备要展示的表单引用对象，如注册时需要选择的所在城市等，而且在执行功能处理方法（@RequestMapping注解的方法）之前，自动添加到模型对象中，用于视图页面展示时使用；
3. 暴露@RequestMapping方法返回值为模型数据：放在功能处理方法的返回值上时，是暴露功能处理方法的返回值为模型数据，用于视图页面展示时使用。

**参考：**

- [Spring3MVC 在JSP中使用@ModelAttribute](http://liukai.iteye.com/blog/973717)


## 表单核验

- [Spring验证的错误返回------BindingResult](http://hi.baidu.com/austincao/item/270303344c2811dd6c15e9f1)

## form tag

form tag 与 @ModelAttribute 配合使用。
可以做数据的双向绑定。

## spring mvc拦截器注册不了的问题

- 在spring-mvc.xml文件里配置
- [What could be causing RequestMappingHandlerMapping to not register correctly?](http://stackoverflow.com/questions/12114214/what-could-be-causing-requestmappinghandlermapping-to-not-register-correctly)

## spring mvc拦截器执行顺序

- [第五章 处理器拦截器详解——跟着开涛学SpringMVC](http://jinnianshilongnian.iteye.com/blog/1670856)
- [注解式控制器运行流程及处理器定义 第六章 注解式控制器详解——跟着开涛学SpringMVC](http://jinnianshilongnian.iteye.com/blog/1682510)

>- preHandle：预处理回调方法，实现处理器的预处理（如登录检查），第三个参数为响应的处理器（如我们上一章的Controller实现）；
     返回值：true表示继续流程（如调用下一个拦截器或处理器）；
             false表示流程中断（如登录检查失败），不会继续调用其他的拦截器或处理器，此时我们需要通过response来产生响应；
- postHandle：后处理回调方法，实现处理器的后处理（但在渲染视图之前），此时我们可以通过modelAndView（模型和视图对象）对模型数据进行处理或对视图进行处理，modelAndView也可能为null。
- afterCompletion：整个请求处理完毕回调方法，即在视图渲染完毕时回调，如性能监控中我们可以在此记录结束时间并输出消耗时间，还可以进行一些资源清理，类似于try-catch-finally中的finally，但仅调用处理器执行链中preHandle返回true的拦截器的afterCompletion。

- 正常：preHandle()-->controller-->postHandle()-->view渲染-->afterCompletion()
- 异常：preHandle()-->[if preHandle() return true, then controller-->]异常页面渲染-->afterCompletion()

## ServletContextListener使用详解

- [ServletContextListener使用详解](http://blog.csdn.net/zhaozheng7758/article/details/6103700)

## 异常处理机制

- [使用Spring MVC统一异常处理实战](http://cgs1999.iteye.com/blog/1547197)
- [SpringMVC 异常处理初探](http://exceptioneye.iteye.com/blog/1306150)
- [浅谈springMVC的拦截器、错误异常、数据绑定、属性编辑器](http://aokunsang.iteye.com/blog/1409505)
	
	说明：根据SimpleMappingExceptionResolver类的源码可知，它将错误日志放在了request的属性变量中，变量名为exception,类型为Exception，需要引入org.apache.log4j.Logger包，这样的话，log4j日志就会记录错误日志了。

- [三. spring mvc 异常统一处理](http://gaojiewyh.iteye.com/blog/1297746)
	
	**这篇可以！**

## IE的洁癖！！404, 500 

**1024b = 1KB = 512个中文汉字**

关于web.xml中配置404错误跳转页面 在ie不能显示自定义错误页面的问题
<error-page>
  <error-code>404</error-code>
  <location>/error_pages/404.html</location>
</error-page>
本来自己定义了一个错误页面，不过在ie中怎么也显示不出来，firefox一点问题都没有，几经查询才知道原来是ie自作聪明给换掉了，对错误页面的处理在ie来看页面大小小于1024b会被认为十分不友好，所以ie就将改页面给替换成自己的错误提示页面了，解决办法就是充实一下页面,让大小超过1024即可。

## 生产者、消费者限定

- [生产者、消费者限定 生产者、消费者限定](http://sishuok.com/forum/blogPost/list/6174.html)

## URLPath匹配原则

- [URLPath匹配原则](http://blog.csdn.net/li_jinjian2005/article/details/2915446)
- [详解Spring MVC的处理器映射HandlerMapping和拦截器HandlerInterceptor](http://blog.sina.com.cn/s/blog_6d3c1ec601014err.html)
- [RequestMappingHandlerMapping](http://blog.sina.com.cn/s/blog_5c65f95201016knv.html)
- [Reflectively getting list of Spring MVC controllers matching specific url](http://stackoverflow.com/questions/14025872/reflectively-getting-list-of-spring-mvc-controllers-matching-specific-url)

## 执行过程

- [Handler Mapping](http://www.jpalace.org/docs/tutorials/spring/mvc_8.html)
- [Spring MVC framework深入分析之三(上)--执行过程](http://blog.csdn.net/f9inux/article/details/477494)
- [SpringMVC源码剖析（一）- 从抽象和接口说起](http://m.oschina.net/blog/99039)**！！！！**
- [spring mvc](http://liyixing1.iteye.com/blog/1072665)

## Ant path 匹配原则

- [Ant path 匹配原则](http://www.blogjava.net/supercrsky/articles/293728.html)

路径匹配原则(Path Matching) Spring MVC中的路径匹配要比标准的web.xml要灵活的多。默认的策略实现了 org.springframework.util.AntPathMatcher，就像名字提示的那样，路径模式是使用了Apache Ant的样式路径，Apache Ant样式的路径有三种通配符匹配方法（在下面的表格中列出)
这些可以组合出很多种灵活的路径模式

Table Ant Wildcard Characters
Wildcard	Description	 
?	匹配任何单字符	 
*	匹配0或者任意数量的字符	 
**	匹配0或者更多的目录	 

Table Example Ant-Style Path Patterns

Path	Description	 
/app/*.x	匹配(Matches)所有在app路径下的.x文件	 
/app/p?ttern	匹配(Matches) /app/pattern 和 /app/pXttern,但是不包括/app/pttern	 
/**/example	匹配(Matches) /app/example, /app/foo/example, 和 /example	 
/app/**/dir/file.	匹配(Matches) /app/dir/file.jsp, /app/foo/dir/file.html,/app/foo/bar/dir/file.pdf, 和 /app/dir/file.java	 
/**/*.jsp	匹配(Matches)任何的.jsp 文件

## spring mvc 视图名

框架将截取请求路径中的最后一个 / 后面的内容，并去掉后缀名，剩下来的内容就是视图名。如请求路径为 /spring3/user/welcome，那么视图名是 welcome，/spring3/user/welcome.action 的视图名也是 welcome。

## 当前请求最匹配的pattern

-[spring3.2 带matrix变量的URL匹配问题](http://jinnianshilongnian.iteye.com/blog/1831408#comments)

有个可以拿到当前请求 最匹配的pattern， 应该能满足你的需求

	/** 
	 * 获得最佳的HandlerMapping映射内的匹配模式。 
	 *  
	 * @param request 
	 * @return 
	 */  
	public static String getBestMatchingPattern(HttpServletRequest request){  
	    String bestMatchingPattern = (String) request.getAttribute(HandlerMapping.BEST_MATCHING_PATTERN_ATTRIBUTE);  
	    return bestMatchingPattern;  
	}  