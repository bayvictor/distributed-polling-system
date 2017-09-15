echo "usage: $0 <copied_to_path>"
echo "e.g.: $0 /sdo5/google21 "
 
  ls -ltr |grep "+">test.txt ;   ## move the oldest line first 

  cat test.txt|cut -d":" -f2|cut -d" " -f2|sed 's/^/mv /g;s|$| '$1' |g' > mvall.sh
  #cat test.txt|cut -d":" -f2|cut -d" " -f2|sed 's/^/mv /g;s|$| /sdo5/google21/ |g' > mvall.sh
  cat mvall.sh |sed 's|^|echo \"|g;s|$|\";|g' >test01.txt
  paste test01.txt mvall.sh >moveall.sh
  chmod +x moveall.sh 
  ./moveall.sh 

