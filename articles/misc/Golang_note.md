# Golang note

**主要是从golang-china而来！**

## IDE

- [LiteIDE Released for Go](https://code.google.com/p/golangide/)

## 函数导出

- [原问题](https://groups.google.com/forum/?fromgroups=#!topic/golang-china/fCIvODOXrYo)

如果原来的函数是
func abc(first, second int)
改成
func Abc(first, second int)
因为只会再内部调用，所以只要用gofmt -r "abc(a,b)->Abc(a,b)"对所有包内的文件格式化一次就可以把所有调用的地方都改掉了

## 初始安装

- [原问题](https://groups.google.com/forum/?fromgroups=#!topic/golang-china/LWRvV9SYrzY)

莫非大家都喜欢不读文档吗。我前几天刚刚给一位朋友解决完go环境的安装问题， 
到头来还是他自己没认真读文档，设置了没必要设置的环境变量——而且还给设置错了。 

安装go的环境，只需要下载一个文件，解压缩，创建一个文件夹，再设置两个环境 
变量： 

1. 下载 
- wget http://go.googlecode.com/files/go1.0.3.linux-amd64.tar.gz 
(如果是别的系统，就在 http://code.google.com/p/go/downloads/list 找到相 
应的文件下载） 

2. 解压 
- tar zxvf go1.0.3.linux-amd64.tar.gz 

3. 复制到相应目录 
- mv go/ /usr/local/ 

4. 添加PATH： 
- export PATH=/usr/local/go/bin:${PATH} 

5. 创建gopath 
- mkdir -p $HOME/goproj/bin 
- mkdir -p $HOME/goproj/src 
- mkdir -p $HOME/goproj/pkg 

6. 设置GOPATH环境变量 
- export GOPATH=$HOME/goproj 

7. 添加PATH: 
- export PATH=$HOME/goproj/bin:${PATH} 

8. 把修改的那些环境变量放到该放的地方。例如~/.bashrc 

即，把以下内容复制粘贴到~/.bashrc里： 
export PATH=/usr/local/go/bin:${PATH} 
export GOPATH=$HOME/goproj 
export PATH=$HOME/goproj/bin:${PATH} 

9. 测试： 
- go version 
go version go1.0.3 
- go get github.com/uniqush/uniqush-push 
- uniqush-push 

最后，关于从源码编译也并不复杂，参见这里：http://golang.org/doc/install 
/source 
鉴于go1.1快出了，我觉得没必要非得从源码编译，等1.1出来之后，再下载解压就 
完了。 

-Monnand 

## 关于FileServer的问题

- [关于FileServer的问题](https://groups.google.com/forum/?fromgroups=#!topic/golang-china/kCbzfPrN8-M)

概述：我的CSS等静态文件存放在 /Documents/CSS 目录里面。 
然后在我的html文件里有 <link href="CSS/index.css"/>。 

在go源码里我设置 
        cssHandler := http.FileServer(http.Dir("/Documents/CSS")) 
**要么是这里Dir("/Documents")**
将这个handler检测: 
         http.Handle("/CSS", cssHandler); 
**要么这里加上http.StripPrefix("/CSS", cssHandler)**

实际上这样写浏览器访问的时候并不能找到css文件。这是为什么呢？ 

## go env 下个环境变量有何用途

- [go env 下个环境变量有何用途](https://groups.google.com/forum/?fromgroups=#!topic/golang-china/FwFCCo7lmeM)

- GOARCH="386" 
Go编译器输出的程序的目标架构，3个可选：arm, 386, amd64 
- GOBIN="" 
存放编译出来的命令（程序）的目录，对于GOPATH里面的，默认放到$GOPATH/bin下，GOROOT里面的 
放到$GOROOT/bin下，如果$GOBIN设置了，则都放到$GOBIN下。 
- GOCHAR="8" 
每个体系的编译器有一个字符表示，比如386是8，amd64是6，arm是5，这个一般不用管。 
Plan 9工具链特点。 
- GOEXE="" 
可执行文件名的后缀，只在Windows下有用，设置成".exe"。 
- GOGCCFLAGS="-g -O2 -fPIC -m32 -pthread" 
编译cgo的时候gcc编译的命令行参数。 
- GOHOSTARCH="386" 
当前运行Go工具链的系统架构，可选的值同上$GOARCH 
- GOHOSTOS="linux" 
当前运行Go工具链的操作系统，可选的值很多，linux, darwin, windows, freebsd, openbsd, netbsd, plan9等 
- GOOS="linux" 
编译出来的目标程序在哪个操作系统上执行，可选的同上面的GOHOSTOS。 
- GOPATH="" 
GOPATH就不用解释了吧？ 
- GOROOT="/home/kdev/go" 
Go本身装在GOROOT下面。 
- GOTOOLDIR="/home/kdev/go/pkg/tool/linux_386" 
Go的工具链程序在这个目录下，一般也不用管，直接用go tool 8g这样就行了。 
- CGO_ENABLED="1" 
是否使用cgo，可选值是1和0. 

## godoc -http=:6060

-[来源](https://groups.google.com/forum/?fromgroups=#!topic/golang-china/ANIdbH1bGMg)

godoc -http<space>=:6060 

会被认为-http的参数是”=:6060"，而不是":6060"， 
-A=XXX 和 -A<space>XXX 是等价的，但是不能在=之前加空格，否则就被认为是 
第二种形式了。 

根据minux所述，以下方式均正确。
  $ godoc -http :6060
  $ godoc -http                :6060
  $ godoc -http=:6060

## Go里面的常数是高精度数

- [来源](https://groups.google.com/forum/?fromgroups=#!topic/golang-china/k1UOr_1K_yw)

分为几类： 
1，有类型的：uint(8)，类型显式指定了，在表达式里面不会变化。 
2，无类型的：分成无类型整数和无类型浮点两类。这两类在使用的时候会根据上下文需要的类型转化为实际类型， 
比如uint8(0) + 1.0就是uint8(1)，但是uint8(0)+1.2就会由于1.2无法转化为uint8而报错。 
如果上下文无法确定（比如 i, j := 1, 2.0这样的），那么整数无类型常数转化为int，浮点数无类型常数转化为float64.

## socket处理问题

- [socket处理问题](https://groups.google.com/forum/?fromgroups=#!topic/golang-china/eZDFnSAYit4)

> 一般服务器都会有大量的socket连接，可以对每一个socket都开一个对应 
> goroutine对其进行阻塞等待，但是这样太浪费了。 

为什么呢？一个goroutine的开销很小，它的目的（之一）就是为了让你可以用阻 
塞的方式来编写大型的网络程序。（注意：阻塞的方式来编写程序并不意味着调用 
阻塞模式的read/write） 

> 
> 能不能让一个goroutine去epoll所有的socket的连接，当poll到有数据时向对应的 
> 处理goroutine发消息处理(chan)?? 

使用goroutine阻塞地读写并不意味着不使用epoll。实际上，Go的所有读写操作都 
是在epoll基础上做的。多个goroutine可以跑在同一个线程上，一个goroutine阻 
塞，另外一个就会被调度进来，这些操作都是在用户空间完成了。 

换句话说，用goroutine+阻塞读写的方式，实际的底层实现相当于用epoll + 
callback + thread pool。 

而使用阻塞读写的方式可以非常方便地开发，不必考虑各种callback之间的同步问题。 

> 
> 这样是不是更好呢？？ 
> 

不是 

> -- 

go底层就是epoll，上层是goroutine，这样你看上去就是用顺序的代码，在做的是异步的事，和python的gevent一个道理。现代服务器开个几十万个goroutine一点压力没有。放心好了 

## LRUcache

lru
1. [计算机科学] least recently used 最近最少使用

-[来源](https://groups.google.com/forum/?fromgroups=#!topic/golang-china/_aZNliBiiBo)

关于cache的问题：要看你打算做什么。如果cache需要的内存比较大，按照vitess 
的经验，可以考虑使用memcached或者redis这样的key value store： 

http://code.google.com/p/vitess/wiki/ProjectGoals 

原文： 

Go’s existing mark-and-sweep garbage collector is sub-optimal for 
systems that use large amounts of static memory (like caches). In the 
case of vtocc, this would be the row cache. To alleviate this, we intend 
to use memcache for the time being. If the gc ends up addressing this, 
it should be fairly trivial to switch to an in-memory row cache. 

不知道1.1之后这方面的改进如何。 

另外，vitess项目里面本身就有一个不错的lru cache实现： 

http://code.google.com/p/vitess/source/browse/go/cache/lru_cache.go 

但是应该没有你需要的过期时间这个功能 

另外uniqush下也有一个LRU的实现： 
https://github.com/uniqush/cache 

同样，也没有过期时间 

- [如何设计一个LRU Cache？](http://blog.csdn.net/hexinuaa/article/details/6630384)

## Can I convert a []T to an []interface{}?

Not directly, because they do not have the same representation in memory. It is necessary to copy the elements individually to the destination slice. This example converts a slice of int to a slice of interface{}:

	t := []int{1, 2, 3, 4}
	s := make([]interface{}, len(t))
	for i, v := range t {
	    s[i] = v
	}

## go指针的困惑

- [go指针的困惑](https://groups.google.com/forum/?fromgroups=#!topic/golang-china/adQX-ol_LAk)

http://tip.golang.org/ref/spec#Index_expressions

>For a of type A or *A where A is an array type:
a constant index must be in range
if a is nil or if x is out of range at run time, a run-time panic occurs
a[x] is the array element at index x and the type of a[x] is the element type of A

>For a of type S where S is a slice type:
if the slice is nil or if x is out of range at run time, a run-time panic occurs
a[x] is the slice element at index x and the type of a[x] is the element type of S

http://tip.golang.org/ref/spec#Selectors

>Selectors automatically dereference pointers to structs. If x is a pointer to a struct, x.y is shorthand for (*x).y; 

## 关于Go语言的结构、结构的指针与接口的疑问

- [关于Go语言的结构、结构的指针与接口的疑问](http://segmentfault.com/q/1010000000198984#a-1020000000199038)

>假设T是struct，那么Go里面遵循下面几个原则：
- T的方法集仅拥有 T Receiver 方法。
- *T 方法集则包含全部方法 (T + *T)。
所以你上面的例子dept1应该是拥有方法：Name和SetName
而&dept1拥有方法：Name、SetName和Relocate
这个就是Go里面在设计方法的时候需要注意Receiver的类型

>如果结构的实例x是“可被寻址的”，且&x的方法集中包含方法m，则x.m()为(&x).m()的速记（快捷方式）。

## Go1.1的二进制安装包将包含gotour程序

- godoc -http :6060
- go tool tour
- go doc *run godoc on package sources*

