# spring security 3.2.0.M1 集成

##　依赖jar

 - spring-security-core.jar
 	- org.springframework.security.core
	- org.springframework.security.access
	- org.springframework.security.authentication
	- org.springframework.security.provisioning

 - spring-security-web.jar
 - spring-security-config.jar
 - spring-security-taglibs.jar

**pom.xml**

	<spring-security-version>3.2.0.M1</spring-security-version>

	<dependency>
		<groupId>org.springframework.security</groupId>
		<artifactId>spring-security-core</artifactId>
		<version>${spring-security-version}</version>
	</dependency>
	<dependency>
		<groupId>org.springframework.security</groupId>
		<artifactId>spring-security-web</artifactId>
		<version>${spring-security-version}</version>
	</dependency>
	<dependency>
		<groupId>org.springframework.security</groupId>
		<artifactId>spring-security-config</artifactId>
		<version>${spring-security-version}</version>
	</dependency>

## Design of the Namespace

- Web/HTTP Security - the most complex part. Sets up the filters and related service beans used to apply the framework authentication mechanisms, to secure URLs, render login and error pages and much more.

- Business Object (Method) Security - options for securing the service layer.

- AuthenticationManager - handles authentication requests from other parts of the framework.

- AccessDecisionManager - provides access decisions for web and method security. A default one will be registered, but you can also choose to use a custom one, declared using normal Spring bean syntax.

- AuthenticationProviders - mechanisms against which the authentication manager authenticates users. The namespace provides supports for several standard options and also a means of adding custom beans declared using a traditional syntax.

- UserDetailsService - closely related to authentication providers, but often also required by other beans.

## Using other Authentication Providers 使用其他的验证提供者

## Adding a Password Encoder 密码加密

## SecurityContext 和 Authentication 对象

