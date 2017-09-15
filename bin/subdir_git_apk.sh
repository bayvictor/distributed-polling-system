echo "entering path=($1), .... waiting...."
cd $1; 
mkdir html;mv *.html html;mkdir zips; mv *.zip zips;mkdir unzip;cd unzip; 

find .. |grep -e "\.zip$" | sed 's/^/unzip -o -q /g' >test01.txt 


THIS_DIR=$PWD

cat test01.txt|sed 's| ..\/| \$PWD\/|g;s/^/echo \"/g;s/$/\";/g' > test02.txt

paste test02.txt test01.txt > unzipall.sh
#gedit unzipall.sh

chmod +x *.sh 
./unzipall.sh

/home/vhuang/bin/curdir_apkmake.sh
#/home/vhuang/bin/subdir_find__AndroidManifest.xml_and__android_update__path_targetId_subprojects.py android-17   

cd $THIS_DIR

cd ../.. 

