#!/bin/bash -x 

echo "usage:$0 <list_fn> <new_dir>"
echo "e.g.: $0 defect_list.txt /sdn/new_sdk_defect/ "
echo "^c to break, anykey when ready";read readline

cat $1|cut -d":" -f2 | cut -d" " -f2 | sed "s|^|mv \\"|g;s|$|\\" $2;|g" >test2.txt
cat test2.txt |sed 's/^/echo \\"doing....\\"/g;s/$/\";g' > test0.txt
paste test0.txt test2.txt >rmall.sh
chmod +x *.sh
echo "generated format:"
cat rmall.sh|head

echo "^c to break, anykey when ready";read readline
vi rmall.sh

echo "^c to break, anykey when ready";read readline


./rmall.sh