- [使用 Spring Security 保护 Web 应用的安全](http://www.ibm.com/developerworks/cn/java/j-lo-springsecurity/)

下面开始讨论几个 Spring Security 里面的核心对象。org.springframework.security.core.context.SecurityContext接口表示的是当前应用的安全上下文。通过此接口可以获取和设置当前的认证对象。org.springframework.security.core.Authentication接口用来表示此认证对象。通过认证对象的方法可以判断当前用户是否已经通过认证，以及获取当前认证用户的相关信息，包括用户名、密码和权限等。要使用此认证对象，首先需要获取到 SecurityContext 对象。通过 org.springframework.security.core.context.SecurityContextHolder 类提供的静态方法 getContext() 就可以获取。再通过 SecurityContext对象的 getAuthentication()就可以得到认证对象。通过认证对象的 getPrincipal() 方法就可以获得当前的认证主体，通常是 UserDetails 接口的实现。联系到上一节介绍的 UserDetailsService，典型的认证过程就是当用户输入了用户名和密码之后，UserDetailsService通过用户名找到对应的 UserDetails 对象，接着比较密码是否匹配。如果不匹配，则返回出错信息；如果匹配的话，说明用户认证成功，就创建一个实现了 Authentication接口的对象，如 org.springframework.security. authentication.UsernamePasswordAuthenticationToken 类的对象。再通过 SecurityContext的 setAuthentication() 方法来设置此认证对象。

## 登录、登出问题

默认URL：

	// 登录、登出的URL
    private final static String URL_LOGIN = "/j_spring_security_check";
    private final static String URL_LOGOUT = "/j_spring_security_logout";

	<bean id="authenticationFilter" class=
	"org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter">
	  <property name="authenticationManager" ref="authenticationManager"/>
	  <property name="filterProcessesUrl" value="/j_spring_security_check"/>
	</bean>


- [SpringSecurity使用记录（五）-- 配置](http://www.blogjava.net/taochen1984/articles/310072.html)

	Alias	Filter Class	Namespace Element or Attribute
	CHANNEL_FILTER	ChannelProcessingFilter	http/intercept-url@requires-channel
	CONCURRENT_SESSION_FILTER	ConcurrentSessionFilter	session-management/concurrency-control
	SECURITY_CONTEXT_FILTER	SecurityContextPersistenceFilter	http
	LOGOUT_FILTER	LogoutFilter	http/logout
	X509_FILTER	X509AuthenticationFilter	http/x509
	PRE_AUTH_FILTER	AstractPreAuthenticatedProcessingFilter Subclasses	N/A
	CAS_FILTER	CasAuthenticationFilter	N/A
	FORM_LOGIN_FILTER	UsernamePasswordAuthenticationFilter	http/form-login
	BASIC_AUTH_FILTER	BasicAuthenticationFilter	http/http-basic
	SERVLET_API_SUPPORT_FILTER	SecurityContextHolderAwareFilter	http/@servlet-api-provision
	REMEMBER_ME_FILTER	RememberMeAuthenticationFilter	http/remember-me
	ANONYMOUS_FILTER	AnonymousAuthenticationFilter	http/anonymous
	SESSION_MANAGEMENT_FILTER	SessionManagementFilter	session-management
	EXCEPTION_TRANSLATION_FILTER	ExceptionTranslationFilter	http
	FILTER_SECURITY_INTERCEPTOR	FilterSecurityInterceptor	http
	SWITCH_USER_FILTER	SwitchUserFilter	N/A

No AuthenticationEntryPoint could be established. Please make sure you have a login mechanism 
 configured through the namespace (such as form-login) or specify a custom AuthenticationEntryPoint 
 with the 'entry-point-ref' attribute


- [spring-security 3.0.X, 让ajax login和普通login共存](http://my.oschina.net/jilujia/blog/66795)

## Spring Security3异常处理

 - [《Spring Security3》第六章第四部分翻译（异常处理）](http://lengyun3566.iteye.com/blog/1199708)

## ExceptionTranslationFilter

-[Error in overriding EXCEPTION_TRANSLATION_FILTER](http://forum.springsource.org/showthread.php?92136-Error-in-overriding-EXCEPTION_TRANSLATION_FILTER)

>You can't replace the ExceptionTranslationFilter when using the namespace. You can inject a custom AuthenticationEntryPoint and in 3.0, you can inject an AccesDeniedHandler. Alternatively map your access-denied logic to a controller and handle it here.

## Set<GrantedAuthority>.isEmpty();

	// the authorities granted to the user
    private Set<GrantedAuthority> authorities;

这种情况下，应该抛出一个UsernameNotFoundException. 但这样的话，用户就登录不进系统了。

## 12.3.1 Querying the SessionRegistry for currently authenticated users and their sessions

Setting up concurrency-control, either through the namespace or using plain beans has the useful side effect of providing you with a reference to the `SessionRegistry` which you can use directly within your application, so even if you don't want to restrict the number of sessions a user may have, it may be worth setting up the infrastructure anyway. You can set the maximumSession property to -1 to allow unlimited sessions. If you're using the namespace, you can set an alias for the internally-created SessionRegistry using the `session-registry-alias` attribute, providing a reference which you can inject into your own beans.

The `getAllPrincipals()` method supplies you with a list of the currently authenticated users. You can list a user's sessions by calling the `getAllSessions(Object principal, boolean includeExpiredSessions)` method, which returns a list of `SessionInformation` objects. You can also expire a user's session by calling `expireNow()` on a `SessionInformation` instance. When the user returns to the application, they will be prevented from proceeding. You may find these methods useful in an administration application, for example. Have a look at the Javadoc for more information.

## spring security 3中关于ajax的处理

- [spring security 3中关于ajax的处理](http://jackyrong.iteye.com/blog/1770629)

## 加密org.springframework.security.authentication.encoding.Md5PasswordEncoder 

http://www.blogjava.net/SpartaYew/archive/2011/06/15/350630.html
http://hi.baidu.com/quest2run/item/13a97b93c36769b4cd80e5aa 
org.springframework.security.authentication.encoding.Md5PasswordEncoder 


## Spring Security 3.1 自定义 authentication provider

认证管理器。其本身并没有认证功能，而是委托Provider进行用户认证。 
认证管理器会逐个调用认证提供类，直到认证成功。 
（因此，认证提供类的顺序非常重要，常用的要放在最前面） 

-[Spring Security 3.1 自定义 authentication provider](http://www.xeclipse.com/?p=1359)