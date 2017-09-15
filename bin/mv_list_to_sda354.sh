#!/bin/bash

# it mv files with xxxM filesize descendingly to curdir 

echo "usage: $0 <from_dir> <size_unit[K/M/G]>"
echo "e.g.: $0 ~/Downloads [0-9][0-9][0-9]M"
echo "^C to break, anykey to continue"
read read_line
export grep_parm="[0-9]"$2"\]";


tree $1 -f -L 2 -s -h |grep $2 | cut -d"[" -f2-99 | sort -g -u -r > /sda354/Downloads/Download_hugefile_list.txt


echo "sed_part=$sed_part"
mkdir ../tmp
echo "#!/bin/bash" > ../tmp/list3.txt.sh
echo "# it mv files with xxxM filesize descendingly to curdir" >>  ../tmp/list3.txt.sh
echo "export pp2=\"$1\"" >>  ../tmp/list3.txt.sh
echo "export grep_parm=\"$2\"" >>  ../tmp/list3.txt.sh

cat /sda354/Downloads/Download_hugefile_list.txt | cut -d']' -f2 > ../tmp/list0.txt

cat ../tmp/list0.txt | sed -e 's/^\s*/mv \"/g;s/$/\"/g' > ../tmp/list1.txt

cat ../tmp/list0.txt | sed -e 's/^\s*/echo \"wait for moving:...\n/g;s/$/\"; /g' > ../tmp/list10.txt
cat ../tmp/list0.txt | normalize_path.sh > ../tmp/list2.txt
paste  ../tmp/list10.txt   ../tmp/list1.txt ../tmp/list2.txt >>  ../tmp/list3.txt.sh  

echo "^C to break, anykey to vi ../tmp/list3.txt.sh "
read read_line
vi ../tmp/list3.txt.sh
chmod +x  ../tmp/list3.txt.sh
echo "^C to break, anykey to run \"nohup ../tmp/list3.txt.sh\" "
read read_line


nohup   ../tmp/list3.txt.sh

