#!/bin/bash

echo "BuildingRhodes
This page describes how to build Rhodes from source with your app on all of our supported platforms: iPhone, RIM Blackberry, Windows Mobile and Android."
read read_line
echo "Contents [hide]
1 Prerequisites - All Platforms
1.1 Required Software
1.2 Setup Rhodes Source
1.2.1 Build rhodes gem from source
1.2.2 Use Rhodes sources directly (without gem)
2 iPhone
2.1 Prerequisites
2.2 Build Application with XCode
2.3 Build and Release on App Store
2.4 Build Application from Command Line
2.4.1 Install Application to device
2.4.2 build.yml settings"
read read_line
echo "3 BlackBerry
3.1 Prerequisites
3.2 Build application using rhodes gem
3.2.1 To build and run using Blackberry simulator
3.2.1.1 Troubleshooting
3.2.2 To build application for the device
3.2.2.1 Troubleshooting
3.2.3 Application log on the device
3.2.4 Connectivity on the device
3.3 Build rhodes from the source code using Eclipse
3.3.1 Known issues with Eclipse build
3.3.2 Rebuilding After Code Changes
3.3.3 Eclipse simulator debug instructions"
read read_line
echo "
4 Windows Mobile
4.1 Prerequisites
4.2 Build application on the command line
4.3 To deploy application on device
4.4 To build from IDE
4.5 Logging
5 Windows emulator
5.1 Prerequisites
5.2 Build application on the command line
5.3 Logging
6 Android
6.1 Prerequisites
6.2 Running Your App from the Command Line
6.3 Building Rhodes.apk from the Command Line
6.4 Building Rhodes.apk in Eclipse
6.5 Installation of the application apk file
6.5.1 Install apk to emulator
6.5.2 Install apk to device
6.5.3 Install standalone apk to device
6.6 Uninstallation of the application
6.6.1 Uninstall from emulator
6.6.2 Uninstall from device
6.7 Getting application log from device or emulator"
read read_line
echo "7 Symbian
7.1 Prerequisites
7.1.1 Prerequisites (FP1)
7.2 Installation instructions
7.2.1 Installation instructions (FP1)
7.3 Build application using rhodes gem [1.0 ONLY -- for 1.1 skip to building symbian from source]
7.3.1 To build and run using Symbian simulator [FP1 SDK]
7.3.2 To build and run using Symbian simulator [FP2 SDK]
7.3.3 To build application for the device
7.4 Build rhodes from the source code
7.4.1 Supported Ant Targets
7.4.2 Carbide.C++ Instructions"
read read_line
echo "8 HOWTO: Customize application name and icon
8.1 iPhone using xCode
8.2 Application Name
8.3 Application Icon
9 HOWTO: Customize Loading image
9.1 iPhone using xCode
9.2 iPhone using rake build
Prerequisites - All Platforms

Required Software"
read read_line
echo "Ruby 1.8.6 or 1.8.7 - http://www.ruby-lang.org/en/downloads/ . For windows use ruby installer"
wget ftp://ftp.ruby-lang.org//pub/ruby/1.9/ruby-1.9.2-p0.tar.gz
tar -zxvf  ruby-1.9.2-p0.tar.gz
cd ruby-1.9.2-p0
./configure
make
sudo make install
read read_line
echo "RubyGems (v1.3.7 or higher) - http://rubygems.org/
GNU make 3.80 or higher (required by gem). Probably you already have it installed if you are running Mac OS X or Linux. On Windows, download it from http://gnuwin32.sourceforge.net/packages/make.htm and install somewhere. Ensure you have location when it installed in your PATH environment variable."
read read_line
wget http://production.cf.rubygems.org/rubygems/rubygems-1.3.7.tgz
tar -zxvf rubygems-1.3.7.tgz
./configure
make
sudo make install

