echo "\nWARNING!!!  \n"
echo "in firefox, using repagnation for pack all code.google.com search in one page, save it here!"
echo "\n"
echo "^C to break, anykey to continue parsing all *.html -- in current dir! ";read readline


cat *.html |sed 's|<a href=|\n|g'|grep -e "^\"" | cut -d'"' -f2 |grep -e "\/$"| grep -e "\/p\/"  > lastlist.txt

cat lastlist.txt |sed -e 's|http://code.google.com/p/||g;s|/$||g' > test0.txt
cat test0.txt|sed -e "s|$|-read-only|g" > test01.txt
cat test0.txt|sed -e "s|$|.googlecode.com/svn/trunk/ |g;s|^|svn checkout http://|g" > test00.txt
paste test00.txt test01.txt >code_goo__downall.sh
chmod +x ./code_goo__downall.sh

./code_goo__downall.sh

