 df -h | cut -d"%" -f2|cut -d" " -f2|sed '1,8d'|tr '\n' ' ' |sed 's/$/\n/g'

