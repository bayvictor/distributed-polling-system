echo "I have the latest Android SDK installed on Ubuntu 12.04 x64 I am having almost an identical problem as Problems with Eclipse and Android SDK. The Eclipse ADT plugin is not working for me, and its Android window shows

SDK/build-tools/17.0.0/aapt: error while loading shared libraries: libz.so.1: cannot open shared object file: No such file or directory

when I create a new Android project.

Then I tried

sudo apt-get install ia32-libs

but the commands fails and returns

Reading state information... Done
Some packages could not be installed. This may mean that you have
requested an impossible situation or if you are using the unstable
distribution that some required packages have not yet been created
or been moved out of Incoming.
The following information may help to resolve the situation:

The following packages have unmet dependencies:
  lib32ncurses5 lib32z1 : Depends: ia32-libs-multiarch
E: Unable to correct problems, you have held broken packages.

Up until now, I followed this answer which worked for the 32-bit adb, and this may have affected how Ubuntu is handling ia-32-libs. What must be done to correctly install the necessary libraries to get all the 32-bit Android tools to run correctly?

update

I tried this answer but it didn't work.

I tried sudo apt-get purge libc6:i386 libncurses5:i386 libstdc++6:i386

but  lib32ncurses5 lib32z1 still did't install.

output of ldd ./aapt

linux-gate.so.1 =>  (0xf778f000)
librt.so.1 => /lib32/librt.so.1 (0xf7768000)
libdl.so.2 => /lib32/libdl.so.2 (0xf7760000)
libpthread.so.0 => /lib32/libpthread.so.0 (0xf7740000)
libz.so.1 => not found
libstdc++.so.6 => /usr/lib32/libstdc++.so.6 (0xf7658000)
libm.so.6 => /lib32/libm.so.6 (0xf7628000)
libgcc_s.so.1 => /usr/lib32/libgcc_s.so.1 (0xf7608000)
libc.so.6 => /lib32/libc.so.6 (0xf7460000)
/lib/ld-linux.so.2 (0xf7790000)

libz.so.1 is not found, and Ubuntu says that zlib1g is already most current.

Here's what worked
"
sudo add-apt-repository ppa:gnome3-team/gnome3

sudo apt-get update


sudo apt-get install libgl1-mesa-dri:i386
sudo apt-get install ia32-libs-multiarch:i386

sudo apt-get install ia32-libs-multiarch

sudo apt-get install ia32-libs

12.04 64-bit android eclipse
echo "shareimprove this question
	
edited May 26 at 7:52

	
asked May 26 at 4:17
T. Webster
1234
	
	
Wait. An answer has already worked for you? Why not accept it? – chad May 28 at 0:35
add comment (requires an account with 50 reputation)
3 Answers
active oldest votes
up vote 1 down vote
	
"
sudo add-apt-repository ppa:gnome3-team/gnome3

sudo apt-get update


sudo apt-get install libcanberra-gtk-module

sudo apt-get install ia32-libs

echo "I had this same issue. Run these commands

shareimprove this answer
	
answered May 26 at 5:12
chad
348117
	
	
+1 but I've run into some issues. Please see the output at pastebin.com/1qefnzWX – T. Webster May 26 at 6:40
	
Try something for me. Try to install ia32-libs-multiarch. It will give you another dependency error. Keep doing this until eventually it will let you install a dependency but will threaten to remove a lot of packages. Tell me that that package – chad May 28 at 0:27
	
That package for me was libcanberra-gtk-module. You already had that installed. You have a different missing package. Needless to say, once you find this package DO NOT INSTALL IT. Because it will remove a lot of necessary packages, just tell me what it is. – chad May 28 at 0:32
add comment (requires an account with 50 reputation)
up vote 0 down vote
	

Executing the following commands would install  lib32ncurses5 lib32z1 multiarch package.
"
sudo apt-get update
sudo apt-get install ia32-libs-multiarch:i386



sudo apt-get install libgl1-mesa-dri:i386
sudo apt-get install ia32-libs-multiarch:i386

sudo apt-get install ia32-libs-multiarch

sudo apt-get install ia32-libs

echo "working!!!!"

