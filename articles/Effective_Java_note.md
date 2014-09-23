# Effective Java (2nd edition) 笔记

## 异常

1. 异常是为了在异常情况下使用而设计的。不要将它们用于普通的控制流，也不要编写迫使它们这么做的API。
2. 对可恢复的情况使用受检异常，对编程错误使用运行时异常。
	- 三类可抛出的异常：checked exception, run-time exception and error.
	- 使用checked exception主要原则: 如果期望调用者能够适当地恢复，对于这种情况就应该使用checked exception.
	- 用run-time exception来表明编程错误。
	- 按照惯例，error往往被JVM保留用于表示资源不足、约束失败，或者其他使程序无法继续执行的条件。因此最好不要实现任何新的error子类。
	- 实现的所有未检异常的抛出结构都应该是RuntimeException的子类（直接的或间接的）。
3. 避免不必要地使用受检的异常。
4. 优先使用标准的异常。
	- IllegalArgumentException
	- IllegalStateException
	- NullPointerException
	- IndexOutOfBoundsException
	- ConcurrentModificationException
	- UnsupportedOperationException
5. 抛出与抽象相对应的异常
	- 使用异常转译（exception translation）
	- 异常链（一种特殊的异常转译形式）
6. 每个方法抛出的异常都要有文档。
	- 始终要单独地声明受检的异常(Don't never do like that: throws Exception)，并且利用Javadoc的@throws标记，准确地记录下抛出每个异常的条件。
	- 未受检异常
		- 将未受检异常信息组织成列表文档，列出被成功执行的前提条件
		- 使用Javadoc的@throws标签记录下一个方法可能抛出的每个未受检异常，**但是不要使用throws关键字将未受检异常包含在方法的声明中。**
7. 在细节消息中包含能捕获失败的信息。比如：当前值，允许的最小值，允许的最大值等。
8. 努力使失败保持原子性。
	- 一般而言，作为方法规范的一部分，产生的任何异常都应该让对象保持在该方法调用之前的状态。如果违反这条规则，API文档就应该清楚地对象将处于什么样的状态。
9. 不要忽略异常
	- 每当见到空catch块时，应该警钟长鸣。至少，catch块也应该包含一条说明，解释为什么可以忽略这个异常。

## 并发