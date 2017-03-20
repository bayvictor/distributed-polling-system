
export  NDK_ROOT=android-ndk-r8c
export PATH=${NDK_ROOT}:/home/$USER/adt-bundle-linux/sdk/tools:/home/$USER/adt-bundle-linux/sdk/platform-tools:/home/$USER/adt-bundle-linux/eclipse:$PATH 

android update project --path . --target "android-17" --subprojects 
ant debug

find | grep -e "\.apk$" | grep -v "unsigned"  | grep -v "debug-unaligned"


