cd $1 
curdir_unzip.sh
subdir_find__AndroidManifest.xml_and__android_update__path_targetId_subprojects.py android-18
find |grep -e "res\/values\/strings\.xml$">sedlist.txt 

TS=`date +%Y%b%d:%H:%M`
if test "a$2"=="a"; then
  TS=`date +%Y%b%d:%H:%M`
  echo "please pass also \$2=={`date +%Y%b%d:%H:%M`=\`date +%Y%b%d:%H:%M`\} with timestamp!"
  exit 1
fi


#cat sedlist.txt|xargs sed -ie "s|\-master.*<|<|g" 
cat sedlist.txt|xargs sed -ie "s|<string name\=\"app_name\">EncoRecruter.|<string name=\"app_name\">EncoRecruiter.$TS.$1|g" 
cat sedlist.txt|xargs sed -ie "s|<string name\=\"app_name\">|<string name\=\"app_name\">EncoRecruiter\n$TS\n$1|g" 

find|grep -e "strings\.xmle$" | xargs rm -fr 

#ant debug
find |grep -e "res\/values\/strings\.xml$" | xargs grep app_name
 


