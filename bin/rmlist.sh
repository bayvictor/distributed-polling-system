echo "usage:$0 <list_to_be_remove>"
echo "e.g.: $0 ~/rmlist.txt"

#cat ~/test.txt|cut -d":" -f2|cut -d" " -f2|sed 's/^/rm -fr /g' >~/rmlist.sh
cat $1 |cut -d":" -f2|cut -d" " -f2|sed 's/^/rm -fr /g' >~/rmlist.sh
chmod +x ~/rmlist.sh

echo "^c to break, any key to contine....";read readline
vi ~/rmlist.sh
echo "^c to break, any key to contine....";read readline
~/rmlist.shh
echo "^c to break, any key to contine....";read readline
