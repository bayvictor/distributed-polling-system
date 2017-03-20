find|grep -e "\/.*\/">test.txt
cat test.txt|sed 's/^/ \"/g;s/$/\"/g' > test01.txt
cat test01.txt | sed 's/^/norm.sh /g' > /tmp/test.sh
chmod +x /tmp/test.sh
/tmp/test.sh
/tmp/test.sh|sed 's/^\._//g;s/^/ \"/g;s/$/\"/g' > test02.txt
paste test01.txt test02.txt|sed 's/^/mv /g'>/tmp/rename_all.sh
chmod +x /tmp/rename_all.sh 
/tmp/rename_all.sh



