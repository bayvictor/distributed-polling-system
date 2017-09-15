subdirlist.sh >test01.txt  # | grep -ve "^android$" >test01.txt
cat test01.txt |sed 's/^/tar -zcf /g;s/$/\.tgz /g'  >test012.txt  #left side of batch tar 
cat test01.txt | sed 's/^/echo \"now zipping /g;s/$/\";/g' >test011.txt
paste test011.txt test012.txt test01.txt >zipallsubdir.sh 
chmod +x *.sh

echo "will do..." 
cat zipallsubdir.sh  
echo "echo ..."
#./zipallsubdir.sh


