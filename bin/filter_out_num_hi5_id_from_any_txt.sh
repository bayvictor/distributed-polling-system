# cat test.txt|grep 0|tr ' ' '\n'|grep -e "^[0-9]"
echo "usage:$0 <txt_filename>"
echo "e.g."
echo "$0 test.txt"
echo "^C to break, anykey to continue...";read readline
chmod +x ~/bin -R 
chmod +x *.sh
$0 $1  >$1.id.txt  
