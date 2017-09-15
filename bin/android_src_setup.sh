#Ubuntu Linux (64-bit x86)
#This has not been as well tested. Please send success or failure reports to android-porting@googlegroups.com .
#
#The Android build requires a 32-bit build environment as well as some other tools:

#    * Required Packages:
#          o Git, JDK, flex, and the other packages as listed above in the i386 instructions:
#          o JDK 5.0, update 12 or higher.Java 6 is not supported, because of incompatibilities with @Override.
#          o Pieces from the 32-bit cross-building environment
#          o X11 development
#
#    $ 
sudo apt-get install -y git-core gnupg flex bison gperf build-essential zip curl  default-jdk zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev  lib32ncurses5 lib32z1 x11proto-core-dev libx11-dev lib32readline5-dev lib32z-dev
#
#    * Set the system to use the right version of java by default:

#      $ 
sudo update-java-alternatives -s java-1.5.0-sun
#
#    * X11: Ubuntu doesn't have packages for the X11 libraries, but that can be worked around with the following command:

#      $ 
sudo ln -s /usr/lib32/libX11.so.6 /usr/lib32/libX11.so
Installing Repo

Repo is a tool that makes it easier to work with Git in the context of Android. For more information about Repo, see Using Repo and Git .
To install, initialize, and configure Repo, follow these steps:

   1. Make sure you have a~/bindirectory in your home directory, and check to be sure that this bin directory is in your path:
      $ cd ~
      $ mkdir bin
      $ echo $PATH
   2. Download thereposcript and make sure it is executable:
      $ curl http://android.git.kernel.org/repo >~/bin/repo
      $ chmod a+x ~/bin/repo


Initializing a Repo client

   1. Create an empty directory to hold your working files:
      $ mkdir mydroid
      $ cd mydroid
   2. Run "repo init" to bring down the latest version of Repo with all its most recent bug fixes. You must specify a URL for the manifest:
      $ repo init -u git://android.git.kernel.org/platform/manifest.git
          * If you would like to check out a branch other than "master", specify it with -b, like:
            $ repo init -u git://android.git.kernel.org/platform/manifest.git -b cupcake
   3. When prompted, configure Repo with your real name and email address. If you plan to submit code, use an email address that is associated with a Google account .

A successful initialization will end with a message such as
repo initialized in /mydroid

Your client directory should now contain a.repodirectory where files such as the manifest will be kept.

What will my name and email be used for?

To use the Gerrit code-review tool, you will need an email address that is connected with a registered Google account (which does not have to be a Gmail address). Make sure this is a live address at which you can receive messages . The real name that you provide here will show up in attributions for your code submissions.

What is a manifest file?

The Android source files are divided among a number of different repositories. A manifest file contains a mapping of where the files from these repositories will be placed within your working directory w hen you synchronize your files.


Getting the files
To pull down files to your working directory from the repositories as specified in the default manifest, run

$ repo sync

For more about "repo sync" and other Repo commands, see Using Repo and Git .

The Android source files will be located in your working directory under their project names.
Verifying Git Tags
Load the following public key into your GnuPG key database.The key is used to sign annotated tags that represent releases.

$ gpg --import

then paste the key(s) below, and press Control-D to end the input and process the keys. After importing the keys, you can verify any tag with

$ git tag -v tagname

key 9AB10E78: "The Android Open Source Projectinitial-contribution@android.com"

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

