  tree -d -L 1|cut -d" " -f2|sed 's/^/tar -zcf /g;s/$/\.tgz /g' > test02.txt
  paste test02.txt test01.txt|sed '1d;$d'|sed '$d'


