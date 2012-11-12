# Hibernate的保存与更新

**来源**：

- [hibernate的save(),saveOrUpdate(),update(),merge()方法的使用](http://blog.csdn.net/tengdazhang770960436/article/details/8041169)

- [Hibernate三种状态的区分，以及save,update,saveOrUpdate,merge等的使用](http://www.blogjava.net/TiGERTiAN/archive/2008/10/25/236519.html)

## 常用方法对比

1. load & get
    - load: 打印出来的是代理类的名称。
	- get: 打印出来的是类的名称。
 
    *通过get()或load()方法得到的实例都是持久化状态的。*

2. save & persist
	- save: 把一个瞬态的实例持久化标识符，及时的产生,它要返回标识符，所以它会立即执行Sql insert
	- persist: 把一个瞬态的实例持久化，但是并"不保证"标识符(identifier主键对应的属性)被立刻填入到持久化实例中，标识符的填入可能被推迟到flush的时候。

3. clear & evict
	- clear: 完整的清除session缓存
	- evict(obj): 把某个持久化对象从session的缓存中清空。

4. update & merge
	- update: 把一个脱管状态的对象或自由态对象（一定要和一个记录对应）更新到数据库。
	- merge: 把处理自由态的po对象A的属性copy到session当中处于持久态的po的属性中，执行完成后原来是持久状态还是持久态，而我们提供的A还是自由态。

5. flush & commit
	- flush: 默认情况下，一个持久状态的对象的改动（包含set容器）是不需要update的，只要你更改了对象的值，等待hibernate flush就自动更新或保存到数据库了。hibernate flush发生在以下几种情况中：
		1). 调用某些查询的和手动flush()，session的关闭、SessionFactory关闭结合，get()一个对象，把对象的属性进行改变,把资源关闭。
		2). transaction commit的时候（包含了flush）。
	- commit: 提交事务。

6. save & update & saveOrUpdate
	
顾名思义，saveOrUpdate基本上就是合成了save和update,而update只是update;
引用hibernate reference中的一段话来解释他们的使用场合和区别：

>通常下面的场景会使用update()或saveOrUpdate()： 
程序在第一个session中加载对象,接着把session关闭，该对象被传递到表现层，对象发生了一些改动，该对象被返回到业务逻辑层最终到持久层，程序创建第二session调用第二个session的update()方法持久这些改动。

>saveOrUpdate(po)做下面的事: 
如果该po对象已经在本session中持久化了，在本session中执行saveOrUpdate不做任何事，如果savaOrUpdate(新po)与另一个与本session关联的po对象拥有相同的持久化标识(identifier)，抛出一个异常org.hibernate.NonUniqueObjectException: a different object with the same identifier value was already associated with the session。saveOrUpdate如果对象没有持久化标识(identifier)属性，对其调用save() ，否则update() 这个对象

## 需要格外注意的问题
	
1. 在同一个session中，只要标识符属性值相同，那么两个持久化对象就相等（即使用equals()来判断）。
2. 在同一个session中内属性发生了改变会被同步到数据库。（即使不显性调用同步的方法，当事务提交时，就会同步到数据库，**这个需要特别注意！**）
3. 要更新一个对象，必须要指定它的主键，否则更新就会出错。
4. 一个对象的属性在被修改之后，如果还有其他的session进行update的操作，那么操作会被记录到数据库。
5. 在同一个session里面，如果出现了两个相同的托管对象，那么这个时候使用merge方法更新。
