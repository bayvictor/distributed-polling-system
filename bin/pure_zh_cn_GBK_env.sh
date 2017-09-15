echo "解决�i"

sudo apt-get purge locales -y 
sudo apt-get autoclean -y 
sudo apt-get install locales -y 

cd /usr/share/locales

sudo ./install-language-pack en_US.UTF-8
sudo ./install-language-pack zh_cn.GBK 

sudo dpkg-reconfigure locales

#修复完�i



#设置后，使用zh_CN.GBK中文locale：

# export LC_ALL=zh_CN.GBK
# locale
LANG=zh_CN.UTF-8
LC_CTYPE="zh_CN.GBK"
LC_NUMERIC="zh_CN.GBK"
LC_TIME="zh_CN.GBK"
LC_COLLATE="zh_CN.GBK"
LC_MONETARY="zh_CN.GBK"
LC_MESSAGES="zh_CN.GBK"
LC_PAPER="zh_CN.GBK"
LC_NAME="zh_CN.GBK"
LC_ADDRESS="zh_CN.GBK"
LC_TELEPHONE="zh_CN.GBK"
LC_MEASUREMENT="zh_CN.GBK"
LC_IDENTIFICATION="zh_CN.GBK"
LC_ALL=zh_CN.GBK


sudo dpkg-reconfigure locales

