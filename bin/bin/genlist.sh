#!/bin/bash

echo "usage: $0 <fileext>"
echo "e.g.:
    $0 csv
"

#echo "^C to break, anykey to continue...";read readline
echo "running $0 $1 $2 $3....  waiting...."

unset outfn
unset outfn2
export outfn="list_$1.txt" 
export outfn2="list_$1_desc.txt"
 
locate "$1" |grep -e "\.$1$" > $outfn 

cat "$outfn"  | xargs ls -lSh > "$outfn2"
#rm "$outfn"
 
