# spring web service 2.1.3

## 基本概念

- WSDL 指网络服务描述语言 (Web Services Description Language)。一个WSDL文档是一个服务的描述，它描述了：服务名，服务地址，服务能用什么协议访问，服务有哪些方法，每个方法有几部分参数，每个参数的类型。

- [WSDL : 描述你的Web服务](http://www.ibm.com/developerworks/cn/webservices/ws-wsdl/index.html)

**WSDL 文档在Web服务的定义中使用下列元素：**

- Types - 数据类型定义的容器，它使用某种类型系统(一般地使用XML Schema中的类型系统)。
- Message - 通信消息的数据结构的抽象类型化定义。使用Types所定义的类型来定义整个消息的数据结构。
- Operation - 对服务中所支持的操作的抽象描述，一般单个Operation描述了一个访问入口的请求/响应消息对。
- PortType - 对于某个访问入口点类型所支持的操作的抽象集合，这些操作可以由一个或多个服务访问点来支持。
- Binding - 特定端口类型的具体协议和数据格式规范的绑定。
- Port - 定义为协议/数据格式绑定与具体Web访问地址组合的单个服务访问点。
- Service - 相关服务访问点的集合。

- [关于 Web Service 的一些总结，一些理解](http://www.iteye.com/topic/410195)

关于 Web Service 的一些总结，一些理解

1，什么是 Web Service ?
   Web Service 就是一个网络组件（一个可以通过网络访问的程序）。
   它有一个或多个端口（Port），这些端口用于接收客户端的请求，并返回响应
   请求和响应的 都是一种基于XML的消息。
   不过这种消息遵循特定的格式（SOAP ）。

2，怎样调用 Web Service？
   可能这样说不太准确，应该是“怎样调用Web Service中定义的操作 ”
   每个Web Service 都有一个描述文件（WSDL ），
   它描述 一个 Web Service 的如下方面：
   （1）服务的端口（接收SOAP消息的端口）
   （2）服务提供的操作
   （3）操作的输入输出格式的定义（通过XMLSchema 定义输入输出格式）
    有了Web Service 的描述文件（WSDL ），我们就知道怎样调用这个Web Service 中定义的操作了。
   （1）通过服务提供的操作找到你想调用的操作
   （2）找到这个操作的输入格式的定义（XMLSchema ），按照这种输入格式构造一个SOAP消息
   （3）将这个SOAP消息发送到服务的指定端口
   （4）准备接收一个从Web Service服务器返回的 SOAP 响应吧 !

3，Web Service服务器
   一个Web Service服务器，本质上和一个Web服务器是相同的。
   它主要做下面这些事： 

--> 监听网络端口（监听服务端口） 
--> 接收客户端请求（接收SOAP请求） 
--> 解析客户端请求（解析SOAP消息，将SOAP消息转换为数据对象）
--> 调用业务逻辑 （调用Web Service实现类的特定操作，参数是由SOAP消息  
      转换而来的数据对象）
--> 生成响应 （将返回值转换为SOAP消息）
--> 返回响应 （返回SOAP响应）
 
4，Web Service客户端
   一个Web Service客户端，顾名思义是和一个Web Service服务器进行交互。
  下面是一个Web Service客户端调用Web Service的基本过程。

--> 构造SOAP请求消息（将本地数据对象转换为SOAP消息） 
--> 发送SOAP消息到Web Service服务器的指定端口
--> 接收SOAP响应消息  
--> 将SOAP响应消息转换为本地数据对象

## TargetNameSpace和DefaultNameSpace之间的区别

根据我的理解TargetNameSpace只在定义XML SCHAME的时候才有用，它的主要作用是标明Schame定义的元素的命名空间，而DefaultNameSpace则只是标明在定义这个Schame中用的默认命名空间比如：http://www.w3.org/2001/XMLSchema就是在定义一个XSD的时候的默认命名空间，而定义出来的Schame的命名空间则是根据需要指定。


## 打印出请求与响应数据

- [Spring Web-Service unmarshalling not working](http://stackoverflow.com/questions/7790541/spring-web-service-unmarshalling-not-working)

Just to make sure the soap request is good, Can you add logging interceptor and print the actual request that is coming from the client accessing web service, Add this snippet to your context file

  <sws:interceptors>
    <bean class="org.springframework.ws.soap.server.endpoint.interceptor.SoapEnvelopeLoggingInterceptor">
        <property name="logRequest" value="true"></property>
        <property name="logResponse" value="true"></property>
    </bean>
</sws:interceptors>

## <schema> 元素

<schema> 元素可包含属性。一个 schema 声明往往看上去类似这样：
<?xml version="1.0"?>
 
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema"
targetNamespace="http://www.w3school.com.cn"
xmlns="http://www.w3school.com.cn"
elementFormDefault="qualified">

...
...
</xs:schema>
代码解释：
下面的片断：
`xmlns:xs="http://www.w3.org/2001/XMLSchema"`
显示 schema 中用到的元素和数据类型来自命名空间 `http://www.w3.org/2001/XMLSchema`。同时它还规定了来自命名空间 `http://www.w3.org/2001/XMLSchema`的元素和数据类型应该使用前缀 `xs：`
这个片断：
`targetNamespace="http://www.w3school.com.cn"` 
显示被此 schema 定义的元素 (note, to, from, heading, body) 来自命名空间： `http://www.w3school.com.cn`。
这个片断：
`xmlns="http://www.w3school.com.cn"` 
指出默认的命名空间是 `http://www.w3school.com.cn`。
这个片断：
`elementFormDefault="qualified"` 
指出任何 XML 实例文档所使用的且在此 schema 中声明过的元素必须被命名空间限定。


## [转载]SOAP风格中 RPC与Document的区别

-[SOAP风格中 RPC与Document的区别](http://blog.csdn.net/tomholmes7/article/details/2773738)


## 步骤

1. xml(Message)
	- 确定需要请求和应答的xml实例
	- 参考dwd_comp_task_deal.xml

2. xsd(Data Cantract)
	- 尽量使用工具产生

3. Service contract
	- A service contract is generally expressed as a WSDL file.
	
4. service interface
5. endpoit


