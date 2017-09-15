export ECDIR='/home/vhuang/src/eclipse' 
export PATH=$PATH:${ECDIR}

CURDIR=$PWD
export TLDIR=${HOME}/src/android-sdk-linux_x86/tools/
export CLIDIR=${CURDIR}
cd ${CLIDIR}

# redo tagging for accurate tag-search inside emacs
rm TAGS -fr
find | grep -e '\.java$'| xargs etags -a

mvn install  # re-compile the Samsung-android client code
cp ${CLIDIR}/target/*.apk $TLDIR
cd ${TLDIR}
#run "adb shell ls data/app" to findout id for "adb shell rm" as below-line
adb shell rm data/app/org.teleal.cling.android.browser.apk
adb install ${TLDIR}/DLNA-controlpoint-1.0.apk
cp ${TLDIR}/DLNA-controlpoint-1.0.apk /var/www

cd $CURDIR
