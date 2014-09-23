# spring annotation

- [Spring 3.0 注解注入详解](http://developer.51cto.com/art/201104/255395.htm)

## 1.@Autowired注解(不推荐使用，建议使用@Resource)

@Autowired可以对成员变量、方法和构造函数进行标注，来完成自动装配的工作。@Autowired的标注位置不同，它们都会在Spring在初始化这个bean时，自动装配这个属性。

## 2. @Qualifier注解

@Autowired是根据类型进行自动装配的。例如，如果当Spring上下文中存在不止一个UserDao类型的bean时，就会抛出BeanCreationException异常;如果Spring上下文中不存在UserDao类型的bean，也会抛出BeanCreationException异常。我们可以使用@Qualifier配合@Autowired来解决这些问题。

## 3. @Resource注解

JSR-250标准注解，推荐使用它来代替Spring专有的@Autowired注解。@Resource的作用相当于@Autowired，只不过@Autowired按byType自动注入，而@Resource默认按byName自动注入罢了。@Resource有两个属性是比较重要的，分别是name和type，Spring将 @Resource注解的name属性解析为bean的名字，而type属性则解析为bean的类型。所以如果使用name属性，则使用byName的自动注入策略，而使用type属性时则使用byType自动注入策略。如果既不指定name也不指定type属性，这时将通过反射机制使用byName自动注入策略。

**@Resource装配顺序：**

1. 如果同时指定了name和type，则从Spring上下文中找到唯一匹配的bean进行装配，找不到则抛出异常
2. 如果指定了name，则从上下文中查找名称(id)匹配的bean进行装配，找不到则抛出异常
3. 如果指定了type，则从上下文中找到类型匹配的唯一bean进行装配，找不到或者找到多个，都会抛出异常
4. 如果既没有指定name，又没有指定type，则自动按照byName方式进行装配(见2);如果没有匹配，则回退为一个原始类型(UserDao)进行匹配，如果匹配则自动装配;

## 4. @PostConstruct(JSR-250)注解

在方法上加上注解@PostConstruct，这个方法就会在Bean初始化之后被Spring容器执行(注：Bean初始化包括，实例化Bean，并装配Bean的属性(依赖注入))。它的一个典型的应用场景是，当你需要往Bean里注入一个其父类中定义的属性，而你又无法复写父类的属性或属性的setter方法时。

## 5. @PreDestroy(JSR-250)注解

在方法上加上注解@PreDestroy，这个方法就会在Bean初始化之后被Spring容器执行。其用法同@PostConstruct。和@PostConstruct 区别在于：@PostConstruct注释的方法将在类实例化后调用，而标注了 @PreDestroy 的方法将在类销毁之前调用。

## 6. @Component注解 (不推荐使用)

只需要在对应的类上加上一个@Component注解，就将该类定义为一个Bean了。Spring还提供了更加细化的注解形式：`@Repository、@Service、@Controller`，它们分别对应存储层Bean，业务层Bean，和展示层Bean。目前版本(2.5)中，这些注解与@Component的语义是一样的，完全通用，在Spring以后的版本中可能会给它们追加更多的语义。**所以，我们推荐使用@Repository、@Service、@Controller来替代@Component。**

## 7.@Scope注解

在使用XML定义Bean时，我们可能还需要通过bean的scope属性来定义一个Bean的作用范围，我们同样可以通过@Scope注解来完成这项工作。

	/**
	 * Specifies the scope to use for the annotated component/bean.
	 * @see ConfigurableBeanFactory#SCOPE_SINGLETON
	 * @see ConfigurableBeanFactory#SCOPE_PROTOTYPE
	 * @see org.springframework.web.context.WebApplicationContext#SCOPE_REQUEST
	 * @see org.springframework.web.context.WebApplicationContext#SCOPE_SESSION
	 */
	 String value() default ConfigurableBeanFactory.SCOPE_SINGLETON;