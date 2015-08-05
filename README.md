#game_manager(游戏后台统计)
============
**功能方面**：本项目开发的最终目标是：
1.让运营可以快速的查询玩家角色信息。
2.操作玩家角色信息（发装备，.....）
3.数据统计（在线量、留存率、支付.....）
4.游戏GM工具，数据统计工具。


##开发方面：
webserver:`Yaws`, 一个Erlang开发的web服务器，[官方网站](http://yaws.hyber.org/)
开发语言：`Erlang`，`Html`(html,javascript,css)

###如何部署：

1.下载并安装Erlang.http://www.erlang.org/down。

2.安装完成后，把bin/erl.exe添加入环境变量

3.下载并安装yaws。http://yaws.hyber.org/download/

4.安装完成后，把/bin/yaws.exe添加入环境变量

5.启动yaws，在浏览器中输入http://127.0.0.1:8080/ 出现内容表示安装成功

6.进入yaws的根目录，根目录下有一个www文件夹，刚刚访问http://127.0.0.1:8080/ 进入的页面就在www下。

7.清空www的文件，把该项目game_manager/priv/docroot/ 下的文件复制到www文件夹下

8.重启yaws，在yaws控制台中执行gm:init().初始化数据库

9.打开浏览器，输入：http://127.0.0.1:8080/

10.输入账户密码：userName:123 pwd:123
