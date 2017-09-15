#!/bin/bash
# renaming files 1(xxx) into correct filename which is the searched keyword 
#   -- by parsing it's content and get the right word!

# cd working_dir, where only contains ora_search files, elso will mess up paste
# order and get it wrong

temp="../temp-"`date +%F-%T|sed 's|:|-|g'|sed 's|/|-|g'`
rm -fr ../${temp} 
mkdir ../${temp}

 find| grep -v '^\.$'|  sed 's|^|mv \"|g;s|$|\"|g' > ../${temp}/seg01.txt



find| grep -v '^\.$'| xargs cat -n  |grep -i -e "\<label\>"|grep -e value|grep "id=\"q\"" |sed 's/value=\"/@/g'|cut -d'@' -f2|cut -d'"' -f1 | sed 's|^| \"|g;s|$|\.__\.html\"|g'  > ../${temp}/seg02.txt

paste ../${temp}/seg01.txt ../${temp}/seg02.txt > ../${temp}/rename_all.sh
chmod +x ../${temp}/*.sh

../${temp}/rename_all.sh

rm -fr ../${temp} 


