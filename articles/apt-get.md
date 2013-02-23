
apt使用一个文件列出可获得软件包的镜像站点地址，这个文件就是/etc/apt/sources.list。

常用命令用法

　　apt-cache search # ——（package 搜索包）
　　apt-cache show #——（package 获取包的相关信息，如说明、大小、版本等）
　　sudo apt-getinstall # ——（package 安装包）
　　sudo apt-get install # —–（package - - reinstall 重新安装包）
　　sudo apt-get -f install # —–（强制安装?#”-f = –fix-missing”当是修复安装吧…）
　　sudo apt-get remove #—–（package 删除包）
　　sudo apt-get remove --purge # ——（package 删除包，包括删除配置文件等）
　　sudo apt-get autoremove –purge # —-(package 删除包及其依赖的软件包 配置文件等（只对6.10有效，强烈推荐））
　　sudo apt-get update #——更新源
　　sudo apt-get upgrade #——更新已安装的包
　　sudo apt-get dist-upgrade # ———升级系统
　　sudo apt-get dselect-upgrade #——使用 dselect 升级
　　apt-cache depends #——-(package 了解使用依赖）
　　apt-cache rdepends # ——（package 了解某个具体的依赖?#当是查看该包被哪些包依赖吧…）
　　sudo apt-get build-dep # ——（package 安装相关的编译环境）
　　apt-get source #——（package 下载该包的源代码)
　　sudo apt-get clean && sudo apt-get autoclean # ——–清理下载文件的存档 && 只清理过时的包
　　sudo apt-get check #——-检查是否有损坏的依赖
　　apt-get install# ——（下载 以及所有倚赖的包裹，同时进行包裹的安装或升级。如果某个包裹被设置了 hold （停止标志，就会被搁在一边（即不会被升级）。更多 hold 细节请看下面。）
　　apt-get remove [--purge]# ——（移除 以及任何倚赖这个包裹的其它包裹。）
　　–purge 指明这个包裹应该被完全清除 (purged) ，更多信息请看 dpkg -P。
　　apt-get update# ——（升级来自 Debian 镜像的包裹列表，如果你想安装当天的任何软件，至少每天运行一次，而且每次修改了/etc/apt/sources.list 后，必须执行。）
　　apt-get upgrade [-u]# ——（升级所以已经安装的包裹为最新可用版本。不会安装新的或移除老的包裹。形前端（其中一些在使用前得先安装）。这里 dselect 无疑是最强大的，也是最古老，最难驾驭。）
