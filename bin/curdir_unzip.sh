#!/bin/bash -x 
CURDIR=$PWD
echo "echo \"starting unzipping...\";">list01.txt
mkdir zips;mkdir unzip;  tree -f -L 1|grep -e "\.zip$"|cut -d" " -f2 |sed 's/^/unzip -x -q -o \./g'>>list01.txt
#mv *.zip zip
cat list01.txt|sed 's/^/echo \"/g;s/$/\";/g' > list02.txt
paste list02.txt list01.txt >list.txt 
cp list.txt unzip/go.sh;cd unzip;
chmod +x *.sh
#gedit go.sh &

#echo "^C to break, anykey to continue...";read readline ;
./go.sh

tree -d -L 1
cd $CURDIR
 
