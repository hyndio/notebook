
## Activity, Service,Task, Process and Thread之间的关系

-[Activity, Service,Task, Process and Thread之间的关系](http://blog.csdn.net/zeng622peng/article/details/6367835)

Activity, Service,Task, Process and Thread之间到底是什么关系呢？

首先我们来看下Task的定义，Google是这样定义Task的：a task is what the user experiences as an "application." It's a group of related activities, arranged in a stack. A task is a stack of activities, not a class or an element in the manifest file. 这意思就是说Task实际上是一个Activity栈，通常用户感受的一个Application就是一个Task。从这个定义来看，Task跟 Service或者其他Components是没有任何联系的，它只是针对Activity而言的。

而Service和Activity只是Android提供的Components中的两种，除此之外还有Content Provider和Broadcast Receiver。

通常情况下，对于一个应用程序的所有的Components都会在同一个Process产生的Main Thread中运行。但是我们也可以让不同的Component运行在不同的Process当中，我们可以通过设置这些Components的属性来使其运行在不同的Process当中，例如：<activity android: process = "processA">。当然我们也可以设置使他们运行在同一个Process当中，即使他们不在同一个应用程序当中也可以（前提是这些应用程序使用的是同一个Linux User ID，并且被同一个机构签名）。

那么Thread跟这些Components又有什么关系呢？

通常我们会将一些长时间或大计算量的操作用一个单独的线程来运行，以防止类似操作阻塞Process。比如我们可以为一个Service（如播放音乐的Service）产生一个Thread，我们也可以为Methods来产生一个线程。总之当你不想让某些操作阻塞Main Thread的时候，create a thread!

## 
API中，关于获得运行中的那些东西，有一个类ActivityManager，它可以：
getRecentTasks() 最近开的task，HOME键长按会看到这个
getRunningAppProcesses() 运行中的作为app容器的process。
getRunningServices() 运行中的后台服务
getRunningTasks() 运行中的任务


## TabHost,TabWidget,FrameLayout

-[[Android widget] Android TabHost,TabWidget选项卡总结 ](http://www.eoeandroid.com/thread-113433-1-1.html)

怎么正确定义main.xml布局文件呢？
首先我们需要搞清楚TabHost,TabWidget,FrameLayout之间的关系，
我们知道TabHost好比一个选项卡的容器，包括多个选项卡和选项卡的内容，其中选项卡的内容是一个FrameLayout容器，TabWidget可以理解为选项卡栏.
正确的main.xml文件应该包含这三个组件TabHost,TabWidget,FrameLayout
并且这三个组件的id 必须为
@android:id/tabhost,@android:id/tabs,@android:id/tabcontent

如果想要让选项卡栏在下方，那么只需要交换TabWidget和FrameLayout的位置即可，如

## 图片布局问题（请大家自己看，非常重要）

1，应用本身的图片 例如点击按钮，返回按钮，购物车按钮等，这种是不会发生改变的。  可以设置用图片自身大小             android:layout_width="wrap_content"
    		android:layout_height="wrap_content"   

2，业务涉及的图片，这种图片是从网络加载的，像素大小可能是不规范的，  为了布局不被图像打乱，这个时候就得  用dp 单位定好一个图像大小，然后将图像拉伸属性设置好，即 使图像大小不定，也不会导致 乱了布局。


例如  雷旭的商品列表中的图片，保善的购物车中的商品图片   这种就是业务涉及的图片，我们不可能保证  图从后端拿过来每个图片都是同样大小的像素，所以要做特殊处理。


我用保善的购物车中的商品图片做个例子吧，  他的图片起初是这样子的，     <ImageView 
            android:id="@+id/img_shopcart_item_goods"
            android:layout_width="wrap_content"
    		android:layout_height="wrap_content"
    		android:layout_marginTop="5dp"
    		android:src="@drawable/temp_img_shopcart_main"/>


这个时候 如果过来的图片都是比较标准的，那么保善这个是可以的，如果图片不标准 则会把他的布局弄乱。  

改成 以下方式就可以解决这个问题了。


    <ImageView 
            android:id="@+id/img_shopcart_item_goods"
            android:layout_width="60dp"
    		android:layout_height="50dp"
    		android:scaleType="fitXY"
    		android:layout_marginTop="5dp"
    		android:src="@drawable/temp_img_shopcart_main"/>

思路 先定好你要显示的图框的大小（要用dp单位，使每个手机看到的都是一样的效果），然后让你的图片填充满整个框。  

其中 
            android:layout_width="60dp"
    		android:layout_height="50dp"
是你自己自定义的图框大小。  不要往了加 android:scaleType="fitXY"   这个属性，这个属性是拉伸填充整个父区域 

## Android fill_parent、wrap_content和match_parent的区别

三个属性都用来适应视图的水平或垂直大小，一个以视图的内容或尺寸为基础的布局比精确地指定视图范围更加方便。
1）fill_parent
设置一个构件的布局为fill_parent将强制性地使构件扩展，以填充布局单元内尽可能多的空间。这跟Windows控件的dockstyle属性大体一致。设置一个顶部布局或控件为fill_parent将强制性让它布满整个屏幕。
2） wrap_content
设置一个视图的尺寸为wrap_content将强制性地使视图扩展以显示全部内容。以TextView和ImageView控件为例，设置为wrap_content将完整显示其内部的文本和图像。布局元素将根据内容更改大小。设置一个视图的尺寸为wrap_content大体等同于设置Windows控件的Autosize属性为True。
3）match_parent
   Android2.2中match_parent和fill_parent是一个意思 .两个参数意思一样，match_parent更贴切，于是从2.2开始两个词都可以用。那么如果考虑低版本的使用情况你就需要用fill_parent了

## FrameLayout

Note that if the parent FrameLayout doesn't contain any views other than the <include> tag, you can safely skip the parent layout and just use the children layout directly. `Every activity already has a FrameLayout at its root.`

## android 编写需要注意的3个重要点。 
1， android3.0版本开始就强制不能在主线程中访问网络，要把访问网络放在独立的线程中。
2，子线程中不能创建Handler处理类。
3，子线程中不能直接做UI操作（更新UI），可以用消息处理方式更新。
详细体验过程：
      依附于主UI线程的子线程中有时可以做更新UI操作的，例如直接在onCreate中创建一个线程更新UI是可以的，如果让他休眠3-5秒钟然后再去更新是不可以的，如果在非依附于主UI线程的子线程中直接是不可以更新UI操作的。            
     从源码上来看 android 做了一些他必要的保护措施，更新UI时做了 checkThread 如果发现不是 UI线程 他就不更新 。  所以综上所述， 不能在子线程中直接更新UI，如果需要更新 则用消息处理方式更新。