echo "rhodes gem - run \"[sudo] gem install rhodes\" to install the latest rhodes gem"
read read_line
sudo gem install rhodes
echo "JDK version 1.6.0_2 or higher. (recommended version 6.0 update 11) - required for Android & Blackberry
 1.6.0_13 Mac OSX 10.5 (Install then run \"Java Preferences\" utility to change default version)"
read read_line
sudo apt-get install -y openjdk-6-jdk default-jdk

echo " Sun JDK For Windows/Linux NOTE: The 32-bit Windows version is required for Blackberry tools.
Make sure you set JAVA_HOME and that JAVA_HOME/bin is on your path."
read read_line
echo "JAVA_HOME=\"$JAVA_HOME\""
echo "PATH=$PATH"
read read_line
sudo apt-get install -y  lib32ncurses5 lib32z1 libc6-i386 libc6-dev-i386 lib32gcc1  lib32stdc++6

echo "Setup HOME environment variable:
 C:\Documents and Settings\<account_name>
TIP: If you get any \"no such file to load -- something\" messages while running the rake tasks or rhogen commands, this can usually be resolved by running \'[sudo] gem install something\'."
read read_line
echo "Setup Rhodes Source
Clone rhodes github repository (get git at http://git-scm.com if you don\'t have it):next-step will do: \ngit clone git://github.com/rhomobile/rhodes.git"
read read_line
 git clone git://github.com/rhomobile/rhodes.git
 cd rhodes
read read_line
echo "(Optional) Checkout the branch you are interested in (if not master):"
read read_line
 git checkout -f -b <branchname> --track origin/<branchname>
echo "Make sure you\'re up-to-date on the branch:"
 git pull
echo "Add the bin folder to your path. In linux/mac it is typically done via the .profile. In windows it is done via the system control panel.
Configure your environment by running the rhodes-setup script. This will attempt to auto-detect installed SDK\'s and will prompt you to verify them or enter ones that cannot be detected."
read read_line
 rhodes-setup
echo "Build rhodes gem from source
You don't have to do it if you cloned sources, but if you want to build rhodes gem then do following:"
read read_line
 do clean clone
 cd rhodes
 rake gem
 gem install rhodes-[version].gem
echo "Use Rhodes sources directly (without gem)
Set sdk: property in the build.yml (it is in the root folder of your app) to the Rhodes source code root folder."
read read_line

echo "!!!!!! iPhone  !!!!!!!"
read read_line
echo "iPhone versions of Rhodes apps need to be built on Mac machines. The instructions below describe how to do this from either the XCode development environment or from the command line.

Prerequisites
Mac OS X 10.5 (Leopard) or greater (Snow Leopard)
Follow these instructions:"
read read_line
echo "iPhone SDK installed (we recommend the latest stable version available from the iPhone Dev Center"
read read_line
echo "Build Application with XCode"
Note the 'sdk:' value in your build.yml. You will use this in the next step.
Inside the <sdk directory from previous step>/platform/iphone directory is an iPhone XCode project, double-click on it to open XCode.
Open up a command window and switch to your application's directory. Run:
 rake switch_app
This changes your rhobuild.yml in the SDK folder to point to your application.

After you change application code just run 'Build and Go' command in XCode to build for the simulator.
If you want to build for the device, open the 'rhorunner' target and select your code signing information that you installed from the apple developer site and change your active sdk to a device.
Tip: after you make changes and want to see them reflected on the device, reset the simulator and repeat #2.
Tip: to see a log of what is happening on the device, type command-shift-r in xcode to bring up the rhorunner console.
Result application package (*.app) located in <sdk directory>/platform/iphone/build/[Debug/Release]-[iphoneos/iphonesimulator]/rhorunner.app
Build and Release on App Store
Once you have the application building with XCode as described above, it is treated as any other iPhone application when it comes to signing and distributing to the app store.

Build Application from Command Line
Unlike building the application from the XCode GUI, you build the application from command line via the rake command inside the directory of the app you had just generated with rhogen.

Change directory to your rhodes application
Look at the contents of build.yml and verify the following setting for applog.Do not enter full path here, this file will be in your app directory:
 applog: rholog.txt
Run
 rake run:iphone
After application code modification
 exit application in simulator
 rake run:iphone
For build package for install on device use
 rake device:iphone:production
Result package named your application name.app will be placed to <your application folder>/bin/target/iOS/[sdkname]/[your application name].app if you using Rhodes from 2.2.4 version. 
Result package named rhorunner.app will be placed to <sdk directory>/platform/iphone/build/[Debug/Release]-[iphoneos/iphonesimulator]/rhorunner.app if you using Rhodes before 2.2.4 version.

Do not forget set Release configuration when you build package for appStore.

Install Application to device
Use iTunes for install you application package (your application name.app) to device.

open iTunes
select Apps, drag your application package and drop it to Apps screen
connect your device to iTunes
select you device in iTunes
select Apps tab in your device screen
check your application for install to device
do Sync for install your application to device
build.yml settings
The build.yml settings for iphone are the following:

iphone: 
  provisionprofile: 
  sdk: iphonesimulator3.0
  entitlements: 
  codesignidentity: 
  configuration: Debug
  emulator: 3.0
provisionprofile: The UUID of your provisioning profile to use when signing.
sdk: The version of sdk used to build. Typically iphonesimulatorX.X or iphoneosX.X
entitlements: propertylist file for entitlements for your build. Typically is Entitlements.plist
codesignidentity: The name of the code signing identity to use when signing for device.
configuration: Debug/Release
emulator: version of emulator for run application

Example of iPhone setting in build.yml of your application :

iphone: 
  provisionprofile: E5931D39-CA68-48E4-A3AF-BB538E1C8CE6 
  sdk: iphoneos4.1
  codesignidentity: "iPhone Developer: John Smith (MF99RW67WY)"
  entitlements: ""
  configuration: Release
  emulator: 4.1
BlackBerry

Blackberry does require that you be building on Windows. Thus if you did your development on a Mac or Linux you will need to insure that you've installed Ruby on Windows

Prerequisites
Follow these instructions
Blackberry JDE version 4.6.0 and BlackBerry MDS Simulator, http://na.blackberry.com/eng/developers/
Read documentation about Blackberry Browser limitations of CSS, HTML and JavaScript:
http://na.blackberry.com/eng/support/docs/subcategories/?userType=21&category=BlackBerry+Browser Choose Blackberry version and download the documents.

Build application using rhodes gem
Edit build.yml from application directory, set the bbver to the target that you are building for
 bbver: 4.6
To build and run using Blackberry simulator
Run in application root directory
 rake run:bb
Launch application from the simulator's Downloads menu item for 4.6 or from Main menu screen on 4.3 and below.
Do not close Simulator manually. Script will restart simulator for you.
After application code modification:
 rake run:bb
To see application log:
 turn log on: select menu\log\options form application menu. 
Set log level to Info and Message classes to APP or to *.
 BB 4.3 and up: 
 go to <simulator folder>\sdcard\rho\<app_name> and open RhoLog.txt
 you can change log settings by editing rhoconfig.txt (application restart required)
 BB 4.2 and down:  
 Use applog property in build.yml to see the log. Do not enter full path, just log file name, log file will be in your app directory
To turn on Full Browser mode for Blackberry 4.6. Edit rhoconfig.txt :
 use_bb_full_browser = 1
To turn on Persistent Storage usage mode for Blackberry Edit rhoconfig.txt :
 use_persistent_storage = 1
To clean all data(database and log):
 BB 4.3 and up: go to <simulator folder>\sdcard and remove rho folder
 Persistent Storage mode: remove app or run clean.bat in simulator folder
 BB 4.3 and down: run clean.bat in simulator folder
Troubleshooting
run 'rake config:checkbb' and see are any problems reported
Run all rake scripts from windows console. Do not use bash or similar tools
When emulator starts, open Blackberry Internet Browser and browse for some web site. If you are unable to browse:
 check that MDS is running - it should be console window started with emulator.
 open manage connection (blackberry menu button)\check Mobile Network
Check your JAVA_HOME environment variable: it should NOT contain 'bin' at the end
Do not use 'localhost' or '127.0.0.0' for sync source url. Use local computer name instead if you host sync server on your machine.
To build application for the device
You have to sign application before load it to device:
 http://na.blackberry.com/eng/developers/javaappdev/codekeys.jsp
Once you have blackberry certificate files (sigtool.csk and sigtool.db) you should put them in the 'bin' folder of your blackberry jdk and sign any application.
If your target device is Blackberry JDK 4.3 and later, you can provide password in rhobuild.yml file (located in the Rhodes SDK folder) in the 'build' section :
 build:
   bbsignpwd: <password>
Run :
 rake device:bb:production
or

 rake device:bb:debug
Deploy to device:
 by OTA: <application_directory>/bin/target
For example, if you rake:bb:production, the files will be in a directory named for the SDK version, like /bin/target/4.6/ota-web
You should see many .cod files and one .jad file
Upload all of those files to a web server, then open the .jad file from the browser on your blackberry device
Troubleshooting
After you get your CSI-file from Blackberry, you have to register them. If after dbl-click you will see message "Already registered":
Incorrect password error when attempting to register signature keys"

After press Yes in dialog 'Would you like to create a new key pair file' - nothing appear. No dialogs, no error messages just nothing: this is a problem with Java SDK and Blackberry SDK versions
The signature key window disappears after receiving the private key prompt 
Supported versions of Java for different BlackBerry JDE versions

If you still have a problems:
Manually register CSI files

Signature files can be only registered once per computer. If you register them for example in 4.6 Blackberry SDK , you can copy sigtool.csk and sigtool.db to bin directory of any other BB SDK
There is a problem with network on BlackBerry simulators under Windows 7. It causes syncing failure. There are two workarounds for this issue. One is to use MDS for network connection in simulator (build script does this automatically). The second workaround is to emulate WiFi connection in the simulator.
Application log on the device
The log is written to the file 'rholog.txt'.

If your device has SD card it will place Media Card\Rho\<app name>\
If not it will place on Device Memory\home\user\rho\<app name>\
To see or copy log file to computer:

Add menu item Log to your application menu(See sugar as an example)
Call RhoConf.show_log or RhoConf.send_log somewhere in your app(for example on settings page)
Open Media application on the Phone , select Menu\explore. You can view log file or send it via bluetooth
If you have SD card: Phone options\memory\Mass storage support - ON, save. Then connect device to the computer via cable and you will see USB disk drive in computer explorer. Copy 'rholog.txt' to computer. Do not forget to turn 'Mass Storage support' OFF, otherwise rhodes cannot write to the files!
Connectivity on the device
If your phone has Wifi connectivity rhodes will use it without any additional efforts In case of GPRS, you should :

Setup mobile network: Phone Options\Mobile Network\Data Services ON, Connection preferences: Should be not WiFi-Only.
Setup APN address: Phone Options\Advanced settings\TCP/IP/APN settings enabled. APN should address specific for your provider(wap.cingular for example).

Build rhodes from the source code using Eclipse
You should have Blackberry Eclipse IDE installed.
Please make sure that there are no .metadata folder in rhodes\platform\bb folder, check also that there are no .project and .classname files in any subfolders of rhodes\platform\bb
Run eclipse and choose rhodes\platform\bb as a workspace directory. Do not create workspace!
Go to File\Import... menu. Select Blackberry\Blackberry JDE workspace node. Press Next. Browse for rhodes\platform\bb\.BB.jdw\BB.jdw. Press Finish. The project will be automatically build.
Go to Window\Preferences menu. Select Blackberry JDE\Installed components node.
Select JDE installation directory for your target device. Please note that Eclipse may not show all your installed JDE in the combobox, in this case press Browse button and choose desired JDE. Eclipse for Blackberry has JDE in the <Eclipse folder>\plug-ins\net.rim.eide.componentpack<version>
Choose Java home directory for selected JDE : jdk1.6.0_2 for JDE 4.2 and above.
Select MDS Simulator node and choose MDS from your JDE directory. Press OK.
Workspace will be recreated. Choose Clean all projects in the dialog. Press OK. RubyVM project should be built , check rhodes\platform\bb\RubyVM\RubyVM.jar
Go to <rhodescheckout> and run 'rake build:bb:rhobundle' command. It should create rhodes\platform\bb\RhoBundle\RhoBundle.jar
Return to Eclipse and select Project\Clean... , Clean all projects, press OK.
Congratulations! It is all done.

Known issues with Eclipse build
Sometime BB Eclipse project is checked in in a wrong state and wouldn't build correctly after loading.

You need to make sure every sub-project is activated for BlackBerry (right-click on the sub-project and select [Activate for BlackBerry] menu item).
Check and set project dependencies correctly (select Project/Properties... menu and navigate to BlackBerry Project Dependencies...). Set following dependencies:
PersLite doesn't have any dependencies
PersImplJSR75 depends on PersLite
RhoBundle depends on RubyVM
RubyVM doesn't have any dependencies
rhodes depends on PersLite, PersImplJSR75, RhoBundle, RubyVM
Rebuilding After Code Changes
Go to <rhodescheckout> and run 'rake build:bb:rhobundle' command. It should re-create rhodes\platform\bb\RhoBundle\RhoBundle.jar
Right click on RhoBundle project in Eclipse and select Refresh. It should rebuild rhodes and RhoBundle. You can see messages in Builder Console. OR Just Clean all projects.
Eclipse simulator debug instructions
Open Debug\Open debug dialog... from toolbar (small bug icons). Dbl-click on Blackberry simulator node.
Go to Simulator page and choose Profile other than Default. Check 'Launch Mobile Data System Connection service with simulator' checkbox.(Please note that you may have install MDS on your computer).
Press Debug button. Simulator starts. Eclipse may ask you about missing debug files, press 'Don't ask me again button'(You can also clean emulator: run <JDE_HOME>\simulator\clean.bat and start emulator again)
Press Menu button on emulator. Go to Downloads, run Rhodes
Windows Mobile

Note that Windows Mobile versions of your Rhodes app must be built in a Windows environment.

Prerequisites
Follow these instructions
.NET Compact Framework
Windows Mobile 6 Professional SDK(s)
Microsoft Active Sync 4.5
Visual Studio 2005 Service Pack 1 installed.
7-zip : http://www.7-zip.org/
Open ActiveSync main window, go to the File -> Connection Settings, select checkbox "Allow connections to one of the following" and select "DMA" from the list box. It is required to work with emulator.

Build application on the command line
make sure that C:\Program Files\Microsoft Visual Studio 8\VC\vcpackages is in your path(for vcbuild.exe).Here is the list of paths which should be in PATH env variable:
C:\Program Files\Microsoft Visual Studio 8\Common7\IDE;C:\Program Files\Microsoft Visual Studio 8\VC\BIN;C:\Program Files\Microsoft Visual Studio 8\Common7\Tools;C:\Program Files\Microsoft Visual Studio 8\Common7\Tools\bin;C:\Program Files\Microsoft Visual Studio 8\VC\PlatformSDK\bin;C:\Program Files\Microsoft Visual Studio 8\SDK\v2.0\bin

Add path to CabWiz.exe to rhobuild.yml in rhodes folder:
 env:
   paths:
     cabwiz: C:/Program Files/Windows Mobile 6 SDK/Tools/CabWiz
If you use Visual Studio 2010 : add path to msbuild to rhobuild.yml in rhodes folder:
 env:
   paths:
     vcbuild: msbuild
Go to your application directory. From here you can run all of the Windows Mobile rake tasks:
 * To build and run application on emulator, run (fastest way):
 rake run:wm:emu 
 * To build cab-file, install it and run application on emulator, run:
 rake run:wm:emucab 
 * To build and run application on device, run (fastest way):
 rake run:wm:dev 
 * To build cab-file, install it and run application on device, run:
 rake run:wm:devcab 
 * To build application cab-file for the device, run:
 rake device:wm:production 
If you want the application to be signed automaticly during the build process, please add the 'wmsign' key with full path to your code signing certificate to the 'build' section of rhobuild.yml file:
wmsign: <disk:/path/MySign.pfx>
More information about Windows Mobile code signing you could find at:
http://msdn.microsoft.com/en-us/windowsmobile/dd569132.aspx

To deploy application on device
First connect your device to computer. You can use USB-cable, bluetooth or any other method. To use computer internet you have to start ActiveSync.

You can use rake tasks. see 'Build application on the command line' section. Device should be connected via USB-cable.
You can manually copy .cab file to device, for example to Temp folder and click on cab-file on the device using File Explorer. Installation process will be started. After finish you should see app icon on the device
To build from IDE
Checkout rhodes source code from github
Open platform\wm\rhodes.sln in Visual Studio.
Select Windows Mobile 6 Professional and build Release configuration.
Open the file 'rhobuild.yml' using a text editor:
redefine the path for CabWiz tool
redefine the path for your application
Run 'rake build:wm:devrhobundle'
Make sure you cradle your emulator (Tools->Device Emulator Manager->Select Running Emulator->Actions->Cradle)
Copy rhodes.exe and rhobundle (platform\wm\bin\Win32\rhodes\Debug\rho) from the previous step to My Computer->Mobile Device to \Program Files\rhodes (you can delete content of \Program Files\rhodes\rho folder first to ensure overwriting all old files)
If you changed your application:

Run 'rake build:wm:devrhobundle' to compile your application code
Copy platform\wm\bin\Win32\rhodes\Debug\rho folder to device or emulator in \Program Files\rhodes\rho to see you changes on device or emulator (you can delete content of \Program Files\rhodes\rho folder first to ensure overwriting all old files)
If you changed your application and use the application's rake tasks:

Run "rake device:wm" to compile your application code
Copy <appdir>\bin\target\rhodes.cab content to device or emulator in \My Documents\ and then loading it to see you changes on device or emulator (you can delete previous .cab file first to ensure overwriting)
Logging
To get log from emulator or device:

connect device or emulator to activesync
press explore on ActiveSync window
navigate to My Device\Program Files\<app_name>\rholog.txt
Windows emulator

Prerequisites
Follow these instructions
Visual Studio 2005 Service Pack 1 installed or Visual Studio 2008.
WTL : http://wtl.sourceforge.net/ :
unzip to folder: <VS path>\VC\WTL
open in Visual studio - Tools\Options\Projects and solutions\VC++ directories. Platform - Win32; Show directories for - Include files; And add :
$(VCInstallDir)wtl\include
Build application on the command line
make sure that C:\Program Files\Microsoft Visual Studio 8\VC\vcpackages is in your path(for vcbuild.exe).Here is the list of paths which should be in PATH env variable:
C:\Program Files\Microsoft Visual Studio 8\Common7\IDE;C:\Program Files\Microsoft Visual Studio 8\VC\BIN;C:\Program Files\Microsoft Visual Studio 8\Common7\Tools;C:\Program Files\Microsoft Visual Studio 8\Common7\Tools\bin;C:\Program Files\Microsoft Visual Studio 8\VC\PlatformSDK\bin;C:\Program Files\Microsoft Visual Studio 8\SDK\v2.0\bin

If you use Visual Studio 2010 : add path to msbuild to rhobuild.yml in rhodes folder:
 env:
   paths:
     vcbuild: msbuild
use rake run:win32 to build and run emulator
use rake clean:win32 to clean all binaries
Logging
Rholog.txt is placed in <rhodes folder>\platform\wm\bin\win32\rhodes\Debug\rho

Android

Prerequisites
OS compatible with Android SDK (see here)
Follow these instructions
Download the Android SDK Starter Package
Run <sdk>/tools/android on OS X (<sdk>/SDK Setup.exe on Windows)
Go to Settings > check 'Force https://... sources to be fetched using http://' and press 'Save&Apply'.
Go to Available > Expand 'https://dl-ssl.google.com'
Download the latest SDK version, "SDK Platform 1.5 API 3", "Google APIs by Google Inc., Android API 3" and latest platform available (SDK Platform 2.2, for example)
Set the environment variables ANDROID_HOME to where you installed the SDK, and add <sdk path>/tools to PATH
Download and install the Android NDK
Note that Revision 4 doesn't work with Rhodes 1.5
For Rhodes 1.5, you have to download Revision 3 (Google doesn't link to it, just change the r4 to r3 in the download URL)
Run rhodes-setup and tell Rhodes where you installed the Android SDK and NDK
Since Rhodes 1.5 - in case if you are planning to work with native geo mapping (MapView interface), two things should be done:
Android Maps API key should be retrieved from Google. Follow this document to get it - http://code.google.com/intl/en/android/add-ons/google-apis/mapkey.html. When key received, put it in your application's build.yml or to common rhobuild.yml:
 android:
   apikey: "GOOGLE-API-KEY-FOR-ANDROID"
Enable 'mapping' in your application's build.yml (or in <rhodes-root>/rhobuild.yml):
 android:
   mapping: yes
Eclipse (Optional)
Please follow the instructions how to increase Java memory space: http://source.android.com/using-eclipse
Rhodes 1.2 and lower

On linux/macosx:

Edit <android_sdk>/platforms/android-1.5/tools/dx

uncomment javaOpts="-Xmx215M" and change it to: javaOpts="-Xmx768M -Xms768M"

On windows:

Edit <android_sdk>/platforms/android-1.5/tools/dx.bat

Change the last line:

call java -Xmx768M -Xms768M -Djava.ext.dirs=%frameworkdir% -jar %jarpath% %*
You don't need that if using Rhodes 1.4 and higher!



Note: A special note for Android 1.5 (and higher) users

Please check you applications and change the way how you include css files into html pages.

For example:

You will need to replace

  <style type="text/css" media="screen">@import "/public/js/iui/iui.css"; @import "/public/css/rho.css";</style>
by

  <link rel="stylesheet" href="public/js/iui/iui.css" type="text/css">
  <link rel="stylesheet" href="public/css/rho.css" type="text/css">
Otherwise your css files will not be loaded in android 1.5

Running Your App from the Command Line
Ensure that your path has the java bin dir on it.
From the command line, in your rhodes application directory, run:
 rake run:android
If the rake command gets stuck you can kill the command window, open another window, run
 adb start-server
 rake run:android

Note: First time you will be asked for a few questions about emulator configuration. You should answer "yes" for most questions or use default answers. This is required to creating AVD configuration (this is a new feature in Android 1.5 SDK)
Building Rhodes.apk from the Command Line
From the command line, in your rhodes application directory, run:
 rake device:android:debug
This will build your application and sign it with auto-generated self-signed certificate

If you want to build production version, edit your application's build.yml as below:
 android:
   production:
     certificate: /full/path/to/your/developer/certificate
     password: "password-of-the-certificate"
     alias: "keystore.alias"
This will use specified certificate to sign application. If certificate is not found, it will be auto-generated. In this case you'll be prompted with several questions like your name, organization etc. If you don't want to use auto-generated certificate, refer to the http://developer.android.com/guide/publishing/app-signing.html how to create it manually.

Then run in command line:
 rake device:android:production
Signed APK located in <rhodes-app-dir>/bin/target. Use it to install on device:
 adb -d install -r <rhodes-app-dir>/bin/target/<app-name>_signed.apk
Building Rhodes.apk in Eclipse
Create a new workspace in the following directory: <Rhodes>/platform/android
Go to the Window>Preferences
Click on Android node in the tree and specify file path to the installed android SDK (For example: E:\android\android-sdk-windows-1.6_r1)
Import all projects from the following directory: <Rhodes>/platform/android
If you have set the option to build sources automatically all stuff will be compiled just after the import
==== Rhodes 1.2 or lower ====

* Click on General/Workspace/Linked Resources node in the tree and click "New..." in the corresponding 
  settings window at the right side.

* You need to create the RHO_SHARED variable and set file path to the shared folder. For example:

  RHO_SHARED
  E:\Projects\rhomobile\1-2-stable\platform\shared

* Close Preferences window

* Build RhoBundle project using rake task build:android:rhobundle

* Refresh Rhodes project to reload changes

* If you don't have an option to build sources automatically click Project/Clean... menu item and 
  select Rhodes and RubyJVM project. Click Ok to clean and rebuild projects.
For SDK 1.5 and later:

Right click on Rhodes project and select 1.5 target for Android.

Check bin directory. You should see Rhodes.apk file created. It will be signed with debug key provided with SDK.

Now you are ready to install your application on device and/or emulator.

Installation of the application apk file
Install apk to emulator
To launch rhodes based application on emulator, just type 'rake run:emulator' being in application folder. Example:

 [user@laptop ~/rhodes-system-api-samples]$ rake run:android
It will create (if needed) new virtual sdcard for emulator, then check if emulator is already running (and start if not) and upload application there. You can specify version of emulator you are want to run in your application's build.yml:

 android:
   version: 2.1
Install apk to device
If you have an Android device, you can develop and debug your Android applications just as usual. Launching your apps on a device works just the same as on the emulator, but there are a few things to do before you can start.

Please check corresponding link of the android documentation: http://developer.android.com/guide/developing/device.html

Then, go to application folder and run 'rake run:android:device' there. Example:

 [user@laptop ~/rhodes-system-api-samples]$ rake run:android:device
You can verify that your device is connected by executing "adb devices" from your SDK tools/ directory. If connected, you'll see the device name listed as a "device."

Install standalone apk to device
If you have an existing apk file that you want to install to the device, just run the following command (once you have setup your machine for android deployments: http://developer.android.com/guide/developing/device.html):

 [user@laptop ~/rhodes-system-api-samples]$ adb install <filename>.apk
If your machine doesn't notice the device as connected, try killing the adb process first:

 [user@laptop ~/rhodes-system-api-samples]$ adb kill-server
 [user@laptop ~/rhodes-system-api-samples]$ adb install <filename>.apk
Uninstallation of the application
Uninstall from emulator
 [user@laptop ~/rhodes-system-api-samples]$ rake uninstall:android
Uninstall from device
 [user@laptop ~/rhodes-system-api-samples]$ rake uninstall:android:device
Getting application log from device or emulator
To get application log from device or emulator, issue command 'rake device:android:getlog' or 'rake emulator:android:getlog' from your application folder or from root of rhodes source tree (place where rhobuild.yml is located). Application log will be pulled from device/emulator and stored in your application directory with name RhoLog.txt.
To see all emulator messages run 'adb -d logcat' and start application on device
Symbian

NOTE: Symbian support has been suspended pending increased demand as of v1.1 of Rhodes. Symbian versions of your Rhodes app also require being built in a Windows environment.

Prerequisites
Follow these instructions
Nokia Series 60 3rd Edition SDK for Symbian OS
Active Perl 5.6.1
Prerequisites (FP1)
PIPS library
Open C/C++ Plug-ins for S60 3rd Edition
Installation instructions
Currently it is recommended to use FP2 only because FP1 SDK browser has well-known problem with POST requests.

Nokia Series 60 3rd Edition SDK for Symbian OS:
 Feature Pack 2 recommended
 can be downloaded from: http://www.forum.nokia.com/Resources_and_Information/Tools/Platforms/S60_Platform_SDKs/
 NOTE: SDK and rhodes folders should be on the same logical disk drive.
Active Perl v5.6.1
 Note: specific version 5.6.1
 download it here.
Installation instructions (FP1)
PIPS library:
 download 'pips_9_1_s60_sdk_1_2.zip' file from: http://developer.symbian.com/wiki/pages/viewpageattachments.action?pageId=1411
 locate and extract the files from the archive
 extract it and follow the pdf instructions to copy files into S60 SDK system directories.
Open C/C++ Plug-ins for S60 3rd Edition.
 download it from here: http://www.forum.nokia.com/info/sw.nokia.com/id/91d89929-fb8c-4d66-bea0-227e42df9053/Open_C_SDK_Plug-In.html
 follow the instruction to setup plug-in.
Build application using rhodes gem [1.0 ONLY -- for 1.1 skip to building symbian from source]
Setup HOME enviroment variable. It may be any directory you wish for example:

 C:\Documents and Settings\<account_name>
Create file rho_build.conf in your HOME directory, and define your apps directory there:

 apps.dir=<path to test_application>
Edit build.yml from application directory:

 symbiantools: C:/PROGRA~1/COMMON~1/Symbian/Tools
 symroot: <symbian SDK root>
 change certification parameters if required under 'symbian' section
Run rake -T to see available rake commands

To build and run using Symbian simulator [FP1 SDK]
NOTE: The FP1 SDK emulator has well-known issue with POST requests in browser, in this case we recommend to test your applications using FP2 emulator. To build Rhodes for device you can use both FP1 and FP2 SDK versions.

edit C:\Symbian\9.2\S60_3rd_FP1\Epoc32\winscw\c\system\data\config.ini with the following:
[STDIO]
STDIN = MEDIA1
STDOUT = MEDIA4
To view debug output:
 create empty "in.txt" in C:\Symbian\9.2\S60_3rd_FP1\Epoc32\winscw\c\system\data folder
Run in the application root directory:
 rake run:symbian:app
The simulator will start automatically. NOTE: The simulator will take a very long time to start initially. Subsequent launches should be faster
Rhodes application will be launched automatically. Using menu go to the ‘Installed’>Rhodes to view application content.

To build and run using Symbian simulator [FP2 SDK]
[Note] This feature is available only in the 1.1 version.

Download FP2 SDK from nokia official site: http://www.forum.nokia.com/info/sw.nokia.com/id/ec866fab-4b76-49f6-b5a5-af0631419e9c/S60_All_in_One_SDKs.html
Install SDK
edit C:\S60\devices\S60_3rd_FP2_SDK_v1.1\epoc32\winscw\c\system\data\config.ini with the following:
[STDIO]
STDIN = MEDIA1
STDOUT = MEDIA4
create empty "in.txt" in C:\S60\devices\S60_3rd_FP2_SDK_v1.1\epoc32\winscw\c\system\data folder
[Note] If you have multiple SDK versions installed and you are using Carbide make sure that every project is pointed to use FP2 SDK (Check build configuration options).

In the application root directory check "symroot" path in the build.yml file to make sure that correct path to SDK is used.
First time it is required to launch Symbian emulator from start>Programs>S60 Developers Tools>3rd Edition FP2>v1.1>Emulator, open menu Tools>Preferences, go to the "General Settings" tab and set Memory Capacity value to 96 MB
Run in the application root directory:
 rake run:symbian:app
Rhodes application will be launched automatically. Using menu go to the ‘Installed’>Rhodes to view application content.
To build application for the device
Install PIPS library to your phone:
 rhodes\platform\symbian\lib\pips_nokia_1_3_ss.sis
To sign the SIS package, you need a valid Symbian certificate + key. Only singed packages (SISX) can be installed on real devices.
 Go to http://developer.symbian.com/wiki/display/pub/The+Complete+Guide+to+Symbian+Signed,
 http://www.symbiansigned.com 
 Follow instructions to obtain a valid certificate/key to sign a Symbian application
 Put your certificate (.cert) and key (.key) files under the folder "symbian/rhodes/sis/cert/"
 Note: you are able to use self-signed generated keys.
Run in application root directory
 rake device:symbian
The compiled and signed rhodes.sisx file can be found at
 $(application root)\bin\target\symbian
Build rhodes from the source code
Unpack rhodes\platform\symbian\build\lib\stlport.zip to Epoc32\include\stlport folder
Modify Epoc32/include/e32def.h file (http://wiki.forum.nokia.com/index.php/KIS001022_-_Open_C:_Initializer_element_is_not_constant_error_on_GCCE_platform)
Change:

   static const char* const KSuppressPlatSecDiagnostic =
   KSuppressPlatSecDiagnosticMagicValue;
To:

 #if defined(__cplusplus) 
 static const char* const KSuppressPlatSecDiagnostic =
   KSuppressPlatSecDiagnosticMagicValue; 
 #endif
Install Symbian C++ development environment, preferred: "Carbide C++ v2.0". Downloadable from:
 http://www.forum.nokia.com/main/resources/tools_and_sdks/carbide_cpp/
Edit build properties:
 open file 'build.properties' in 'rhodes\platform\symbian\build' directory
 S60_3rd_FP1=<path to symbian SDK>
 NOTE: This path should NOT include drive letter and should contain slash at the end.
 SDK=S60_3rd_FP1 to set sdk by default
 'build.target=GCCE UREL' to build for device, 'build.target=WINSCW UDEB' to build for emulator
create all required environment variables:
 run '<Carbide20>\x86Build\env_switch\env_update.exe' from command line
Supported Ant Targets
Unset RUBYOPT variable. By default on windows, the RUBYOPT variable is set, this is not needed:
set RUBYOPT= 
You are able to run the following ant targets:
build-all                     : to clean + build + make sis + sign sis (no checkout)
build-selfsign                : to clean + build + make sis + selfsign sis (no checkout)
build-build                   : to build + make sis + sign sis (no clean, no checkout)
build-sis                     : to make sis + sign sis (no clean, no checkout, no build)
rhobundle                     : to make rhobundle
There are two options:

Build package based on working dirs (targets started from 'build-' prefix)
Build RhoBundle
You can see supported targets using "ant" command without parameters Note: For each target you must provide SDK version using SDK parameter. For example:

ant build-all -DSDK=S60_3rd_FP1
Would build using the S60_3rd_FP1 sdk (as shown in the build.properties file)

Output files (and logs) will be placed in 'rhodes\platform\symbian\bin':

"rhodes_v-x.y.z.sis" is the main package
"rhodes_v-x.y.z.sisx" is the main signed package
Carbide.C++ Instructions
Target your workspace directory to the root ..\rhodes directory.
You will need to import the following projects (select import bld.inf in Carbide)
  rhodes\symbian\shttpd\group
  rhodes\symbian\SQLite60\group
  rhodes\symbian\rubylib\group
  rhodes\symbian\rhodes\group
Carbide IDE does not support indexing of the relative file paths. This issue negatively affects importing of the bld.inf files because each of these projects has links to the external include directories.
To resolve this issue you will need to open .mmp file for each project (it is required for successful importing) and temporary comment USERINCLUDE and SOURCEPATH links with “..\..\” and “..\..\..” prefixes:

The example of such links:

  USERINCLUDE    ..\..\SQLite60\src
  USERINCLUDE    ..\..\..\shared\json
  USERINCLUDE    ..\..\..\shared\syncengine
  USERINCLUDE    ..\..\..\shared\ruby
  SOURCEPATH ..\..\..\shared\shttpd\src
After successful importing projects into the workspace you will need to uncomment USERINCLUDE links back.
Open Project Properties for Rhodes project, go to Project References and check all projects(rubylib,shttpd,SQLite60)
HOWTO: Customize application name and icon

iPhone using xCode
Target->info->General->Name
Target->info->Build->Product Name (for all configurations)
rhodes\platform\iphone\icon.png, icon57.png, icon72.png, icon114.png - change to your icons
check rhodes\platform\iphone\Info.plist it should contain BundleName=${PRODUCT_NAME}
Application Name
In the build.yml in your application folder there is an entry "name". This is the display name that the user will see on the device. Example:

 name: My Own App
Application Icon
Place your image to use as an icon in a folder called 'icon' in your application. If you created an app called 'testapp' then the folder would be 'testapp/icon'. The icon should be named 'icon.png' and icon.ico for Windows Mobile

 NOTE Starting from iOS 4.0, Apple require three icons for application: 57x57, 72x72 and 114x114 pixels.
 Prepare such files, name them as icon57.png, icon72.png and icon114.png and place into 'icon' folder
 testapp/
   build.yml
   Rakefile
   rhoconfig.txt
   app/
   public/
   icon/
     icon.png
     icon.ico
HOWTO: Customize Loading image

For iPhone you can define a set of loading images. See Apple documentation about that images : Section "Application Launch Images" in Build-Time Configuration Details

iPhone using xCode
Add to your project Default.png image. You can also add some additional images for better work on different devices:

Default.png 320x480 - for iPhone/iPod/iPhone4/iPad
Default@2x.png 640x960 - for iPhone4/iPod4, if not defined then use Default.png
Default-Portrait.png 768x1024 - for iPad in Portrait orientation on start, if not defined then use Default@2x.png
Default-PortraitUpsideDown.png 768x1024 - for iPad in Portrait orientation on start, if not defined then use Default-Portrait.png
Default-Landscape.png 1024x768 - for iPad in Landscape orientation on start, if not defined then use Default@2x.png
Default-LandscapeLeft.png 1024x768 - for iPad in LandscapeLeft orientation on start, if not defined then use Default-Landscape.png
Default-LandscapeRight.png 1024x768 - for iPad in LandscapeRight orientation on start, if not defined then use Default-Landscape.png
iPhone using rake build
Place loading.png to your applications "app" folder. If you created an app called 'testapp' then the folder would be 'testapp/app'. Also you can add some additional images for better work on different devices :

loading.png 320x480 - for iPhone/iPod/iPhone4/iPad and other non iOS devices
loading@2x.png 640x960 - for iPhone4/iPod4, if not defined then use loading.png
loading-Portrait.png 768x1024 - for iPad in Portrait orientation on start, if not defined then use loading@2x.png
loading-PortraitUpsideDown.png 768x1024 - for iPad in Portrait orientation on start, if not defined then use loading-Portrait.png
loading-Landscape.png 1024x768 - for iPad in Landscape orientation on start, if not defined then use loading@2x.png
loading-LandscapeLeft.png 1024x768 - for iPad in LandscapeLeft orientation on start, if not defined then use loading-Landscape.png
loading-LandscapeRight.png 1024x768 - for iPad in LandscapeRight orientation on start, if not defined then use loading-Landscape.png

You can see examples of all that images in our Rhodes-System-Api-Samples example application.

Category: RhodesPdf
 
Page | Discussion | View source | History
Company
Events
News
Jobs
Team
Products
RhoSync
Rhohub
Rhodes
Docs
Contact us
3031 Tisch Way, Suite 704, San Jose, CA 95128
877-746-0334
408-572-8076
info@rhomobile.com
Rhomobile
B
A
A
A
A
A
A
©Rhomobile, Inc. All Rights Reserved
