echo "#grep -rl oldstr path | xargs sed -i 's/oldstr/newstr/g"   
echo "usage $0 <oldstr> <newstr>"
echo "e.g.:"   
echo "$0 redmine zoicbox"
echo ""

echo "^C to break, anykey to continue...."; read readline 

grep -rl $1 . | xargs sed -i 's/$1/$2/g'   

