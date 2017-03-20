  tree -d -L 1 -f|cut -d":" -f2 |cut -d" " -f2| sed '$d;$d;1d;s/^/outdirbuild.sh /g'

 


