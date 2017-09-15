echo "Downloading the Source Tree
Installing Repo

Repo is a tool that makes it easier to work with Git in the context of Android. For more information about Repo, see Version Control.

To install, initialize, and configure Repo, follow these steps:

    *

      Make sure you have a bin/ directory in your home directory, and that it is included in your path:
mkdir ~/bin
PATH=~/bin:$PATH

      $ 
"
read readline

mkdir ~/bin
PATH=~/bin:$PATH
mkdir ~/bin/repo
echo "
    *

      Download the Repo script and ensure it is executable:

      $ 
"
curl https://dl-ssl.google.com/dl/googlesource/git-repo/repo > ~/bin/repo
chmod a+x ~/bin/repo
echo "
    *

      The SHA-1 checksum for repo is 29ba4221d4fccdfa8d87931cd73466fdc24040b5

Initializing a Repo client
I"
read readline
echo "
After installing Repo, set up your client to access the android source repository:

    *

      Create an empty directory to hold your working files. If you're using MacOS, this has to be on a case-sensitive filesystem. Give it any name you like:

      $ 
"
mkdir WORKING_DIRECTORY
cd WORKING_DIRECTORY

echo "    *

      Run repo init to bring down the latest version of Repo with all its most recent bug fixes. You must specify a URL for the manifest, which specifies where the various repositories included in the Android source will be placed within your working directory.

      $ i"
repo init -u https://android.googlesource.com/platform/manifest

echo "      To check out a branch other than "master", specify it with -b:

      $ i"

repo init -u https://android.googlesource.com/platform/manifest -b android-4.0.1_r1

echo "    *

      When prompted, please configure Repo with your real name and email address. To use the Gerrit code-review tool, you will need an email address that is connected with a registered Google account. Make sure this is a live address at which you can receive messages. The name that you provide here will show up in attributions for your code submissions.

A successful initialization will end with a message stating that Repo is initialized in your working directory. Your client directory should now contain a .repo directory where files such as the manifest will be kept.
Getting the files

To pull down files to your working directory from the repositories as specified in the default manifest, run

$ "
read readline
repo sync
echo "
The Android source files will be located in your working directory under their project names. The initial sync operation will take an hour or more to complete. For more about repo sync and other Repo commands, see Version Control.
Verifying Git Tags

Load the following public key into your GnuPG key database. The key is used to sign annotated tags that represent releases.

$ "
read readline
gpg --import

echo "Copy and paste the key(s) below, then enter EOF (Ctrl-D) to end the input and process the keys.

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
"
read readline 
echo "
After importing the keys, you can verify any tag with

$ "
git tag -v TAG_NAME

echo "If you haven't set up ccache yet, now would be a good time to do it.
Downloading kernels

If you are only interested in kernel sources, you can get the kernel you are interested in through one of the following commands:
"
read readline

 git clone https://android.googlesource.com/kernel/common.git
 git clone https://android.googlesource.com/kernel/goldfish.git
 git clone https://android.googlesource.com/kernel/msm.git
 git clone https://android.googlesource.com/kernel/omap.git
 git clone https://android.googlesource.com/kernel/samsung.git
 git clone https://android.googlesource.com/kernel/tegra.git

echo "Next: Build the code

You now have a complete local copy of the Android codebase. Continue on to building....
"

