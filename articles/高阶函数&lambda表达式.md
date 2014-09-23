## 高阶函数 & lambda表达式

-[什么是Lambda表达式？](http://www.ituring.com.cn/article/21011)

在一般数学计算中，一个lambda表达式就是一个函数，它的定义是：为部分或者所有输入值指定一个输出值。Lambda表达式在java中是以函数语言的概念引入。在java中术语Lambdas可以理解为一种省略掉修改器，返回类型和参数类型的更紧凑，更好的匿名方法。

语法， lambda的基本语法：
(parameters) -> expression
或者
(parameters) -> { statements; }

Lambda表达式，即lambda expression，既然是expression就有值，这个值就是函数本身.

“Lambda 表达式”（lambda expression）是一个匿名函数，它可以包含表达式和语句，并且可用于创建委托或表达式目录树类型。

高阶函数（higher-order function）是指把另一个函数作为参数或返回值的函数。

简单地说，我们想要的是传入“一些我们自己的代码”到已有的方法中，已有的方法将会执行我们传入的代码。Lambda表达式能很好地支持这点。

传递行为，而不仅仅是传值.

## first-class

我们常常听说，函数式编程中，函数是一等公民。那么，准确讲，对于一个程序设计语言而言，什么样的东西才是它的一等公民（first-class citizens）？这个曾经有牛人给出了定义，一等公民享有如下权利：
可以被变量命名（To Be Named by Variables）；
可以作为方法的参数（To Be Passed as Arguments to Procedures）；
可以作为方法的返回值（To Be Returned as Values of Procedures）；
可以成为数据结构的一部分（To Bo Incorporated into Data Structures）；
这样来看，C/C++中的函数也是一等公民，但是Java中的函数则不是。

个人理解：first-class可以像primitive type一样用。