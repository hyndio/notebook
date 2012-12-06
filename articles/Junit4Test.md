# JUnit4 & hamcrest断言

参考： [JUnit4 入门教程](http://hi.baidu.com/iduany/item/9b30bdeb454c0b0a64db0071)

**JUnit4 放弃旧的断言,使用hamcrest断言**

hamcrest需要： hamcrest-core-1.2.jar、hamcrest-library-1.2.jar两个jar文件。

## 使用说明

### 静态引入

	import static org.junit.Assert.assertThat;
	import static org.hamcrest.Matchers.*; 

### 示例

JUnit4 中只使用assertThat方法足矣，assertThat方法需要使用hamcrest的匹配方法：

	assertThat( n, allOf( greaterThan(1), lessThan(15) ) );
	assertThat( n, anyOf( greaterThan(16), lessThan(8) ) );
	assertThat( n, anything() );
	assertThat( str, is( "bjsxt" ) );
	assertThat( str, not( "bjxxt" ) );
	
	assertThat( str, containsString( "bjsxt" ) );
	assertThat( str, endsWith("bjsxt" ) ); 
	assertThat( str, startsWith( "bjsxt" ) ); 
	assertThat( n, equalTo( nExpected ) ); 
	assertThat( str, equalToIgnoringCase( "bjsxt" ) ); 
	assertThat( str, equalToIgnoringWhiteSpace( "bjsxt" ) );
	
	assertThat( d, closeTo( 3.0, 0.3 ) );
	assertThat( d, greaterThan(3.0) );
	assertThat( d, lessThan (10.0) );
	assertThat( d, greaterThanOrEqualTo (5.0) );
	assertThat( d, lessThanOrEqualTo (16.0) );
	
	assertThat( map, hasEntry( "bjsxt", "bjsxt" ) );
	assertThat( iterable, hasItem ( "bjsxt" ) );
	assertThat( map, hasKey ( "bjsxt" ) );
	assertThat( map, hasValue ( "bjsxt" ) );

## 测试状态说明

	Failure和Error:
		Failure是指测试失败
		Error是指测试程序本身出错

## JUnit4 Annotation

	@Test: 测试方法
	(expected=XXException.class)
	(timeout=xxx)
	@Ignore: 被忽略的测试方法
	@Before: 每一个测试方法之前运行
	@After: 每一个测试方法之后运行
	@BeforeClass: 所有测试开始之前运行 //必须定义为static方法
	@AfterClass: 所有测试结束之后运行   //必须定义为static方法