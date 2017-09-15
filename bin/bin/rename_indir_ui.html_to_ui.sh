#!/bin/bash

echo "we are renaming \"*.ui.html\" into \"*.ui\", please wait..."

ls *.html>list01.txt
cat list01.txt |sed -e 's/\.ui\.html$/\.ui/g' > list02.txt
cat list01.txt | sed -e 's/^/mv \"/g;s/$/\"/g'>list011.txt
cat list02.txt | sed -e 's/[^0-9a-zA-Z\.]/_/g;s/\.ui\.html/\.ui/g;s/\.html$/\.html\.ui/g' > list022.txt
paste list011.txt list022.txt > rename_all.sh
chmod +x *.sh
./rename_all.sh 
