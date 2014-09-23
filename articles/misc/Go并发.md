# GO并发笔记

要分`生产者`与`消费者`，它们通过`channel`通讯，要熟悉GO内存模型。

生产者如何生产，消费者如何消费？这就是程序员应该考虑的。

It's that simple!

## 通过http接口监控程序

import _ "net/http/pprof“
go func() {      
    http.ListenAndServe("localhost:   6060", nil) 
}()
随时观察程序状态(goroutine, heap, thread)
随时可以profile程序(go tool pprof http://localhost:6060/debug/pprof)


## 通过expvar导出关键变量

import _ "expvar"
导出变量为json格式，便于分析和绘图，有利于编写自动化监控程序
