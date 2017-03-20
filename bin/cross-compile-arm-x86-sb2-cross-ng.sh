sudo apt-get install -y automake #- Tool for generating GNU Standards-compliant Makefiles
sudo apt-get install -y autoconf #- Tool for generating GNU Standards-compliant Makefiles


echo "Nov 04, 2012
How to setup a Cross Compiler Environment

A bit of history: I had written a wiki article a few years back about how to setup a cross compiler and a build environment for working with ARM CPUs and Debian based distributions. I'm in the process of getting rid of the site so I thought it was a good time to retry this setup and put it on my new site.

This tutorial will cover setting up a build environment for cross compiling. This tutorial assumes you are building on a Debian based system for a Debian based target. If your systems are slightly different follow the spirit of the tutorial rather than the letter.

Build Cross Compiler

The basis of all cross compiler environments is the cross compiler itself. Back in the day people use to have to build cross compilers and all the prerequisites by hand, compilers to build compilers, and everything else. crosstool-NG is a project that has simplified the whole process.
Required Packages

The following is a list of the obvious packages to build a cross compiler. When you build and install crosstool-NG you may have additional packages but for the most part install these and you should be good.

    mercurial
    bison
    flex
    texinfo
    automake
    build-essential (gcc compilers, linkers, etc)

    libncurses-dev

    $"

sudo apt-get install -y mercurial bison flex texinfo \ automake build-essential libncurses-dev

echo "We will be installing everything to a $HOME/x-tools/ directory however you can put everything in a globally accessible if you want better access for all your users.
Download

The next step is to download and install crosstool-NG. Best idea is to pull the latest version fro source control.

$ "

echo "^C to break, anykey to continue...";read readline
mkdir ~/x-tools/src
 cd x-tools/src
 hg clone http://ymorin.is-a-geek.org/hg/crosstool-ng


echo " etup

Now we need to install crosstool-NG. We will create a directory $HOME/x-tools/crosstool-ng and install crosstool-NG there. If you want others to have access to crosstool-NG you may want to change this to a more globally accessible location like /opt/crosstool-ng.

Additional programs will be checked here when you run configure so you may have to install additional packages if any are missing.

$ "
mkdir $HOME/x-tools/crosstool-ng
 cd $HOME/x-tools/src/crosstool-ng
 ./bootstrap
 ./configure --prefix=$HOME/x-tools/crosstool-ng
 make
 make install

echo "Note: If you are building from the numbered version rather than from source control you can skill the bootstrap step.
"

echo "^C to break, anykey to continue...";read readline
gedit  $HOME/.bashrc

echo "Now that crosstool-NG is built and installed we need to add it to our path. If you are running bash its as easy as updating your bashrc file.
"
export PATH=$HOME/x-tools/crosstool-ng/bin:$PATH

echo "
Once you've added this source the file source $HOME/.bashrc or close your terminal window and open a new one.
Build Cross Compiler

The last step is to build the cross compiler. This step is heavily dependent on the architecture and distribution you are trying to build to. If, for instance, you are building a build system for the Raspberry Pi you'll want to select and ARM system, possibly with Hardware Floating Point support and Linux 3.2 support.

crosstool-NG can build both bare-metal and Linux based compilers. There are many options and a good amount of them are documented in the help. One suggestion I'd have is to build the most basic compiler possible for your system. Once you've verified it works, you can tweak it and see if that breaks anything.

$ "

echo "^C to break, anykey to continue...";read readline
mkdir -p $HOME/x-tools/arm-unknown-gnueabi
 cd $HOME/x-tools/arm-unknown-gnueabi
 ct-ng menuconfig

echo "If you are building for a Linux system look to see what version of the kernel is running on your target hardware. Also note versions of GCC, C libraries and anything else you want crosstool-NG to build.

If matching versions don't exist always try to get as close as possible with a lower version. For example, if your Raspberry Pi has 2.16 of the C Library but crosstool-NG only supports 2.15 or 2.17 select 2.15. You want to build against the same major revision (first number) but always keep at the minor (second number) or lower so that you don't build a compiler system with features your hardware's OS can't support.

Once you've completed your configuration its time to build. Start it and check back often, this process will take some time.
"

echo "^C to break, anykey to continue...";read readline
ct-ng build