mQGiBEnnWD4RBACt9/h4v9xnnGDou13y3dvOx6/t43LPPIxeJ8eX9WB+8LLuROSV 
lFhpHawsVAcFlmi7f7jdSRF+OvtZL9ShPKdLfwBJMNkU66/TZmPewS4m782ndtw7
8tR1cXb197Ob8kOfQB3A9yk2XZ4ei4ZC3i6wVdqHLRxABdncwu5hOF9KXwCgkxMD 
u4PVgChaAJzTYJ1EG+UYBIUEAJmfearb0qRAN7dEoff0FeXsEaUA6U90sEoVks0Z 
wNj96SA8BL+a1OoEUUfpMhiHyLuQSftxisJxTh+2QclzDviDyaTrkANjdYY7p2cq 
/HMdOY7LJlHaqtXmZxXjjtw5Uc2QG8UY8aziU3IE9nTjSwCXeJnuyvoizl9/I1S5
jU5SA/9WwIps4SC84ielIXiGWEqq6i6/sk4I9q1YemZF2XVVKnmI1F4iCMtNKsR4
MGSa1gA8s4iQbsKNWPgp7M3a51JCVCu6l/8zTpA+uUGapw4tWCp4o0dpIvDPBEa9
b/aF/ygcR8mh5hgUfpF9IpXdknOsbKCvM9lSSfRciETykZc4wrRCVGhlIEFuZHJv 
aWQgT3BlbiBTb3VyY2UgUHJvamVjdCA8aW5pdGlhbC1jb250cmlidXRpb25AYW5k 
cm9pZC5jb20+iGAEExECACAFAknnWD4CGwMGCwkIBwMCBBUCCAMEFgIDAQIeAQIX 
gAAKCRDorT+BmrEOeNr+AJ42Xy6tEW7r3KzrJxnRX8mij9z8tgCdFfQYiHpYngkI 
2t09Ed+9Bm4gmEO5Ag0ESedYRBAIAKVW1JcMBWvV/0Bo9WiByJ9WJ5swMN36/vAl 
QN4mWRhfzDOk/Rosdb0csAO/l8Kz0gKQPOfObtyYjvI8JMC3rmi+LIvSUT9806Up 
hisyEmmHv6U8gUb/xHLIanXGxwhYzjgeuAXVCsv+EvoPIHbY4L/KvP5x+oCJIDbk 
C2b1TvVk9PryzmE4BPIQL/NtgR1oLWm/uWR9zRUFtBnE411aMAN3qnAHBBMZzKMX 
LWBGWE0znfRrnczI5p49i2YZJAjyX1P2WzmScK49CV82dzLo71MnrF6fj+Udtb5+
OgTg7Cow+8PRaTkJEW5Y2JIZpnRUq0CYxAmHYX79EMKHDSThf/8AAwUIAJPWsB/M 
pK+KMs/s3r6nJrnYLTfdZhtmQXimpoDMJg1zxmL8UfNUKiQZ6esoAWtDgpqt7Y7s 
KZ8laHRARonte394hidZzM5nb6hQvpPjt2OlPRsyqVxw4c/KsjADtAuKW9/d8phb 
N8bTyOJo856qg4oOEzKG9eeF7oaZTYBy33BTL0408sEBxiMior6b8LrZrAhkqDjA 
vUXRwm/fFKgpsOysxC6xi553CxBUCH2omNV6Ka1LNMwzSp9ILz8jEGqmUtkBszwo 
G1S8fXgE0Lq3cdDM/GJ4QXP/p6LiwNF99faDMTV3+2SAOGvytOX6KjKVzKOSsfJQ 
hN0DlsIw8hqJc0WISQQYEQIACQUCSedYRAIbDAAKCRDorT+BmrEOeCUOAJ9qmR0l 
EXzeoxcdoafxqf6gZlJZlACgkWF7wi2YLW3Oa+jv2QSTlrx4KLM=
=Wi5D 
-----END PGP PUBLIC KEY BLOCK-----


Building the code
To build the files, runmakefrom within your working directory:
$ cd ~/mydroid
$ make

If your build fails, complaining about a missing "run-java-tool", try setting the ANDROID_JAVA_HOME env var to $JAVA_HOME before making.E.g.,

$ export ANDROID_JAVA_HOME=$JAVA_HOME
Using an IDE

    * Using Eclipse for Android platform development

Troubleshooting

ImportError: No module na med readline

Mac users getting this should install Python 2.5.2.

Linux users that installed Python from source, make sure the dependencies for libreadline are installed, and rebuild Python.
a
A
A
A
A
A
D
D
A
A
A
A
A
A
A
A
A
A

