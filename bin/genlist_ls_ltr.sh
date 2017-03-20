ls -ltr|grep +|cut -d":" -f2|cut -d" " -f2 |sed "s/^/mv /g;s|$| /media/vhuang/data/google21 |g" 
 
