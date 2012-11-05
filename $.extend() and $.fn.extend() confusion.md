# jQuery: $.extend() and $.fn.extend() confusion
	From: http://asimilia.wordpress.com/2008/12/17/jquery-extend-confusion/

There is a significant difference between using .extend() with one argument and doing it with two or more:

When .extend() receives a single object, it adds the methods defined in it to either the jQuery or the jQuery.fn (also called jQuery.prototype and $.fn) objects.

As a general rule, you should extend the jQuery object for functions and the jQuery.fn object for methods. A function, as opposed to a method, is not accessed directly from the DOM.

Notice the different way of calling a method when extending the jQuery.fn or jQuery objects. The receiver (what’s to left of the period) changes.

	$.fn.extend({
		myMethod: function(){...}
	});
	//jQuery("div").myMethod();

	$.extend({
		myMethod2: function(){...}
	});
	//jQuery.myMethod2();

When .extend() receives two or more objects, it takes the first object and adds to it the methods and variables defined in the other objects. See an example:

	defaults = { size: 3 };
	options = { height: 6 };
	var opts = $.extend(defaults, options)
	// 'defaults' receives the methods and variables defined in 'options'
	// opts == defaults == { size: 3, height: 6 }
	// options == { height: 6 };

If the first object is empty, it will add the methods and variables in a new object. This is useful when we want to group the methods defined in several objects without modifying any of them:

	var opts = $.extend( {}, defaults, options)
	// 'opts' gets all methods and variables defined in 'defaults' and 'options',
	// neither of them get modified.
	// opts == { size: 3, height: 6 }
	// defaults == { size: 3 };
	// options == { height: 6 };