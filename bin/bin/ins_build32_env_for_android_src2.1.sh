#!/bin/bash
sudo apt-get install -y eclipse-platform

echo "Ubuntu Linux (64-bit x86)
This has not been as well tested. Please send success or failure reports to android-porting@googlegroups.com .

The Android build requires a 32-bit build environment as well as some other tools:

    * Required Packages:
          o Git, JDK, flex, and the other packages as listed above in the i386 instructions:
          o JDK 5.0, update 12 or higher.Java 6 is not supported, because of incompatibilities with @Override.
          o Pieces from the 32-bit cross-building environment
          o X11 development

    $ "

echo "Press ^C to break, any key to continue"
read read_line

sudo apt-get install -y git-core gnupg flex bison gperf build-essential zip curl  default-jdk zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev  lib32ncurses5 lib32z1 x11proto-core-dev libx11-dev lib32readline5-dev lib32z-dev

echo "    * Set the system to use the right version of java by default:

      $ "

echo "Press ^C to break, any key to continue"
read read_line

sudo update-java-alternatives -s java-1.5.0-sun

echo "    * X11: Ubuntu doesnt  have packages for the X11 libraries, but that can be worked around with the following command:

      $ sudo ln -s /usr/lib32/libX11.so.6 /usr/lib32/libX11.so
"
echo "Press ^C to break, any key to continue"
read read_line

sudo ln -s /usr/lib32/libX11.so.6 /usr/lib32/libX11.so

echo "Installing Repo

Repo is a tool that makes it easier to work with Git in the context of Android. For more information about Repo, see Using Repo and Git .
To install, initialize, and configure Repo, follow these steps:

   1. Make sure you have a~/bindirectory in your home directory, and check to be sure that this bin directory is in your path:
      $ "
echo "Press ^C to break, any key to continue"
read read_line

cd ~
mkdir bin
echo $PATH
echo "   2. Download thereposcript and make sure it is executable:
      $ "
curl http://android.git.kernel.org/repo >~/bin/repo
chmod a+x ~/bin/repo


echo "Initializing a Repo client

   1. Create an empty directory to hold your working files:
      $ "
mkdir mydroid
cd mydroid
echo "   2. Run "repo init" to bring down the latest version of Repo with all its most recent bug fixes. You must specify a URL for the manifest:
      $ "
repo init -u git://android.git.kernel.org/platform/manifest.git
echo "* If you would like to check out a branch other than "master", specify it with -b, like:
            $ "
repo init -u git://android.git.kernel.org/platform/manifest.git -b cupcake
echo "   3. When prompted, configure Repo with your real name and email address. If you plan to submit code, use an email address that is associated with a Google account .

A successful initialization will end with a message such as
repo initialized in /mydroid

Your client directory should now contain a.repodirectory where files such as the manifest will be kept."
echo "Press ^C to break, any key to continue"
read read_line

echo "What will my name and email be used for?

To use the Gerrit code-review tool, you will need an email address that is connected with a registered Google account (which does not have to be a Gmail address). Make sure this is a live address at which you can receive messages . The real name that you provide here will show up in attributions for your code submissions.

What is a manifest file?

The Android source files are divided among a number of different repositories. A manifest file contains a mapping of where the files from these repositories will be placed within your working directory w hen you synchronize your files.


Getting the files
To pull down files to your working directory from the repositories as specified in the default manifest, run

$ "

echo "Press ^C to break, any key to continue"
read read_line

repo sync


