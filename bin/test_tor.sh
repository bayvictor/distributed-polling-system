sudo apt-get install -y libevent-dev libssl-dev
echo "
1. install tor

1.1 set source list

/etc/apt/sources.list

view plaincopy to clipboardprint?

   1. deb http://mirror.noreply.org/pub/<b style="color:black;background-color:#ffff66">tor</b> etch main  
   2. deb-src http://mirror.noreply.org/pub/<b style="color:black;background-color:#ffff66">tor</b> etch main  

deb http://mirror.noreply.org/pub/<b style="color:black;background-color:#ffff66">tor</b> etch main deb-src http://mirror.noreply.org/pub/<b style="color:black;background-color:#ffff66">tor</b> etch main

1.2 get key
"
echo "view plaincopy to clipboardprint?"

gpg --keyserver keys.gnupg.net --recv 94C09C7F  
gpg --export 94C09C7F | sudo apt-key add -  

gpg --keyserver keys.gnupg.net --recv 94C09C7F gpg --export 94C09C7F | sudo apt-key add -

echo "1.3 update source"
read read_line

sudo apt-get update

echo "1.4 install libevent1"

echo "http://packages.ubuntu.com/zh-cn/jaunty/libevent1"
sudo apt-get install -y libevent libevent-dev
echo "1.5 install tor"

sudo apt-get tor
echo "2. install privoxy

2.1 sudo apt-get privoxy

2.2 /etc/privoxy/config

view plaincopy to clipboardprint?

   1. forward-socks4a / localhost:9050 .  

forward-socks4a / localhost:9050 .

2.3 restart
"
sudo /etc/init.d/privoxy restart
echo "3. install vidalia (GUI for tor)

3.1 sudo apt-get privoxy vidalia

3.2 get bridges

send a email to : bridges@torproject.org, title is : get bridges

3.3 start vidalia, config bridges

   Setting -> network -> my ISP blocks connection -> add bridges get from torproject

3.4 start tor on vidalia
4. install firefox plugin (TorButton or FoxyProxy)

4.1 TorButton is simple

4.2  Foxproxy is automatic
5. Test your tor

https://check.torproject.org/
6. Problem

6.1 vidalia can not rstart tor, port is used

/etc/init.d/tor stop

Refer:

http://bothlog.com/2009/10/30/ubuntu-9-10-%E5%AE%89%E8%A3%85tor/

http://yisha7.info/2009/11/using-tor-in-ubuntu9-10/"