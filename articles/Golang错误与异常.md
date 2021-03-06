# Golang错误与异常

**来源：**

- 原文：[Why I'm not leaving Python for Go](https://plus.google.com/116810148281701144465/posts/iqAiKAwP6Ce)
- 中文：[为什么我不会舍弃Python投奔Go语言](http://www.linuxeden.com/html/itnews/20121113/131956.html)

## 笔记

>这种状况在这种程序中是可以预料到的。这种操作就是容易失败，你知道程序会如何运行，因为API的设计者通过内置了一种错误情况的结果而让这一切显得很清楚。

**错误：可预料的。** 可以在包之间使用。

>从另一方面讲，有些操作基本上不会出错，所处的环境根本不可能给你提示错误信息，不可能控制错误。这才是让人痛苦的地方。典型的例子；一个程序执行 x[j]，j值超出数组边界，这才痛苦。像这样预料之外的麻烦在程序中是一个严重的bug，一般会弄死程序的运行。

**异常：预料之外的。** 尽量只在内部使用。

>**使用Go语言中的错误返回模式的规则很简单：如果你的函数在某种情况下很容易出错，那它就应该返回错误。**

## Panic & Recover（来自：《学习Go语言》）

>**一定要记得，这应当作为最后的手段被使用，你的代码中应当没有，或者很少的令人恐慌的东西。**

>Panic：是一个内建函数，可以中断原有的控制流程，进入一个令人恐慌的流程中。恐慌可以直接调用panic 产生。也可以由运行时错误产生，例如访问越界的数组。

>Recover：是一个内建的函数，可以让进入令人恐慌的流程中的goroutine恢复过来。recover仅在延迟函数(defer)中有效。

>**对应异常机制，Go 的这种错误机制或许可以叫做恐慌机制：当你遇到它时应该感到恐慌（panic），然后应该恢复（recover）它。**

## 错误处理

参考astaxie写的开源书[《Go Web 编程》](https://github.com/astaxie/build-web-application-with-golang)的[错误处理](https://github.com/astaxie/build-web-application-with-golang/blob/master/11.1.md)章节。