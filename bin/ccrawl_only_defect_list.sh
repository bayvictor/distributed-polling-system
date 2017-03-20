#!/bin/bash  

##!/bin/bash -x 
#test1.txt is defect file  
  if [ ! -e "all.sh" ]       # Check if filename exists.
  then
    echo "\"all.sh\" does not exist in current dir! copy it over!."; echo
    exit                # On to next.
   fi


echo "echo \"starting downloading...\"" > redown.sh

echo "make sure all.sh also in current dir!"
echo "usage: $0 <defect_filenamelist>"
echo "e.g.: $0 test1.txt"
echo "^C to break, anykey to rescript it!";read readline
cat $1 | cut -d":" -f2|cut -d" " -f2 | sed 's|^|grep |g;s|$| ./all.sh >> redown.sh |g' > test2.txt 
cat $1 | sed 's/^/echo \"/g;s/$/\";/g' >test0.txt

#cat test1.txt | sed 's|^|grep |g;s|$| ../all.sh >> redown.sh |g' > test2.txt 
#cat test1.txt | sed 's/^/echo \"/g;s/$/\";/g' >test0.txt

paste test0.txt test2.txt | sed '$d' > rescript.sh
# cat defect-filelist.txt | sed 's|^|grep |g;s|$| ../all.sh >> redown.sh |g' >rescript.sh

vi rescript.sh
chmod +x *.sh

echo "^C to break, anykey to rescript it!";read readline
./rescript.sh

echo "result in redown.sh, re-run it!"
chmod +x *.sh
./redown.sh

