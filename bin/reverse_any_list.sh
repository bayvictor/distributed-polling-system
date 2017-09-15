echo "$0 <any_file.txt>"
echo "e.g.     $0 mvlist.txt"
echo ""
echo "^C to break, anykey to continue..."; read readline 

cat $1 -n | sort -g -k 1 -r | sed 's|mv .|@mv .|g' | cut -d'@' -f2

 
