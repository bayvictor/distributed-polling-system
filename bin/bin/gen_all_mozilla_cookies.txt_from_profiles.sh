#/usr/bin/bash -x
cd $HOME/.mozilla/firefox
sudo apt-get install sqlite -y 
mkdir _txt_cookies
rm _txt_cookies/* -fr

find |grep -e "cookies.sqlite$" >listof.cookies.sqlites.txt
cat listof.cookies.sqlites.txt |grep -v default>nodefaults.txt
cat listof.cookies.sqlites.txt |grep default >defaults.txt
cat nodefaults.txt |sed 's/[^0-9a-zA-Z]/_/g;s|_cookies_sqlite$||g;s|^ *__||g;s|^ *||g' > test02.txt

head="sqlite3 \-separator \$\'	\' "
tail=" \'select CASE \"isHttpOnly\" WHEN \"0\" then \"\" else \".\" END \|\| basedomain, CASE \"isHttpOnly\" WHEN \"0\" then \"FALSE\" else \"TRUE\" END, path, CASE \"issecure\" WHEN \"0\" then \"FALSE\" else \"TRUE\" END, expiry, name, value from moz_cookies;\' > _txt_cookies\/"


cat nodefaults.txt | sed -e "s|^|$head|g" | sed -e "s|$|$tail|g;s| *$||g;s|\s*$||g"  >test03.txt
paste test03.txt test02.txt |sed 's|$|\.txt |g;s|_txt_cookies/   |_txt_cookies/|g' |sed  's|\/\t|\/|g' > runall.sh 
chmod +x *.sh
vi runall.sh
echo "^C to break, anykey to continue...";read readline
./runall.sh
 
