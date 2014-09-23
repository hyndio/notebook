# Something I shoud know

## issue 1
java.lang.IllegalArgumentException: Mapped Statements collection does not contain value for com.ailk.srd.nas.teamwork.dao.AccountMapper.getAccountByUsername

Work out: interface位置和namespace的设置必须相同
[来源](http://blog.csdn.net/zgmzyr/article/details/8044980)

## issue 2
Plugin execution not covered by lifecycle configuration

Work out:

- [M2E plugin execution not covered](http://wiki.eclipse.org/M2E_plugin_execution_not_covered)

- [使用m2e将工程转化为maven工程后eclipse报Plugin execution not covered by lifecycle configuration:xxx plugin问题的解决方法](http://blog.csdn.net/bluishglc/article/details/7302671)

- [使用 aspectj-maven-plugin 编绎打包 使用aspectJ 的maven项目](http://www.cnblogs.com/wucg/archive/2013/01/29/2881161.html)

## issue 3

**杨北晏**

我说一下inset表的时候遇到timestamp和date数据库类型的时候，配置下这几个参数
exp:
```
<result property="loginTime" column="login_time" javaType="java.sql.Timestamp" jdbcType="TIMESTAMP"/>
<result property="loginDate" column="login_date" javaType="java.sql.Date" jdbcType="DATE"/>
<insert>
   insert into tab values(#{loginTime,jdbcType=TIMESTAMP},#{loginDate,jdbcType=DATE})
</insert>
```
## issue 4

- [mybatis 需要注意的点 MyBatis 插入空值时，需要指定JdbcType](http://makemyownlife.iteye.com/blog/1610021)
- [关于Mybatis3对Clob,Blob的处理](http://tangdudream.iteye.com/blog/1412358)

## issue 5

批量插入的问题：

**Q: oracle真不支持？？待测试***

	<insert id="createIndex2Report" parameterType="hashMap">
	INSERT IGNORE INTO report_index (reportId,accountId) VALUES
	<foreach collection="items" item="item" index="index" separator=",">
	        (#{item},#{accountId})
	</foreach>
	</insert>

	这种批量插入的动作。
	在mysql下没有问题；
	在oracle下只针对单条没问题，多条数据就over了。

**测试过程：**

	<!-- 批量保存 -->
	<select id="saveBatch" parameterType="ArrayList" >
	insert into AIOMNIZF.base_log_visit values
		<foreach collection="list" item="item" index="index" separator="union all">
			(#{item.shared.logId}, #{item.menuId},
			#{item.shared.beginTime, jdbcType=TIMESTAMP},
			#{item.shared.endTime, jdbcType=TIMESTAMP},
			#{item.shared.operatorDate, jdbcType=DATE},
			#{item.shared.tag}, #{item.shared.operator}, #{item.shared.clientIP},
			#{item.shared.serverIP}, #{item.shared.userAgent}, #{item.shared.sessionId, jdbcType=VARCHAR})
		</foreach>
	</select>

**note: separator="union all"**

	### The error may involve com.ailk.srd.framework.core.base.dao.VisitLogDao.saveBatch-Inline
	### The error occurred while setting parameters
	### SQL: insert into AIOMNIZF.base_log_visit values         (?, ?,    ?,    ?,    ?,    ?, ?, ?,    ?, ?, ?)    union all     (?, ?,    ?,    ?,    ?,    ?, ?, ?,    ?, ?, ?)    union all     (?, ?,    ?,    ?,    ?,    ?, ?, ?,    ?, ?, ?)    union all     (?, ?,    ?,    ?,    ?,    ?, ?, ?,    ?, ?, ?)    union all     (?, ?,    ?,    ?,    ?,    ?, ?, ?,    ?, ?, ?)
	### Cause: java.sql.SQLException: ORA-00933: SQL command not properly ended

**note: separator=","**

	### The error may involve com.ailk.srd.framework.core.base.dao.VisitLogDao.saveBatch-Inline
	### The error occurred while setting parameters
	### SQL: insert into AIOMNIZF.base_log_visit values         (?, ?,    ?,    ?,    ?,    ?, ?, ?,    ?, ?, ?)    ,     (?, ?,    ?,    ?,    ?,    ?, ?, ?,    ?, ?, ?)    ,     (?, ?,    ?,    ?,    ?,    ?, ?, ?,    ?, ?, ?)    ,     (?, ?,    ?,    ?,    ?,    ?, ?, ?,    ?, ?, ?)    ,     (?, ?,    ?,    ?,    ?,    ?, ?, ?,    ?, ?, ?)
	### Cause: java.sql.SQLException: ORA-00933: SQL command not properly ended

**结论：oracle真不支持`foreach`的写法。**

**解决方法：写一个插入方法，通过事物管理批量插入**

Q: 批量插入是不同的表，而且还需要回滚的情况呢？？
这种情况下，只能方法中写事务管理了。

## 事务

- [Spring3.0和Mybatis的集成,含事务配置](http://www.iteye.com/topic/1121458)
- [MyBatis3整合Spring3的Transaction事务处理](http://blog.csdn.net/ibm_hoojo/article/details/6326342)

## 在Mybatis-spring中由于默认Autowired导致不能配置多个数据源的问题分析及解决

- [在Mybatis-spring中由于默认Autowired导致不能配置多个数据源的问题分析及解决](http://www.iflym.com/index.php/code/201211010001.html)