# java.util.concurrent

## 1. ConcurrentHashMap

- [Java并发编程之ConcurrentHashMap](http://www.goldendoc.org/2011/06/juc_concurrenthashmap/)

>ConcurrentHashMap是一个线程安全的Hash Table，它的主要功能是提供了一组和HashTable功能相同但是线程安全的方法。ConcurrentHashMap可以做到`读取数据不加锁`，并且其内部的结构可以让其在进行写操作的时候能够将锁的粒度保持地尽量地小，不用对整个ConcurrentHashMap加锁。

- [探索 ConcurrentHashMap 高并发性的实现机制](http://www.ibm.com/developerworks/cn/java/java-lo-concurrenthashmap/?ca=drs-)

## 2. ConcurrentLinkedQueue

- [聊聊并发（六）ConcurrentLinkedQueue的实现原理分析](http://ifeve.com/concurrentlinkedqueue/#more-1541)

## Java 并发：Executors 和线程池

- [Java 并发：Executors 和线程池](http://www.oschina.net/question/12_11255)

**executor.shutdown();**

Initiates an orderly shutdown in which previously submitted tasks are executed, but no new tasks will be accepted. Invocation has no additional effect if already shut down.
Throws:
SecurityException - if a security manager exists and shutting down this ExecutorService may manipulate threads that the caller is not permitted to modify because it does not hold java.lang.RuntimePermission("modifyThread"), or the security manager's checkAccess method denies access.
