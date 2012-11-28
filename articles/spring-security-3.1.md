# 关键点

## UserDetailsService

	UserDetails loadUserByUsername(String username) throws UsernameNotFoundException;

	你可以从Authentication 对象中获得安全主体UserDetails.
	返回的UserDetails是一个接口，它提供了获得保证非空的认证信息，比如用户名，密码，授予的权限和用户账号是可用还是禁用。

## GrantedAuthority

	除了主体，另一个Authentication提供的重要方法是getAuthorities()。这个方法提供了GrantedAuthority对象数组。毫无疑问，GrantedAuthority是赋予到主体的权限。这些权限通常使用角色表示，比如ROLE_ADMINISTRATOR或ROLE_HR_SUPERVISOR。

	Spring Security的其他部分用来拦截这些权限，期望他们被表现出现。GrantedAuthority对象通常使用 UserDetailsService读取的。

	通常情况下，GrantedAuthority对象是应用程序范围下的授权。它们不会特意分配给一个特定的领域对象。

## 小结

简单回顾一下，Spring Security 主要是由一下几部分组成的：

	- SecurityContextHolder，提供几种访问SecurityContext 的方式。
	- SecurityContext，保存Authentication 信息，和请求对应的安全信息。
	- HttpSessionContextIntegrationFilter，为了在不同请求使用，把SecurityContext 保存到HttpSession里。
	- Authentication，展示Spring Security 特定的主体。
	- GrantedAuthority，反应在应用程序范围你，赋予主体的权限。
	- UserDetails，通过你的应用DAO，提供必要的信息，构建Authentication对象。
	- UserDetailsService，创建一个UserDetails，传递一个String类型的用户名（或者证书ID或其他）。
