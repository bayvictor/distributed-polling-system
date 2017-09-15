
sudo apt-get remove ibus -y 

sudo apt-get remove fcitx* -y #@（如不需保留配置文件用purge）
sudo apt-get autoremove -y #（自动卸载依赖软件）
sudo dpkg –get-selections | grep fcitx #（查询fcitx相关的软件包是否卸载）
echo  "2.两种方法安装

2.1通过软件源（推荐）
"

sudo add-apt-repository ppa:fcitx-team/nightly
sudo apt-get update -y 
sudo apt-get install -y fcitx-sogoupinyin


sudo apt-get install -y fcitx-bin 
sudo apt-get install -y fcitx-config-common 
sudo apt-get install -y fcitx-config-gtk 
sudo apt-get install -y fcitx-data 
sudo apt-get install -y fcitx-frontend-gtk2 
sudo apt-get install -y fcitx-frontend-gtk3 
sudo apt-get install -y fcitx-frontend-qt4 
sudo apt-get install -y fcitx-googlepinyin 
sudo apt-get install -y fcitx-libs 
sudo apt-get install -y fcitx-module-dbus 
sudo apt-get install -y fcitx-module-x11 
sudo apt-get install -y fcitx-modules 
sudo apt-get install -y fcitx-pinyin 
sudo apt-get install -y fcitx-table 
sudo apt-get install -y fcitx-table-wubi 
sudo apt-get install -y fcitx-ui-classic 

echo "sudo im-switch-s fcitx-z default 
"

sudo im-switch-s fcitx-z default
echo "Step Six:
Log off or restart will take effect
In the upper right corner of the input settings
"Input Method" ==> Sogou Pinyin
Or input method "Configuration" settings
This page is not safe pagedown input method or pageup, but the plus button with the minus key (in fact, without shift)

"

echo "^C to break, anykey to continue..."; read readline




