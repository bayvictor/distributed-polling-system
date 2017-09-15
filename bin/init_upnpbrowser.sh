export CLIDIR=${HOME}/src/cling/UpnpBrowser-101103
cd ${CLIDIR}

mvn clean
rm TAGS
find | grep -e "\.java$" | xargs etags -a
source ~/bin/browser-upnp-build.sh


