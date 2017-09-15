tree  -d -f -L 1|cut -d"/" -f2|cut -d" " -f1|sed '1d;$d'|sed '$d'

