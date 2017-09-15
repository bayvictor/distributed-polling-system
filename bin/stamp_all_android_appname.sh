TS=`date +%Y%b%d:%H:%M`
find |grep -e "res\/values\/strings\.xml$">sedlist.txt 
cat sedlist.txt|xargs sed -ie "s|\-master.*<|<|g" 
cat sedlist.txt|xargs sed -ie "s|<string name\=\"app_name\">EncoRecruter|<string name=\"app_name\">EncoRecruiter.$TS.$1|g" 

cat sedlist.txt|xargs sed -ie "s|<string name\=\"app_name\">|<string name\=\"app_name\">EncoRecruiter.$TS.\n$1\n|g" 


#cat sedlist.txt|xargs sed -ie "s|[\-\- ]|\n|g" 

 find|grep -e "strings\.xmle$" | xargs rm -fr 


