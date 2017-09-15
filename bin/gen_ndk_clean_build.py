#!/usr/bin/python
import os
import sys
from time import strftime


def pathvalue_in_env( env_name , token_prog ):
    matched_path = "$HOME";
    if (os.environ.has_key( env_name)):
        matched_path = os.environ[env_name];
        print("Using Android NDK from env_name (\"%s\")" % matched_path)

    if (not matched_path):
#        pipe = os.popen("which ndk-build")
        pipe = os.popen("which "+ token_prog )
        tmp = str.strip(pipe.readline(), "\n")
        while(not tmp):
            tmp = str.strip(pipe.readline(), "\n")
        pipe.close()
        matched_path = os.path.split(tmp)[0]
        print("Using Android NDK from PATH (\"%s\")" % matched_path)
    return matched_path


def compile():
    ANDROID_SDK_PATH = "/opt/android-sdk-linux"
    ANDROID_NDK_PATH = None
    INSTALL_DIRECTORY = None
    CLASS_PATH = None
    TMP_HEADER_PATH="tmp_include"
    HEADER_EXTS = set(['h', 'hpp'])
    SYS_INCLUDES = ["platforms/android-8/arch-arm/usr/include", "sources/cxx-stl/gnu-libstdc++/include", "sources/cxx-stl/gnu-libstdc++/libs/armeabi/include"]
    
    PROJECT_NAME = "OpenCV-branch"
    TARGET_LIBS = ["libopencv_java.so"]
    ARCH = "armeabi"
    GCC_OPTIONS = "-fpermissive"
    EXCLUDE_HEADERS = set(["hdf5.h", "eigen.hpp", "cxeigen.hpp"]);
	
    ANDROID_NDK_PATH = pathvalue_in_env ("NDK_ROOT", "ndk-build" )
    ANDROID_SDK_PATH = pathvalue_in_env ("ANDROID_SDK_ROOT", "adb" )
    AN__PATH = pathvalue_in_env ("ANDROID_ROOT", "android" )
    print("Using Android SDK (where has \"adb\" from \"%s\"" % ANDROID_SDK_PATH)
    print("Using AN__PATH (where has \"android\" from \"%s\"" % AN__PATH)


    if (not os.path.exists(TMP_HEADER_PATH)):
            os.makedirs(os.path.join(os.getcwd(), TMP_HEADER_PATH))

    print("Generating JNI headers for Java API ...")
    AndroidJavaDeps = os.path.join(ANDROID_SDK_PATH, "platforms/android-11/android.jar")



    allCodeFiles = os.popen(" find | grep -e 'jni\/Android.mk$'| sed 's|/jni/Android.mk|/|g'").read().split('\n')
    allLprjFolders = os.popen("find . -name '*.Android.mk'").read().split('\n')
    
    fnum = len(allCodeFiles)
    ndk_build_cmd = ""
    for ii in range(0, fnum):
        if os.name == 'nt': # Windows
            basePath = 'C:\\working\\'
            ndk_build_cmd = "ndk-build.cmd"            
        else:
            basePath = '/working/'
            ndk_build_cmd = "ndk-build"



        cmd = "unset NDK_PROJECT_PATH;export  NDK_PROJECT_PATH="+ allCodeFiles[ii] +";"+ ANDROID_NDK_PATH + "/"+ndk_build_cmd+";\n"
        print "cmd=("+cmd+")\n"    
        os.system(cmd)

    print '\n===============================\found!\n===============================\n'
    print allCodeFiles

    print '\n===================== finished ===============================\n'
def preinstall_main():
    print "preinstall_main()!\n"
    os.system("sudo apt-get install libc6-dev-i386 ")
    os.system("sudo apt-get install  lib32ncurses5 lib32z1 ")




if __name__ == '__main__':
    print '\n\nusage: Copy this python file to your xcode project directory and just execute it.\n\n'
    preinstall_main()
    compile()
