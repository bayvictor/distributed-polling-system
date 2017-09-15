
echo "run as root!"

echo "^C to break, anykey ton continue..."; read readline;

echo "
root@vhuang-Aspire-5552:/sda8/home/vhuang/Documents/bigdata/sogou# ls /usr/share/fcitx/pinyin/*.mb|tr '\t' '\n'|sed 's|^|mkdir /usr/share/fcitx/pinyin/backup;cp |g;s|$| usr/share/fcitx/pinyin/backup |g'
"
mkdir /usr/share/fcitx/pinyin/backup;cp /usr/share/fcitx/pinyin/pybase.mb usr/share/fcitx/pinyin/backup 
mkdir /usr/share/fcitx/pinyin/backup;cp /usr/share/fcitx/pinyin/pyphrase.mb usr/share/fcitx/pinyin/backup 

echo "root@vhuang-Aspire-5552:/sda8/home/vhuang/Documents/bigdata/sogou# ls /sda8/home/vhuang/Documents/bigdata/sogou/*.mb|tr '\t' '\n'|sed 's|^|cp |g;s|$| /usr/share/fcitx/pinyin |g'
"

cp /sda8/home/vhuang/Documents/bigdata/sogou/pybase.mb /usr/share/fcitx/pinyin 
cp /sda8/home/vhuang/Documents/bigdata/sogou/pyphrase.mb /usr/share/fcitx/pinyin 


cp /sda11/home/vhuang/Documents/bigdata/sogou/pybase.mb /usr/share/fcitx/pinyin 
cp /sda11/home/vhuang/Documents/bigdata/sogou/pyphrase.mb /usr/share/fcitx/pinyin 


