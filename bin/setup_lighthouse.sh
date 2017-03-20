echo "installing  lib32ncurses5 lib32z1 because we are on x86_64 platform"
sudo apt-get install -y ia32-libs
apt-get install -y sun-java6-jdk
echo "#How to compile & create Qt packages for Android.
#Requirements

#    * download and untar QADK from Downloads menu
"
read read_line
      wget http://android-lighthouse.googlecode.com/files/qadk-1.x-2.x-rtti-exceptions.tar.lzma
      tar xvfa qadk-1.x-2.x-rtti-exceptions.tar.lzma

echo " #   * clone android-lighthouse repository
"
      git clone git://gitorious.org/~taipan/qt/android-lighthouse.git 

echo "#Prepare & compile Qt

    * Change in mkspecs/android-g++/qmake.conf, NDK_ROOT variable to point where you untar the qadk, also check ANDROID_PLATFORM variable to be your desire platform, for 1.5 & 1.6 use android-4 and for 2.x use android-5 (android-5 is default).
    * Edit androidconfig.sh, and choose how you want to compile and use Qt, as a shared or static library. You must compile Qt as static library if you want to target android 1.5 platform ( see http://groups.google.com/group/android-qt/browse_thread/thread/e276ce2183b69310 ) 

    * to configure Qt use androidconfig.sh script file
"
read read_line
      ./androidconfig.sh

echo "    * compile Qt !!
"
read read_line

      make -j X

echo "where X is the number of CPU cores+1

    * copy the fonts to device/emulator

      adb push lib/fonts /data/local/qt/lib/fonts
"
read read_line

echo "    * if you compile Qt as share library you must copy qt libs to device/emulator
"
read read_line
      mkdir andlibs
      cp -a lib/*.so* andlibs/
      adb push andlibs /data/local/qt/lib
      rm -fr andlibs

echo "Prepare & compile Qt applications and create Android packages

Before we start let's clarify what is an android application? Android applications are java apps packed into a package. In this package you can also embed one or more (shared) libs which can be loaded from java code and can interact with java using JNI. Currently you can't have a binary application in the package so, qt application, embedded in this bundle, are in fact shared libs.

For more informations about android application architecture, please consult Android Application Fundamentals page.
"
read read_line
echo "I see 3 scenarios to use Qt on Android:
Using Qt to write entire applications for Android

    Using Qt to write entire applications for Android is very easy, you have to have a java application which will load the qt application and start it. 

You don't have to write your own jni<=>java connections , all the magic is done from java by com.nokia.qt package, take a look to examples/android/QtTest/src/com/nokia/qt, (I hope Nokia want sue me because I used this name ;-) ) and from c++ by the android graphics system plugin located to src/plugins/graphicssystems/android. For more informations you can read Qt Android Architecture.

   1. You need to create a Java application. Java application will have only one class which extends QtActivity and in it's constructor to set the application to load (see android/QtTest/src/org/example/qt/QtMain.java). Yes you read it right, that all you need to do in java!!!
   2. You need to create a shared library from you application, you can do this by changing the TEMPLATE variable from your .pro file to lib and CONFIG variable to dll. You don't have to modify anything else in your application. Ex:
"
read read_line
echo "
      TEMPLATE = lib
      CONFIG += dll

   3. Embed the resulted lib into the .apk package or put it to /data/local/lib (using adb push command). The loader will search for library first into /data/local/lib and then into package lib path. 

Using Qt as a platform to write applications for Android

You can use the powerful QtCore, QtXml, QtSvg, QtSql, etc. to help you to write your own libs to help your java part. Here you will have to take care about java <=> jni integration. For example you can use Qt's stl like containers (QVector, QList, etc.).
Using Qt to write standalone applications (not bundled in a package) for Android

The last scenario to use Qt is to use it as a standalone applications, you need to make sure the TEMPLATE variable from your .pro is set to app.

TEMPLATE = app
"

