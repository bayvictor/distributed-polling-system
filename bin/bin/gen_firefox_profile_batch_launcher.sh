CURDIR=$PWD

cd /home/vhuang/.mozilla/firefox

  ls|tr '\t' '\n'|sed 's/^.*\.//g' > ../test01.txt
  cat ../test01.txt |sed 's/^/echo \"/g;s/$/\";/g' > ../test02.txt
 
  cat ../test01.txt |sed 's|^| firefox http://www.hi5.com/apps/pets.html?dataSource=Pets&ll=nav#home  -no-remote -P |g;s|$| \& |g;s|$|;echo "^C to break, anykey to next profile...";read readline;|g'>../test03.txt
  paste ../test02.txt ../test03.txt >serial_batch_launch_profile.sh
  chmod +x *.sh
  echo "sample head lines:"
  cat serial_batch_launch_profile.sh |head
  echo  "....;    tail lines:"
  cat serial_batch_launch_profile.sh |tail
   
 echo "^C to break, anykey to return to old dir place....";read readline

cd $CURDIR





