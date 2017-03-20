echo "大部分 Linux 发行版在默认情况下，是不支持中文字符按照拼音排序的。对于软件开发而言，如果需要服务器端针
对中文排序，很可能会因此难以实现。解决这个问题的方法很简单，只需要在 Linux 系统上安装一个 locale­pinyin
的软件包，并配置好相应的系统环境变量，就能够让 Linux 系统完美地支持中文的拼音排序。
对于 Ubuntu 用户，如果之前没有配置 ubuntu­cn 的源的话，需要配置一下 apt 源。例如使用 cn99.com 的设置：
"

#deb http://ubuntu.cn99.com/ubuntu-cn/ gutsy main restricted universe multiverse
deb http://ubuntu.cn99.com/ubuntu-cn/ xenial main restricted universe multiverse
echo "然后运行
"
sudo apt-get upgrade -y
sudo apt-get install -y locale-pinyin
echo "open new terminal following below instruction line by line"

echo "再编辑 /etc/environment 文件，添加或者修改：
LC_COLLATE=\"zh_CN.UTF-8\"
对于其他 Linux 用户，可以 下载 locale­pinyin，然后解压编译安装。命令如下：
tar xzf locale-pinyin.tar.gz
cd locale-pinyin
./configure
make
make install
然后编辑 /etc/profile 或者 ~/.profile，如同 Ubuntu 用户一样
export LC_COLLATE=\"zh_CN.UTF-8\"
完成安装、修改之后，重启 X Window 或者注销用户，重新登录系统，以上修改即完全生效。
"

