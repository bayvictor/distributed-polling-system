export NOW=$PWD
unset NDK_PROJECT_PATH;export  NDK_PROJECT_PATH=$PWD;ndk-build
cd $NOW
android update project --path . --target "android-17" --subprojects
ant debug
echo "be careful to pick up the signed apk only to run under jelly bean below:" 
find | grep -v "debug-unaligned" | grep -e "\.apk$"

