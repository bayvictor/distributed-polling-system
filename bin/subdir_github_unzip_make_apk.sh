echo "$1";cd $1; mkdir html;mv *.html html;mkdir zips; mv *.zip zips;mkdir unzip;cd unzip; find .. |grep -e "\.zip$" | sed 's/^/unzip -o -q \"/g;s/$/\"/g' >unzipall.sh

chmod +x *.sh
gedit unzipall.sh
./unzipall.sh


~/bin/subdir_find__AndroidManifest.xml_and__android_update__path_targetId_subprojects.py android-17

cd ..

