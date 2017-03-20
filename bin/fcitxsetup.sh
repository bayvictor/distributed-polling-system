green='\e[0;32m'
endColor='\e[0m'
echo -e "${green}Instaull Sogou Pinyin\n${endColor}"


sudo apt-get install -y fcitx fcitx-pinyin fcitx-sunpinyin fcitx-googlepinyin fcitx-anthy fcitx-mozc


sudo add-apt-repository ppa:fcitx-team/nightly
sudo apt-get update #更新一下源

sudo apt-get install -y fcitx fcitx-bin fcitx-config-common fcitx-config-gtk2 fcitx-data fcitx-frontend-gtk2 fcitx-frontend-gtk3 fcitx-frontend-qt4 fcitx-frontend-qt5 fcitx-libs fcitx-libs-gclient fcitx-libs-qt fcitx-libs-qt5 fcitx-module-dbus fcitx-module-kimpanel fcitx-module-x11 fcitx-modules fcitx-table fcitx-ui-classic libopencc1  #安装fcitx
sudo dpkg -i sogoupinyin_1.2.0.0042_amd64.deb #安装sogou_pinyin
echo "完成，按回车键继续"

sudo apt-get install -y --force-yes im-config #- Input method configuration framework

sudo apt-get install  -y --force-yes fcitx fcitx-config-gtk fcitx-sunpinyin fcitx-googlepinyin fcitx-module-cloudpinyin  fcitx-sogoupinyin
sudo apt-get install  -y --force-yes fcitx-table-all
sudo apt-get install  -y --force-yes  im-switch

echo -e "${green}Instaull Vim\n${endColor}"
sudo apt-get install vim

echo -e "${green}Instaull git\n${endColor}"
sudo apt-get install git

echo -e "${green}Instaull pip\n${endColor}"
sudo apt-get install python-pip python-dev build-essential 

im-switch -s fcitx -z default
sudo im-switch -s fcitx -z default


#Use a terminal (Ctrl + Alt + T) or a Run dialogue (Alt + F2) to run: im-config

im-config

