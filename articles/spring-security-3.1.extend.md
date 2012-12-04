# spring security 3.1 扩展

## 关键点

### UserDetailsService

	UserDetails loadUserByUsername(String username) throws UsernameNotFoundException;

	你可以从Authentication 对象中获得安全主体UserDetails.
	返回的UserDetails是一个接口，它提供了获得保证非空的认证信息，比如用户名，密码，授予的权限和用户账号是可用还是禁用。

### GrantedAuthority

	除了主体，另一个Authentication提供的重要方法是getAuthorities()。这个方法提供了GrantedAuthority对象数组。毫无疑问，GrantedAuthority是赋予到主体的权限。这些权限通常使用角色表示，比如ROLE_ADMINISTRATOR或ROLE_HR_SUPERVISOR。

	Spring Security的其他部分用来拦截这些权限，期望他们被表现出现。GrantedAuthority对象通常使用 UserDetailsService读取的。

	通常情况下，GrantedAuthority对象是应用程序范围下的授权。它们不会特意分配给一个特定的领域对象。

### 小结

简单回顾一下，Spring Security 主要是由一下几部分组成的：

	- SecurityContextHolder，提供几种访问SecurityContext 的方式。
	- SecurityContext，保存Authentication 信息，和请求对应的安全信息。
	- HttpSessionContextIntegrationFilter，为了在不同请求使用，把SecurityContext 保存到HttpSession里。
	- Authentication，展示Spring Security 特定的主体。
	- GrantedAuthority，反应在应用程序范围你，赋予主体的权限。
	- UserDetails，通过你的应用DAO，提供必要的信息，构建Authentication对象。
	- UserDetailsService，创建一个UserDetails，传递一个String类型的用户名（或者证书ID或其他）。

## 扩展

### 1. 自己义用户信息

	实现org.springframework.security.core.userdetails.UserDetails接口
	参考：org.springframework.security.core.userdetails.User

### 2. 获取用户信息及所拥有的权限：用户详细信息管理、数据源、用户缓存（通过数据库管理用户、角色、权限、资源）。

	实现org.springframework.security.core.userdetails.UserDetailsService接口
	参考：org.springframework.security.core.userdetails.jdbc.JdbcDaoImpl
		这里是个服务提供者模式：
		org.springframework.security.provisioning.UserDetailsManager接口
		org.springframework.security.provisioning.JdbcUserDetailsManager
		org.springframework.security.provisioning.InMemoryUserDetailsManager
		
	注意：AuthenticationManager是用来验证用户名、密码的。
		验证通过后，会返回一个完整的Authentication对象（包含GrantedAuthority），保存到SecurityContext中。
		参考：org.springframework.security.authentication.dao.DaoAuthenticationProvider

### 3. 实现一个自己定义过滤器：增加一个自定义的filter，放在FILTER_SECURITY_INTERCEPTOR之前， 实现用户、角色、权限、资源的数据库管理。

	一个自定义的filter，必须包含authenticationManager, accessDecisionManager, securityMetadataSource三个属性。

### 4. 获取数据库中所有的权限及对应的资源URL：资源源数据定义，将所有的资源和权限对应关系建立起来，即定义某一资源可以被哪些角色去访问。

	实现：org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource接口
	参考：org.springframework.security.web.access.intercept.DefaultFilterInvocationSecurityMetadataSource

### 5. 访问决策器，决定某个用户具有的权限，是否有足够的权限去访问某个资源

	实现：org.springframework.security.access.AccessDecisionManager
	参考：org.springframework.security.access.vote.AbstractAccessDecisionManager
	
	它有一个decide 方法，可以获得一个Authentication对象。
	展示主体的请求权限， 一个“secure object”和一个安全元数据属性队列， 为对象提供了（比如一个角色列表，为访问被授予的请求）。

### 整个程序执行的过程如下：

	1. 容器启动(MyInvocationSecurityMetadataSource：loadResourceDefine加载系统资源与权限列表)
	2. 用户发出请求
	3. 过滤器拦截(MyFilterSecurityInterceptor:doFilter)
	4. 取得请求资源所需权限(MyInvocationSecurityMetadataSource:getAttributes)
	5. 匹配用户拥有权限和请求权限(MyAccessDecisionManager:decide)，如果用户没有相应的权限，执行第6步，否则执行第7步
	6. 登录
	7. 验证并授权(MyUserDetailService:loadUserByUsername)
	8. 重复4, 5



