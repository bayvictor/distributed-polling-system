 tree -d -L 1|cut -d" " -f2|sed '1d;$d'|sed '$d'|sed 's/^/cd /g;s/$/;git pull;cd ../g'

