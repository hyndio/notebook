# Struts2 Note

## json-default extends="struts-default"

<struts>
    <package name="json-default" extends="struts-default">
        <result-types>
            <result-type name="json" class="com.googlecode.jsonplugin.JSONResult"/>
        </result-types>
        <interceptors>
            <interceptor name="json" class="com.googlecode.jsonplugin.JSONInterceptor"/>
        </interceptors>
    </package>
</struts>

## 关于包继承

Packages can extend other packages. If all the other packages in your application extend "default", then they will all inherit the new default interceptor.

## struts.xml配置详解

-[struts.xml配置详解](http://www.cnblogs.com/fmricky/archive/2010/05/20/1740479.html)

## 开启调试模式：
  <constant name="struts.devMode" value="true"></constant>

## Struts中管理Struts2属性的3中管理方式和Struts2配置文件加载顺序  

- [Struts中管理Struts2属性的3中管理方式和Struts2配置文件加载顺序](http://blog.163.com/why_it/blog/static/1317865112010321332022/)

**struts2中管理struts2属性的3中管理方式：**
1.通过struts.properties文件来配置 
2.通过strutsxml 文件中配置constant元素来配置 
3.在web.xml中配置 

**struts2配置文件加载顺序：**

1.struts-default.xml :在struts-core.jar 
2.struts-plugin.xml :在struts-Xxx.jar 
3.struts.xml 
4.struts.properties 
5.web.xml 

struts2处理结果集： 
1.转向JSP 
2.转向Freemarker 
3.转向其他的Action，形成Action链！ 

struts.xml中redirect 和redirect-action区别
redirect：用于生一个对具体资源的请求 
redirect-action：通常用于生成对另一个action的请求 
两者结果类型都会丢失请求参数，请求属性，和前一个action的处理结果集！

## package里元素必须按照一定的顺序排列。

这个顺序就是:
	result-types
	interceptors
	default-interceptor-ref
	default-action-ref
	default-class-ref
	global-results
	global-exception-mappings
	action*(就是所有的action放到最后)

## struts.xml中的相对路径与绝对路径

<!-- 相对路径 : result中不能写"/" -->
<package name="aerrconf" namespace="/aerrconf" extends="base-struts-default">
	
	<!-- 会不会覆盖默认设置 -->
	<global-results>
		<!-- 所有错误转向页面 -->
		<result name="error2">unnormal.jsp</result>
	</global-results>

	<!-- /aerrconf/normal.action?flag=1 -->
	<action name="normal" class="">
		<result name="success">normal.jsp</result>
	</action>
	<!-- /aerrconf/errSql.action -->
	<action name="errSql" class="" method="sql">
		<result name="success">normal.jsp</result>
	</action>
</package>

<!-- 绝对路径：result中以"/"开头 -->
<action name="relInvestigationAction" class="">
	<result name="INIT_SUCCESS">/release/investigation/investigation.jsp</result>
	<result name="SAVE_SUCCESS" type="chain"></result>
	<result name="input">/release/investigation/investigation.jsp</result>
</action>	

## 如果找不到相关名字action，不是404， 而是报错

10050571 ERROR [http-8080-10] org.apache.struts2.dispatcher.Dispatcher     - Could not find action or result
There is no Action mapped for namespace /aerrconf and action name normalkk. - [unknown location]

## 由Spring管理的Struts2的Action的单实例问题

- [由Spring管理的Struts2的Action的单实例问题](http://www.iteye.com/topic/356746)

背景:

1) Struts2 会对每一个请求,产生一个Action的实例来处理.
2) Spring的Ioc容器管理的bean默认是单实例的.

当Struts2与Spring整合后,由spring来管理Struts2的Action,会遇到什么问题 ?

Struts2与Spring整合后, 由spring来管理Struts2的Action,   bean默认是单实例有情况下,会有如下问题:
1) Action是单例,其中的FieldError,actionerror中的错误信息 会累加, 即使再次输入了正确的信息,也过不了验证.
2) Struts2的Action是有状态的,他有自己的成员属性, 所以在多线程下,会有问题.
