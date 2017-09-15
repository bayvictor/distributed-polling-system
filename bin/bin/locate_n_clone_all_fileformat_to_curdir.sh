#!/bin/bash

TStamp=`timestamp`
list="all_Qt_ui_filelist-"$TStamp".txt" 
locate .ui|grep -e "\.ui$" >$list 

cat $list | sed 's/\//\_/g' > test01.txt

cat $list | sed 's/^/cp /g' > test021.txt
paste test021.txt test01.txt > go.sh
cat go.sh
chmod +x *.sh
echo "will do above content. Continue?(y/n)"
read readline

./go.sh

