export CLIDIR=${HOME}/src/cling/UpnpBrowser-101103
cd $CLIDIR
export SVCDIR=${CLIDIR}/src/main/java/org/teleal/cling/android/browser
cd ${SVCDIR}


cat ${SVCDIR}/SwitchPower.java | sed 's/SwitchPower/Call/g' > ${SVCDIR}/Call.java
cat ${SVCDIR}/SwitchPower.java| sed 's/SwitchPower/Migrate/g' > ${SVCDIR}/Migrate.java

## switch CELL/Video on/off for single service test!
cat ${SVCDIR}/DemoActivity.java| sed 's/GalaxySvideo2TV/Migrate/g;s/CellCallOnGalaxyS/Call/g' > ${SVCDIR}/DemoActivity.java.mid
#cat ${SVCDIR}/DemoActivity.java| sed 's/SwitchPower/Call/g' > ${SVCDIR}/DemoActivity.java.mid
cp ${SVCDIR}/DemoActivity.java.mid ${SVCDIR}/DemoActivity.java
rm ${SVCDIR}/DemoActivity.java.mid

#above is the based-line for making new services, using SwitchPower.java as the template
#-- 1. after above (cell../Galax..).java file generated, it auto-integrate into the maven2 project framework;
# -- 2. So just modify the service call and don't bother with anything else!

source ~/bin/browser-upnp-build.sh

cd $CLIDIR

echo "rm ${SVCDIR}/CellCallOnGalaxyS.java?,^c to break, anykey to proceed..."
read read_line
rm ${SVCDIR}/CellCallOnGalaxyS.java
echo "rm  ${SVCDIR}/GalaxySvideo2TV.java? ^c to break, anykey to proceed..."
read read_line
rm  ${SVCDIR}/GalaxySvideo2TV.java
