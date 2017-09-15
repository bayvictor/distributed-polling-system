unset TS
TS=`date +%Y%b%d:%H:%M`


treesubdir.sh | sed -e 's|\-master$||g' >test01.txt

cat test01.txt |sed 's/^/echo unzipping \"/g;s/$/\";/g' > test011.txt;  #'

cat test01.txt |sed 's/^/cd \"/g;s/$/\";/g' > test012.txt;  

cat test01.txt |sed 's|^|/home/vhuang/bin/curdir_unzip.sh;/home/vhuang/bin/subdir_github_android_build.sh |g;s/$/ ${TS};cd \$CURDIR;/g' > test013.txt 
echo "unset CURDIR;CURDIR=\$PWD" > buildall.sh 
echo "TS=${TS}" >>buildall.sh
paste test011.txt test012.txt  test013.txt >> buildall.sh

   chmod +x buildall.sh 
   ./buildall.sh
