export ECDIR='/home/vhuang/src/eclipse' 
export PATH=$PATH:${ECDIR}

CURDIR=$PWD
export TLDIR=${HOME}/src/android-sdk-linux_x86/tools/
export CLIDIR=${HOME}/src/cling/UpnpBrowser-101103
cd ${CLIDIR}

# redo tagging for accurate tag-search inside emacs
rm TAGS
find | grep -e '\.java$'| xargs etags -a

mvn install  # re-compile the Samsung-android client code
cp ${CLIDIR}/target/upnp-browser-1.0-alpha6.apk $TLDIR
cd ${TLDIR}
#run "adb shell ls data/app" to findout id for "adb shell rm" as below-line
adb shell rm data/app/org.teleal.cling.android.browser.apk
adb install ${TLDIR}/upnp-browser-1.0-alpha6.apk

sudo cp ${TLDIR}/upnp-browser-1.0-alpha6.apk '/usr/share/tomcat6/webapps/default_root/unp-browser-1.0-alpha6.apk' 
cp ${TLDIR}/upnp-browser-1.0-alpha6.apk '/usr/local/apache2/htdocs/upnp-browser-1.0-alpha6.apk' 
sudo chmod 777  /usr/share/tomcat6/webapps/default_root/unp-browser-1.0-alpha6.apk

cd $CURDIR
