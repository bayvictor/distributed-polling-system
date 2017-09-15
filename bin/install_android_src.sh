#!/bin/bash
echo "installing android source-code env..."

sudo apt-get install -y curl

#Ubuntu Linux (32-bit x86)
#To set up your Linux development environment, make sure you have the following:

#    * Required Packages:
#          o Git 1.5.4 or newer and the GNU Privacy Guard.#
#
#          o JDK 5.0, update 12 or higher.Java 6 is not supported, because of incompatibilities with @Override.
#
#          o flex, bison, gperf, libsdl-dev, libesd0-dev, libwxgtk2.6-dev (optional), build-essential, zip, curl.
#
#    $ 
sudo apt-get install -y git-core gnupg  default-jdk flex bison gperf libsdl-dev libesd0-dev libwxgtk2.6-dev build-essential zip curl libncurses5-dev zlib1g-dev

#    * You might also want Valgrind, a tool that will help you find memory leaks, stack corruption, array bounds overflows, etc.
#
#    $ 
sudo apt-get install -y valgrind
#
#    * Intrepid ( 8.10) users may need a newer version of libreadline:
#
#$
 
sudo apt-get install -y lib32readline5-dev 

#Repo is a tool that makes it easier to work with Git in the context of Android. For more information about Repo, see Using Repo and Git .
#To install, initialize, and configure Repo, follow these steps:

echo "   1. Make sure you have a~/bin directory in your home directory, and check to be sure that this bin directory is in your path:
      $ "
cd ~
#      $ 
mkdir bin
#      $ 
echo $PATH
echo "   2. Download thereposcript and make sure it is executable:
      $ "

curl http://android.git.kernel.org/repo >~/bin/repo
#      $ 
chmod a+x ~/bin/repo


#=================

echo "Initializing a Repo client

   1. Create an empty directory to hold your working files:
      $ "
cd ~
mkdir mydroid
#      $ 
cd mydroid
#   2. Run "repo init" to bring down the latest version of Repo with all its most recent bug fixes. You must specify a URL for the manifest:
#      $ 
repo init -u git://android.git.kernel.org/platform/manifest.git
#          * If you would like to check out a branch other than "master", specify it with -b, like:
#            $ repo init -u git://android.git.kernel.org/platform/manifest.git -b cupcake
echo"   3. When prompted, configure Repo with your real name and email address. If you plan to submit code, use an email address that is associated with a Google account .

A successful initialization will end with a message such as
repo initialized in /mydroid"

echo "Your client directory should now contain a.repodirectory where files such as the manifest will be kept.

What will my name and email be used for?

To use the Gerrit code-review tool, you will need an email address that is connected with a registered Google account (which does not have to be a Gmail address). Make sure this is a live address at which you can receive messages . The real name that you provide here will show up in attributions for your code submissions.

What is a manifest file?

The Android source files are divided among a number of different repositories. A manifest file contains a mapping of where the files from these repositories will be placed within your working directory w hen you synchronize your files.


Getting the files
To pull down files to your working directory from the repositories as specified in the default manifest, run

$ "

repo sync

#For more about "repo sync" and other Repo commands, see Using Repo and Git .

echo "The Android source files will be located in your working directory under their project names.
Verifying Git Tags
Load the following public key into your GnuPG key database.The key is used to sign annotated tags that represent releases.

$ 
gpg --import

then paste the key(s) below, and press Control-D to end the input and process the keys. After importing the keys, you can verify any tag with

$ git tag -v tagname"

echo 'key 9AB10E78: "The Android Open Source Projectinitial-contribution@android.com"'

read read_line


echo "Building the code
To build the files, run make from within your working directory:
$ "
cd ~/mydroid
#$ 
source build/envsetup.sh
#$ 
lunch
#$ 
make

#If your build fails, complaining about a missing "run-java-tool", try setting the ANDROID_JAVA_HOME env var to $JAVA_HOME before making. E.g.,

#$ 
export ANDROID_JAVA_HOME=$JAVA_HOME
#Using an IDE

#    * Using Eclipse for Android platform development

#Troubleshooting

echo "ImportError: No module na med readline

Mac users getting this should install Python 2.5.2.

Linux users that installed Python from source, make sure the dependencies for libreadline are installed, and rebuild Python.
What's next?
To learn about reporting an issue and searching previously reported issues, see Report bugs . For information about editing the files and uploading changes to the code-review server, see Contribute .
"

