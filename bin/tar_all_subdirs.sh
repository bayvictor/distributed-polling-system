
tree -d -L 1|cut -d" " -f2 | sed '1d;$d;$d' > test01.txt
cat test01.txt |sed 's/^/tar -zcvf /g;s/$/\.tgz /g'
cat test01.txt |sed 's/^/tar -zcvf /g;s/$/\.tgz /g'>test02.txt
paste test02.txt test01.txt >test03.txt.sh
chmod +x *.sh
vi test03.txt.sh 
./test03.txt.sh

