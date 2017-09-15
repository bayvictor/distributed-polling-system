#!/bin/bash -x 
#cat test2.txt |cut -d":" -f2|cut -d" " -f2|sed 's/^/rm -fr /g' > rmall.sh
export zip=$1
if  test -z "$zip";  then
 echo "usage: $0 <stuck_zipcode>"
 exit 1  
fi 

ls -lt |grep -e "+" > test.txt
cat test.txt -n |grep $zip
export line_num=`cat test.txt -n |grep $zip|sed -e 's/^\s*//g;s/\t/ /g'| head -n 1 |cut -d" " -f1`
cat test.txt | head -n ${line_num} > test2.txt
cat test2.txt |cut -d":" -f2|cut -d" " -f2|sed 's/^/rm -fr /g' > rmall.sh
chmod +x *.sh
vi rmall.sh
echo "run ./rmall.sh"
echo "^C to break, anykey to continue..."; read readline 
./rmall.sh



export cut_line_num=`cat ../ca.sh -n |grep $zip|sed -e 's/^\s*//g;s/\t/ /g'|cut -d" " -f1`

echo "export DELAY=30" > ../ca_run.sh
 cat ../ca.sh | sed "1,"${cut_line_num}"d" >> ../ca_run.sh


chmod +x ../*.sh
vi ../ca_run.sh

echo "run ca_run.sh?"
echo "^C to break, anykey to continue..."; read readline 

cd ..
./ca_run.sh 




