
# 布局的学习

## UI overview
All user interface elements in an Android app are built using View and ViewGroup objects. A View is an object that draws something on the screen that the user can interact with. A ViewGroup is an object that holds other View (and ViewGroup) objects in order to define the layout of the interface.

To declare your layout, you can instantiate View objects in code and start building a tree, but the easiest and most effective way to define your layout is with an XML file. XML offers a human-readable structure for the layout, similar to HTML.

The name of an XML element for a view is respective to the Android class it represents. So a `<TextView>` element creates a TextView widget in your UI, and a <LinearLayout> element creates a LinearLayout view group.

A layout defines the visual structure for a user interface, such as the UI for an activity or app widget. You can declare a layout in two ways:

Declare UI elements in XML. Android provides a straightforward XML vocabulary that corresponds to the View classes and subclasses, such as those for widgets and layouts.
Instantiate layout elements at runtime. Your application can create View and ViewGroup objects (and manipulate their properties) programmatically.


- [Layouts](http://developer.android.com/guide/topics/ui/declaring-layout.html)

## Layout Parameters

XML layout attributes named layout_something define `layout parameters` for the View that are appropriate for the ViewGroup in which it resides.

Every ViewGroup class implements a nested class that extends ViewGroup.LayoutParams. This subclass contains property types that define the size and position for each child view, as appropriate for the view group. 

Note that every LayoutParams subclass has its own syntax for setting values. Each child element must define LayoutParams that are appropriate for its parent, though it may also define different LayoutParams for its own children.

All view groups include a width and height (layout_width and layout_height), and each view is required to define them. Many LayoutParams also include optional margins and borders.

You can specify width and height with exact measurements, **though you probably won't want to do this often**. More often, you will use one of these constants to set the width or height:

`wrap_content` tells your view to size itself to the dimensions required by its content
`fill_parent` (renamed `match_parent` in API Level 8) tells your view to become as big as its parent view group will allow.

In general, specifying a layout width and height using **absolute units such as pixels is not recommended**. Instead, **using relative measurements such as density-independent pixel units (dp), wrap_content, or fill_parent, is a better approach**, because it helps ensure that your application will display properly across a variety of device screen sizes.

## Layout Position

The geometry of a view is that of a rectangle. A view has a location, expressed as a pair of left and top coordinates, and two dimensions, expressed as a width and a height. **The unit for location and dimensions is the pixel.**

## Size, Padding and Margins

The size of a view is expressed with a `widt`h and a `height`. A view actually possess `two pairs` of width and height values.

The first pair is known as `measured width` and `measured height`. **These dimensions define how big a view wants to be within its parent.** The measured dimensions can be obtained by calling getMeasuredWidth() and getMeasuredHeight().

The second pair is simply known as `width` and `height`, or sometimes `drawing width` and `drawing height`. **These dimensions define the actual size of the view on screen, at drawing time and after layout.** These values may, but do not have to, be different from the measured width and height. The width and height can be obtained by calling getWidth() and getHeight().

To measure its dimensions, a view takes into account its padding. **The padding is expressed in pixels for the left, top, right and bottom parts of the view. Padding can be used to offset the content of the view by a specific amount of pixels.** For instance, a left padding of 2 will push the view's content by 2 pixels to the right of the left edge. Padding can be set using the setPadding(int, int, int, int) method and queried by calling getPaddingLeft(), getPaddingTop(), getPaddingRight() and getPaddingBottom().

**Even though a view can define a padding, it does not provide any support for margins.** However, view groups provide such a support. Refer to ViewGroup and ViewGroup.MarginLayoutParams for further information.

## Common Layouts

**Note:** Although you can nest one or more layouts within another layout to acheive your UI design, you should strive to keep your layout hierarchy as shallow as possible. Your layout draws faster if it has fewer nested layouts (**a wide view hierarchy is better than a deep view hierarchy**).

## Building Layouts with an Adapter

- [Building Layouts with an Adapter](http://developer.android.com/guide/topics/ui/declaring-layout.html#AdapterViews)

When the content for your layout is dynamic or not pre-determined, you can use a layout that subclasses `AdapterView` to populate the layout with views `at runtime`. A subclass of the AdapterView class uses an `Adapter` to bind data to its layout. **The Adapter behaves as a middle-man between the data source and the AdapterView layout**—the Adapter retrieves the data (from a source such as an array or a database query) and converts each entry into a view that can be added into the AdapterView layout.

Common layouts backed by an adapter include: 

- List View

Displays a scrolling single column list.

- Grid View

Displays a scrolling grid of columns and rows.

### Filling an adapter view with data

- ArrayAdapter

To customize the appearance of each item you can override the toString() method for the objects in your array. Or, to create a view for each item that's something other than a TextView (for example, if you want an ImageView for each array item), extend the ArrayAdapter class and override getView() to return the type of view you want for each item.

- SimpleCursorAdapter

### Handling click events

You can respond to click events on each item in an AdapterView by implementing the AdapterView.OnItemClickListener


## <include>
Includes a layout file into this layout.
attributes:

layout
Layout resource. `Required. `Reference to a layout resource.

android:id
Resource ID. Overrides the ID given to the root view in the included layout.

android:layout_height
Dimension or keyword. Overrides the height given to the root view in the included layout. Only effective if android:layout_width is also declared.

android:layout_width
Dimension or keyword. Overrides the width given to the root view in the included layout. Only effective if android:layout_height is also declared.

**You can include any other layout attributes in the <include> that are supported by the root element in the included layout and they will override those defined in the root element.**

**Caution**: If you want to override layout attributes using the <include> tag, you must override both android:layout_height and android:layout_width in order for other layout attributes to take effect.

## ScrollView

允许用户滚动的，可以放置超过物理显示器大小的视图层次的布局容器. ScrollView 是一种 **FrameLayout**， 这意味着需要在其上放置一个包含整个滚动内容的子元素. 该子元素自身也可以是一个拥有复杂对象层次的布局管理器. 常用的子元素为垂直方向的LinearLayout， 用于呈现用户可以滚动的顶层条目的数组。

**You should never use a `ScrollView` with a `ListView`**, because ListView takes care of its own vertical scrolling. Most importantly, doing this defeats all of the important optimizations in ListView for dealing with large lists, since it effectively forces the ListView to display its entire list of items to fill up the infinite container supplied by ScrollView.

TextView类有自己的滚动功能，所以不需要使用ScrollView， 将两者结合使用可以达到在一个大容器中显示文本视图的效果。

ScrollView 仅支持纵向滚动。For horizontal scrolling, use HorizontalScrollView.

## ImageView

background: 背景图会自动拉伸
src: 填充图不会


