k源里面没有tor,但是有vidalia和privoxy

配置过程也是糊里糊涂的。

1. 运行 sudo apt-get install -y libevent-dev libssl-dev

2. 网上搜索并下载linux版本的tor

3. 然后配置，编译，安装tor(./configure make make install)

4. ubuntu 软件中心里面搜索并且安装vidalia和privoxy以及torbutton extension for firefox

5. 发标题为get bridges的邮件到bridges@torproject.org，一会儿回收到邮件。

6. 打开应用程序->internet下的vidalia，配置下tor的路径，修改为/usr/local/bin/tor

7. 还是vidalia下，点击设定->网络，选择我的ISP阻挡了对Tor的连接，然后在下面将邮件里面的数据一条条复制进去。

8.修改privoxy配置文件，打开/etc/privoxy/config文件，顶部加入：forward-socks4a / localhost:9050 . 注意有个点(.)

9. 运行/usr/sbin/privoxy

10.运行vidalia，应该可以正常连接到tor网络了。

11. 打开firefox，点击右下角的tor被禁用，立刻会变成tor运行中

好了，可以带套上网了,配置过程有些反复，大致过程就是这样了，有错误请提出
forward-socks4a / localhost:9050 .
Filed under: iShare — Tristan @ 15:39 Comments (4) 本文短网址：http://sino.me/q Tweet me! 