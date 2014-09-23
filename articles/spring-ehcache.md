# spring ehcache

- [ehcache](http://ehcache.org/)
- [ehcache-spring-annotations](https://code.google.com/p/ehcache-spring-annotations/)

## 配置情况：

**jar**

ehcache-spring-annotations-1.2.0
ehcache-core 2.6.2 

ApplicationContext.xml:
xmlns:ehcache="http://ehcache-spring-annotations.googlecode.com/svn/schema/ehcache-spring"
http://ehcache-spring-annotations.googlecode.com/svn/schema/ehcache-spring http://ehcache-spring-annotations.googlecode.com/svn/schema/ehcache-spring/ehcache-spring-1.2.xsd

**pom.xml**

<!-- ehcache spring annotations，不使用spring的实现 -->
<dependency>
	<groupId>com.googlecode.ehcache-spring-annotations</groupId>
	<artifactId>ehcache-spring-annotations</artifactId>
	<version>1.2.0</version>
</dependency>

<!-- 缓存配置 -->
<ehcache:annotation-driven cache-manager="ehCacheManager" />

<bean id="ehcacheManager"
	class="org.springframework.cache.ehcache.EhCacheManagerFactoryBean">
	<property name="configLocation" value="classpath:conf/cache/ehcache-config.xml" />
</bean> 

## 使用

**方法级别上使用：**
经我的测试，放在service方法上是不生效的。

**TODO** 待测试！！！按道理应该是放在哪都行的！必须有接口才行？还是只能放在接口上？

// 添加缓存
@Cacheable(cacheName="silk.srd")
// 清除缓存
@TriggersRemove(cacheName="silk.srd", when=When.AFTER_METHOD_INVOCATION, removeAll=true)
save() update()

**可以在conf/cache/ehcache-config.xml配置相关的缓存名：**
<cache name="silk.srd.base" 
		maxBytesLocalHeap="10M" 
		eternal="false" 
		timeToIdleSeconds="3600"
		timeToLiveSeconds="3600" 
		overflowToDisk="false" />

## 疑问

- [spring+ehcache应用](http://78425665.iteye.com/blog/1564719)

>以前没具体做过缓存，于是上网搜了下资料，于是得知spring+ehcache做缓存一些考虑因素： 
1、缓存的切面放在哪一层最合适（大部分情况是service，dao），其实应用在哪一层都有各自的用武之地，如： 
一、放在service，是缓存整个经过业务处理后的一个结果，这样的做法大大减少了系统逻辑处理，但如果业务方法里面涉及到多表操作，则比较麻烦，因为要考虑缓存数据更新的问题。 
二、放在dao，大多数都放在这层，也是推荐放在这层，因为基本不用人为的考虑缓存及时更新的问题造成业务方法返回的结果不一致。只缓存数据，不牵扯到业务逻辑 

- [Spring3.1 Cache注解](http://hanqunfeng.iteye.com/blog/1158824)
