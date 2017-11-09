  ls -last|grep ">"  > ~/test01.txt
  cat ~/test01.txt|cut -d">" -f1 |sed 's/ 2017 / :ss /g'|sed 's/ 2016 / :ss /g' |cut -d":" -f2 >~/test013.txt
#  vi ~/test013.txt 
  cat ~/test013.txt |cut -d" " -f2 |sed 's/^/~\//g;s/$/ /g;s/^/ /g' >~/test0132.txt
  vi ~/test0132.txt 
  cat ~/test01.txt |cut -d">" -f2  >test3.txt
  cat test3.txt|sed 's/[^0-9a-zA-Z]/_/g'>test32.txt
    cat test32.txt |sed 's|^|mkdir /sdc2/|g' >test33.txt
    cat test32.txt |sed 's|^|mkdir -p /sdc2/disk_backup/|g' >test33.txt
  cat test32.txt |sed 's|^|  /sdc2/disk_backup/|g;s|$| -pfr |g' >test34.txt
   paste test3.txt test34.txt |sed 's/^/cp /g' >cpall.sh
  chmod +x *.sh
echo "^C to break, anykey to continue...";read readline

runecho.sh ./cpall.sh

