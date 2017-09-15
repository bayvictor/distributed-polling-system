docker images -a |grep -e '^.none' |sed 's/  */ /g' |cut -d' '  -f3|sed 's/^/docker rmi -f /g'
