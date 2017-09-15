# cat ~/defect_list.txt|cut -d":" -f2|cut -d" " -f2 |sed 's/^/mv /g;s|$| /sds/new_ccawl_nov2015 |g' >~/mvall.sh
echo "usage:  $0 <defect_filename> <new_drive_path>"
echo "e.g.: $0 ~/defect_list.txt /sds/new_ccawl_nov2015"

echo "^C to break, anykey to continue...";read readline

cat $1 |cut -d":" -f2|cut -d" " -f2 |sed "s/^/mv /g;s|$| "$2" |g" >~/test00.txt 
cat ~/test00.txt |sed 's/^/echo \"/g;s/$/\";/g' >~/test01.txt
paste ~/test01.txt ~/test00.txt > ~/mvall.sh
chmod +x ~/*.sh
chmod +x *.sh
cat ~/mvall.sh  |head
vi ~/mvall.sh

echo "^C to break, anykey to continue...";read readline
~/mvall.sh



