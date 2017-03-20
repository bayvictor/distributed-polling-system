ls -lSh|cut -d":" -f2 |cut -d" " -f2|sed '1d'|sed '$d'|sed 's/^/adb install -r /g;s|$|;echo "^C to break, anykey to continue";read readline;|g' >go.sh
 chmod +x go.sh

 ./go.sh

