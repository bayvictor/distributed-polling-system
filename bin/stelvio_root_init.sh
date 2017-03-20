android.bat  create project --path . --target android-17  -n Stelvio -v 1.8 -g -k com.samsung.msca.stelvio -a StelvioMain
android  create project --path . --target android-17  -n Stelvio -v 1.8 -g -k com.samsung.msca.stelvio -a StelvioMain


cd *Display*

android update project --path . --target android-17 -n StelvioDisplayLib --subprojects
android.bat update project --path . --target android-17 -n StelvioDisplayLib --subprojects

cd *OffScreenHack
android update project --path . --target android-17 -n StelvioOffScreenHack --subprojects
android.bat update project --path . --target android-17 -n StelvioOffScreenHack --subprojects
cd ..
cd *Client
android update project --path . --target android-17 -n StelvioClient --subprojects
android.bat update project --path . --target android-17 -n StelvioClient --subprojects
cd ..
cd *Server
android update project --path . --target android-17 -n StelvioServer --subprojects
android.bat update project --path . --target android-17 -n StelvioServer --subprojects
cd ..

grep Stelvio * -R

find . |grep -e "\.gradle$" | grep -v "\/ORIG_build\.gradle$">list_gradle_update.txt
find . |grep -e "\/gradle-wrapper\.properties$" >> list_gradle_update.txt

# cat list_gradle_update.txt |  xargs sed -i -e 's/$1/$2/g'

cat list_gradle_update.txt |  xargs sed -i -e "s|com.android.tools.build:gradle:1.8.*$|com.android.tools.build:gradle:0.6.+\'|g"
cat list_gradle_update.txt |  xargs sed -i -e "s|com.android.tools.build:gradle:0..*$|com.android.tools.build:gradle:0.6.+\'|g"
cat list_gradle_update.txt |  xargs sed -i -e "s|services.gradle.org/distributions/gradle-1.6-bin.zip|services.gradle.org/distributions/gradle-1.8-bin.zip|g"

cat list_gradle_update.txt |  xargs dos2unix

#tree -d -L 1|cut -d" " -f2|sed '1D' | head -n 4 | sed "s|^|include \':|g;s|$|\'|g" > settings.gradle
 
gradle build
