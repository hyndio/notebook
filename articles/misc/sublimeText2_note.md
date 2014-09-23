# SublimeText2 note

- 必装插件：
	- package control

	[Ctrl + `]

		```2
		import urllib2,os; pf='Package Control.sublime-package'; ipp=sublime.installed_packages_path(); os.makedirs(ipp) if not os.path.exists(ipp) else None; urllib2.install_opener(urllib2.build_opener(urllib2.ProxyHandler())); open(os.path.join(ipp,pf),'wb').write(urllib2.urlopen('http://sublime.wbond.net/'+pf.replace(' ','%20')).read()); print 'Please restart Sublime Text to finish installation'
		```

		```3
		import urllib.request,os; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); open(os.path.join(ipp, pf), 'wb').write(urllib.request.urlopen( 'http://sublime.wbond.net/' + pf.replace(' ','%20')).read())
		```

	[Ctrl+Shilft+p] + install + `GoSublime` + `gocode`

	- emmet
	- jsFormat
	- Tag

Use Multiple Selections to rename variables quickly.
Here Ctrl+D is used to select the next occurrence of the current word.

Make batch edits with Multiple Selections.
Here Ctrl+Shift+L is used to split a selection into lines, and each line is then edited simultaneously.

ctrl + d
ctrl + p | file-name@keyword
Ctrl + shift + p

You can use additive selections to select multiple blocks of text, or subtractive selections to remove a block.
Ctrl + Alt + Up
Ctrl + Alt + Down

- [Sublime Text 2 快捷键 (windows)](http://istyles.blog.163.com/blog/static/1811003892011828111418654/)

Ctrl+L           选择整行（按住-继续选择下行）                           
Ctrl+KK          从光标处删除至行尾                                      
**Ctrl+Shift+K     删除整行**                                                
Ctrl+Shift+D     复制光标所在整行，插入在该行之前                        
Ctrl+J           合并行（已选择需要合并的多行时）                        
Ctrl+KU          改为大写                                                
Ctrl+KL          改为小写                                                
Ctrl+D           选词 （按住-继续选择下个相同的字符串）                  
Ctrl+M           光标移动至括号内开始或结束的位置                        
Ctrl+Shift+M     选择括号内的内容（按住-继续选择父括号）                 
Ctrl+/           注释整行（如已选择内容，同“Ctrl+Shift+/”效果）        
Ctrl+Shift+/     注释已选择内容                                          
Ctrl+Space       自动完成（win与系统快捷键冲突，需修改）                 
Ctrl+Z           撤销                                                    
Ctrl+Y           恢复撤销                                                
Ctrl+Shift+V      粘贴并自动缩进（其它兄弟写的，实测win系统自动缩进无效）
Ctrl+M           光标跳至对应的括号                                      
Alt+.            闭合当前标签                                            
Ctrl+Shift+A     选择光标位置父标签对儿                                  
Ctrl+Shift+[     折叠代码                                                
Ctrl+Shift+]     展开代码                                                
Ctrl+KT          折叠属性                                                
Ctrl+K0          展开所有                                                
Ctrl+U           软撤销                                                  
Ctrl+T           词互换                                                  
Tab              缩进                                                    
Shift+Tab        去除缩进                                                
Ctrl+Shift+UP    与上行互换                                              
Ctrl+Shift+DOWN  与下行互换                                              
Ctrl+K Backspace 从光标处删除至行首                                      
Ctrl+Enter       插入行后                                                
Ctrl+Shift Enter 插入行前                                                
F9               行排序（按a-z）                                            