echo "Note: If all you are looking for is to build a cross compiler, then go no further, you are done. If you want to attempt to create a build environment that simplifies cross compiling and building of packages then continue on.
Cross Compiler Jail

Now that we have our cross compilers build we need to create an environment to use these tools while attempting to ease the process of building software.

To make the process easier we will be creating a Jail to run all of our cross compilers and build tools. This jail will run as if we are on the actual target hardware, reporting the correct architecture.

We will be using Scratchbox2 and QEmu to emulate our target architecture.
Directory Structure

The first step to building the jail is to setup the directory structure of our jailing system. I'm using $HOME/sbox2 but you can use a more globally accessible location if you need.

    sbox2
        bin (Contains all binaries needed for the environment
        qemu (QEmu binaries)
        rootfs (Contains root file systems of our target architectures)
        armel (Embedded ARM root file system)
        src (Source code for Scratchbox)

So lets create it.

$ "
mkdir -p $HOME/sbox2{bin/qemu,rootfs/armel,src}

echo "^C to break, anykey to continue...";read readline
echo "Debootstrap

A prerequisite for Scratchbox is a working root file system of your target hardware. In the case of this tutorial I'm building a Debian system so I'll be using Debootstrap but there are many options out there (rinse if you are using an RPM).

$ "
sudo apt-get install debootstrap

echo "Now we'll create a root file system for our target. Please read the manual for your bootstrapping software.

$ "

echo "^C to break, anykey to continue...";read readline

sudo debootstrap --verbose --arch armel --foreign lenny \
  $HOME/sbox/rootfs/armel http://ftp.at.debian.org/debian

echo "Scratchbox

Scratchbox2 is a fully functioning jail which allows you to build applications and run them as if you were running on your target hardware. Rather than having to invoke an emulator every time you want to run something, entering into "Scratchbox" is the only step needed.
Required Packages

If you are building Scratchbox by hand you'll need to install the following packages. If your build machine's distro has a version try that.

    autoconf
    autogen
    automake
    autotools-dev
    binutils
    fakeroot
    gcc-3.4 (QEmu)
    git-core
    g++
    libsdl1.2-dev (QEmu)
    make
    sbrsh
    subversion (QEmu)

All the packages labeled (QEmu) are needed for, you guessed it, QEmu. I prefer to build QEmu by hand rather than using the version that comes with your distro. In some cases there are modifications needed for your target hardware's architecture which is not always included in the vanilla version. Use the distro version if you like.

$ "

echo "^C to break, anykey to continue...";read readline
sudo apt-get install -y autoconf autogen \
  automake autotools-dev binutils fakeroot \
  gcc-3.4 git-core g++ libsdl1.2-dev make \
  sbrsh subversion

echo "If you stick with me to build QEmu make sure to remove any version currently installed.

$ sudo apt-get --purge remove qemu

Build Scratchbox

Now we are ready to download and build Scratchbox. We'll pull the latest version from source control. You'll want to check the versions available via git tag and read through the logs via git log to find the best working version.

$ "

cd $HOME/sbox2/src
 git clone git://gitorious.org/scratchbox2/scratchbox2.git
 cd scratchbox2
 git checkout 2.3.90 -b devel_env
 ./autogen.sh
 ./configure --prefix=$HOME/sbox2/bin/scratchbox
 make install

echo "^C to break, anykey to continue...";read readline
echo "Build QEmu

Time to build the actual emulator. If you opted to use your distro's version you can skip this step.

Download and install. Check the git tag and git log to find the best version possible.

$ "
cd $HOME/sbox2/src
 git clone git://git.savannah.nongnu.org/qemu.git
 cd qemu
 git checkout 2.1 -b devel_env
 ./configure --prefix=$HOME/sbox2/bin/qemu
 make
 make install

echo "^C to break, anykey to continue...";read readline
echo "Setup Environments

Now that we have build our cross compiler (using crosstool-NG), our jail (Scratchbox2) and our emulator (QEmu), we just need to setup our Host System environment variables and we are good to go.

Edit $HOME/.bashrc or whichever shell rc file is appropriate.
"

echo "^C to break, anykey to continue...";read readline

export PATH=$PATH:$HOME/x-tools/arm-unknown-gnu-linux/bin:\
$HOME/sbox2/bin/scratchbox/bin:$HOME/sbox2/bin/qemu/bin
">>$HOME/.bashrc
source ~/.bashrc

echo "^C to break, anykey to continue...";read readline

echo "Source or close the window and open again. Now we are ready to setup our jail.

The first step is to initialize our jail. This requires you to be in the directory of your base root file system. The second parameter in for the line calling sb2-init is the location of gcc we built with our cross compiler. There are more options, see the man pages.

$ "

echo "^C to break, anykey to continue...";read readline

cd $HOME/sbox2/rootfs/armel
 sb2-init armel $HOME/sbox2/bin/arm-unknown-gnu-linux/arm-unknown-linux/gnueabi-gcc

echo "Welcome to Jail

To enter Scratchbox type sb2. You should see your prompt change to the target we just created. We'll create a little dummy program to verify everything is working.

echo "^C to break, anykey to continue...";read readline
$ "
sb2
 echo 'int main() { return 0; }' > test.c
 gcc test.c
 file a.out
echo "a.out: ELF 32-bit LSB executable, ARM, version 1
(SYSV), dynamically linked (uses shared libs),
for GNU/Linux 3.2, not stripped

Note: On some systems there if you run into a problem running the binary with an error stating that mmap is causing a problem, here is a simple fix. Edit /etc/sysctl.conf (or the equivalent for your system) and add the following line to the end.

vm.mmap_min_addr = 4096

Reboot your system and it should work.
Cross Compiled Libraries
"

echo "^C to break, anykey to continue...";read readline
echo "This section will cover how to install libraries to further your development. This is dependent on your target and host distros so if you are running Debian and Debian...follow me.
Required Packages

Since we are building a Debian based system our target contains apt-get. Turns out there is a tool for cross compiled libraries call apt-cross.

$ "

sudo apt-get install apt-cross

echo "^C to break, anykey to continue...";read readline
echo "The configuration

We want to setup our system to keep our host libraries separate from our cross system. We can put our cross libraries in /usr/cross-pkg by editing /etc/dpkg-cross/cross-compile

crossbase = /usr/cross-pkg

Whenever we install something via apt-cross, it and its dependencies will be placed in /usr/cross-pkg/arm-linux/gnueabi (or whatever arch you selected).
Install a Package

Lets install a package, but first we need to update our list of packages.

$ "

sudo apt-cross -a armel -S lenny -m \
http://ftp.at.debian.org/debian -u

echo "^C to break, anykey to continue...";read readline
echo "The arguments for this command define the architecture -a, the version of Debian -S and the mirror -m and tells apt-cross to update -u.

Next we will install a development package. For our example we'll install the ADAPTIVE Communication Environment (ACE), as it has a nice API for making portable cross-platform applications.

$ "

echo "^C to break, anykey to continue...";read readline

sudo apt-cross -a armel -S lenny \
  -m http://ftp.at.debian.org/debian -i libace-dev

echo "Dependencies will be installed including libc and gcc-base. Great things these package managers.
Test a Package

Lets test our library.
"

echo "^C to break, anykey to continue...";read readline
echo "#include "ace/Log_Msg.h"

#int main (void)

#{
#  ACE_DEBUG((LM_INFO, ACE_TEXT("Hello World\n")));
#  return 0;
#}

echo "And now to compile.

$ "

echo "^C to break, anykey to continue...";read readline
sb2
[SB2 simple armel] $ g++ -c -I/usr/cross-pkg/arm-linux-gnueabi/include -o test.o test.cpp
[SB2 simple armel] $ g++ -lACE -L/usr/cross-pkg/arm-linux-gnueabi/lib -o test test.o

We are using shared libraries installed outside of Scratchbox so we need to tell the system where everything is located. When running the file we update our library path to include the cross-pkg libs.

[SB2 simple armel] $ LD_LIBRARY_PATH=/usr/cross-pkg/arm-linux-gnueabi/lib:$LD_LIBRARY_PATH ./test
Hello World
[SB2 simple armel] $

We can also check the header of our output:

[SB2 simple armel] $ file ./test
./test: ELF 32-bit LSB executable, ARM, version 1 (SYSV), 
dynamically linked (uses shared libs), for GNU/Linux 2.6.26, not stripped

You are now ready to write code...and cross compile it.

<perm> | /devel | 2012.11.04-13:30.00 | <comments> | <reddit> | <digg> | <stumbleupon> | <tweet>
rss atom
blosxom sdf

"


echo "^C to break, anykey to continue...";read readline


