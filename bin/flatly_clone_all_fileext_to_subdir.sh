#!/bin/bash
echo "usage:$0 <from_dir> <to_flat_dir> <fileext>"
echo "   e.g.: "
echo "$0 git gitflat ui"
echo "^C to break, any key to proceed to clone"
read read_line

mkdir $2
cd $2
find ../$1 | grep -e "\.$3$" > old_ui_list.txt
cat old_ui_list.txt | sed 's/[^0-9a-zA-Z_\.]/__/g;s/^\.\.__//g'>new_ui_list.txt
cat old_ui_list.txt | sed 's/^/cp /g' > cp_old_ui_list.txt
cat old_ui_list.txt | sed 's/^/\"/g;s/$/\"/g;s/^/cp /g;s/$/ /g' > cp_old_ui_list.txt
clone_sh="cloned_"$3"__from_"$1"_to_"$2"-"`timestamp`".sh"
paste cp_old_ui_list.txt new_ui_list.txt > ${clone_sh}
chmod +x  *.sh

./${clone_sh}
echo "^C to break, any key to proceed to do \"cp ./${clone_sh} ~/diary\""
read read_line

cp ./${clone_sh} ~/diary
echo "finished clone file ./${clone_sh} and cp to ~/diary"
