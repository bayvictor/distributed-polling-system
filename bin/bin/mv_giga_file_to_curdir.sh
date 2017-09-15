#!/bin/bash
echo "usage: $0 <from_dir> <size_unit[K/M/G]>"
echo "e.g.: $0 ~/Downloads G"
echo "^C to break, anykey to continue"
read read_line
export grep_parm="[0-9]"$2"\]";


tree $1 -f -L 2 -s -h |grep $2 > /sda354/Downloads/Download_hugefile_list.txt

#tree $1 -f -L 2 -s -h |grep "[0-9]G\]" > /sda354/Downloads/Download_hugefile_list.txt

cat  /sda354/Downloads/Download_hugefile_list.txt

pp2=`echo $1|sed 's/\//\\\//g'`;
sed_part="s/^/mv \\\""$pp2"/g;s/$/\\\"/g";
echo "sed_part=$sed_part"
mkdir ../tmp
#cat /sda354/Downloads/Download_hugefile_list.txt | grep -e "\/.*\/" | cut -d"/" -f3-9|cut -d']' -f2 | sed $sed_part > ../tmp/list1.txt
echo "#!/bin/bash" > ../tmp/list3.txt.sh

echo "export pp2=\"$1\"" >>  ../tmp/list3.txt.sh
echo "export grep_parm=\"$2\"" >>  ../tmp/list3.txt.sh


cat /sda354/Downloads/Download_hugefile_list.txt | grep -e "\/.*\/" | cut -d"/" -f3-9|cut -d']' -f2 > ../tmp/list0.txt 
cat ../tmp/list0.txt | sed 's/^/mv \"/g;s/$/\"/g' > ../tmp/list1.txt
cat ../tmp/list0.txt | sed 's/^mv //g;s/ $//g'|sed 's/\//__/g;s/[\" ]/_/g;s/_$//g;s/^/ /g' > ../tmp/list2.txt
paste  ../tmp/list1.txt  ../tmp/list2.txt >>  ../tmp/list3.txt.sh

echo "^C to break, anykey to vi ../tmp/list3.txt.sh "
read read_line
vi ../tmp/list3.txt.sh
chmod +x  ../tmp/list3.txt.sh
echo "^C to break, anykey to run \"nohup ../tmp/list3.txt.sh\" "
read read_line


nohup   ../tmp/list3.txt.sh

