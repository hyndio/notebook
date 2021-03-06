# Unix编程艺术
	
**注意：这些笔记是看书时候的摘抄。**

**Doug Mcllroy**:
	
>Unix哲学是这样的：一个程序只做一件事，并做好。程序要能协作。程序要能处理文本流，因为这是最通用的接口。

**Rob Pike**:

>原则1：你无法断定程序会在什么地方耗费运行时间。瓶颈经常出现在想不到的地方，所以别急于胡乱找个地方改代码，除非你已经证实那儿就是瓶颈的所在。

>原则2：估量。在你没对代码进行估量，特别是没找到最耗时的部分之前，别去优化速度。

>原则3：花哨的算法在n很小时通常很慢，而n通常很小。花哨算法的常数复杂度很大。除非你确定n总是很大，否则不要用花哨的算法（即使n很大，也优先考虑原则2）。

>原则4：花哨的算法比简单算法更容易出bug、更难实现。尽量使用简单的算法配合简单的数据结构。（Ken Thompson: 拿不准就穷举。）

>原则5：数据压倒一切。如果已经选择了正常的数据结构并且把一切组织得井井有条，正确的算法也就不言自明。编程的核心昌数据结构，而不是算法。

>原则6：没有原则6。

**从整体上概括为**：

>1. 模块原则：使用简洁的接口拼命简单的部件。
2. 清晰原则：清晰胜于机巧。
3. 组合原则：设计时考虑拼接组合。
4. 分离原则：策略同机制分离，接口同引擎分离。
	*策略和机制是按照不同的时间尺度变化的，策略的变化要远远快于机制。*
5. 简洁原则：设计要简洁，复杂度能低则低。
6. 吝啬原则：除非无它法，不要编写庞大的程序。
7. 透明性原则：设计要可见，以便审查和调试。
8. 健壮原则：健壮源于透明与简洁。
9. 表示原则：把知识叠入数据以求逻辑质朴而健壮。
	*在设计中，你应该主动将代码的复杂度转移到数据之中去。*（所以说，数据的结构很重要！）
10. 通俗原则：接口设计避免标新立异。
11. 缄默原则：如果一个程序没什么好说，就沉默。
12. 补救原则：出现异常时，马上退出并给出足够的错误信息。
13. 经济原则：宁花机器一分，不花程序员一秒。
14. 生成原则：避免手工hack，尽量编写程序去生成程序。
15. 优化原则：雕琢前先要有原型，跑之前先学会走。
16. 多样原则：决不相信所谓的“不二法门”的断言。
17. 扩展原则：设计着眼未来，未来总比预想中来得快。
	*在设计的时候考虑宽容性，而不是用过分纵容的实现来补救标准的不足。*

**Unix哲学之一言以蔽之：K.I.S.S. (keep It Simple, Stupid!)**

**态度也要紧**：

>看到该做的就去做--短期来看似乎是多做了，但从长期来看，这才是最佳捷径。如果不能确定什么是对的，那么就只做最少量的工作，确保任务完成就行，至少直到明白什么是对的。

>要良好的运用Unix哲学，你就应该不断追求卓越。你必须相信，软件设计是一门技艺，值得你付出所有的智慧、创造力和激情。否则，你的视线就不会超越那些简单、老套的设计和实现；你就会在应该思考的时候急急忙忙跑去编程。你就会在该无情删繁就简的时候反而把问题复杂化--然后你还会反过来奇怪你的代码怎么会那么臃肿、那么难以调试。

>要良好地运用Unix哲学，你应该珍惜你的时间决不浪费。

>软件设计和实现应该是一门充满快乐的艺术，一种高水平的游戏。如果这种态度对你来说听起来有些荒谬，或者令你隐约感到有些困窘，那么请停下来，想一想，问问自己是不是已经把什么给遗忘了。如果只是为了赚钱或是打发时间，你为什么要搞软件设计而不是别的什么呢？你肯定曾经也认为软件设计值得你付出激情……

>要良好的运用Unix哲学，你需要具备（或者找回）这种态度。你需要用心。你需要游戏。你需要乐于探索。


