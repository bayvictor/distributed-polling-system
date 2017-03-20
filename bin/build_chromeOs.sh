echo "Get the source code
Chromium OS uses repo to sync down source code. repo is effectively a wrapper for the git version control system that helps deal with a large number of git repositories. You already installed repo when you installed depot_tools above. Run "gclient" without any args if you want to update your existing version of depot_tools. 

Add the host keys to your known hosts file:
Both of the options below run SSH in a noninteractive shell, which makes accepting their host keys tricky; you won't be able to type "yes" to tell SSH that the key is OK.   You can do this step by manually SSHing to the hosts first:
ssh -p 29418 gerrit.chromium.org
You won't be able to log in to either host, but you'll have an opportunity to add the host keys.

Alternately, you can paste this into your .ssh/known_hosts:
[gerrit.chromium.org]:29418 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQCfRn+J+e9mU0c4bxFD8v2rhhd3O9WPk435xEtG9FD8a8fOnIubJcpObvQJhfSgYkxVUQOKk97V8b2eGjf72AGBhDQVJMiaLQc8ZGomeNlK/7cWjkJFDoIKQHilHQidz/pgZc/Pu+7Tl2emVGd6425QRK1h47CYtT9IUPt3Jtdv4w==

Once the keys are added to your known_hosts file, choose one of the options below.

Option #1: If you want a copy of the minilayout, enter the following commands:

mkdir ${HOME}/chromiumos
ln -s ${HOME}/chromiumos ~/src/chromiumos 
cd ${HOME}/chromiumos
repo init -u https://git.chromium.org/git/chromiumos/manifest.git -g --repo-url https://git.chromium.org/git/external/repo.git
repo sync

Option #2: If you want a copy of the full layout, enter the following commands:

cd ${HOME}/chromiumos
"
mkdir ${HOME}/chromiumos
ln -s ${HOME}/chromiumos ~/src/chromiumos 
cd ${HOME}/chromiumos
repo init -u https://git.chromium.org/git/chromiumos/manifest.git --repo-url https://git.chromium.org/git/external/repo.git
repo sync

echo "Googlers: See goto/chromeos-building for internal notes.

SIDE NOTES:

    If you want to build on a branch, pass the branch name to repo init (e.g: repo init -u <URL> [-g minilayout] -b 0.9.94.T).

When you use repo init you will be asked to confirm your name, email address, and whether you want color in your terminal. This command runs quickly. The repo sync command takes a lot longer. 
Building Chromium OS
Create a chroot
To make sure everyone uses the same exact environment and tools to build Chromium OS, all building is done inside a chroot.  This chroot is its own little world: it contains its own compiler, its own tools (its own copy of bash, its own copy of sudo), etc.  Now that you've synced down the source code, you need to create this chroot. Assuming you're already in ${HOME}/chromiumos (or wherever your source lives), the command to download and install the chroot is:
"
./chromite/bin/cros_sdk

echo "This will download and setup a prebuilt chroot from Chromium OS mirrors (under 400M). If you prefer to rather build it from source, or have trouble accessing the servers, use cros_sdk --bootstrap. Note that this will also enter the chroot. If you prefer to build only, use --download.
The command with --bootstrap takes about half an hour to run on a four core machine. It compiles quite a bit of software, which it installs into your chroot, and downloads some additional items (around 300MB). While it is building you will see a regular update of the number of packages left to build. Once the command finishes, the chroot will take up total disk space of a little over 3GB.

The chroot lives by default at ${HOME}/chromiumos/chroot. Inside that directory you will find system directories like /usr/bin and /etc. These are local to the chroot and are separate from the system directories on your machine. For example, the chroot has its own version of the ls utility. It will be very similar, but it is actually a different binary than the normal one you use on your machine.

SIDE NOTES:

    You shouldn't have to create the chroot very often. Most developers create it once and never touch it again unless someone explicitly sends out an email telling them to recreate their chroot.
    The cros_sdk command currently doesn't work behind a proxy server, but there is a workaround.
    To help personalizing your chroot, the file ${HOME}/.cros_chroot_init is executed (if it exists) when the chroot is created.  The path to the chroot is passed as its argument ($1).


Enter the chroot
Most of the commands that Chromium OS developers use on a day-to-day basis (including the commands to build a Chromium OS image) expect to be run from within the chroot. You can enter the chroot by calling:

./chromite/bin/cros_sdk

This is the same command used to create the chroot, but if the chroot already exists, it will just enter.

NOTE: if you want to run a single command in the chroot (rather than entering the chroot), prefix that command with cros_sdk -- .

This command will probably prompt you for your password for the sudo command (entering the chroot requires root privileges). Once the command finishes, that terminal is in the chroot and you'll be in the ~/trunk/src/scripts directory, where most build commands live. In the chroot you can only see a subset of the filesystem on your machine. However, through some trickery (bind mounts), you will have access to the whole src directory from within the chroot – this is so that you can build the software within the chroot.

Note in particular that the src/scripts directory is the same src/scripts directory as you were in before you entered the chroot, even though it looks like a different location. That's because when you enter the chroot, the ~/trunk directory in the chroot is mounted such that it points to the main Chromium OS directory ${HOME}/chromiumos. That means that changes that you make to the source code outside of the chroot immediately take effect inside the chroot.

Calling this will also install a chroot, if you don't have one yet, for example by not following the above.
"
read readline

echo "While in the chroot you will see a special \"(cros-chroot)\" prompt to remind you that you are there:

(cros-chroot) johnnyrotten@flyingkite ~/trunk/src/scripts $ 

You generally cannot run programs on your filesystem from within the chroot. For example, if you are using eclipse as an IDE, or gedit to edit a text file, you will need to run those programs outside the chroot. As a consolation, you can use vim. If you are desperate for emacs, try typing sudo emerge emacs. Of course this command will build emacs from source so allow 5-10mins.

IMPORTANT NOTES:

    In this document, commands that are intended to be entered inside the chroot, and paths inside the chroot, are colored purple.
    If you need to delete your chroot, use cros_sdk --delete to delete it properly. Using rm -rf could end up deleting your source tree due to the active bind mounts.


SIDE NOTES:

    If you need to share lots of files inside and outside chroot (for example, settings for your favorite editor / tools, or files downloaded by browser outside chroot, etc.), read Tips and Tricks.
    There is a file system loop because inside ~/trunk you will find the chroot again. Don't think about this for too long. If you try to use du -s ${HOME}/chromiumos/chroot/home you might get a message about a corrupted file system. This is nothing to worry about, and just means that your computer doesn't understand this loop either. (If you can understand this loop, try something harder.)
"
read readline

echo "Select a board
Building Chromium OS produces a disk image (usually just called an \"image\") that can be copied directly onto the boot disk of a computer intended to run Chromium OS.  Depending on the specifics of that computer, you may want different files in the disk image. For example, if your computer has an ARM processor, you'll want to make sure that all executables in the image are compiled for the ARM instruction set. Similarly, if your computer has special hardware, you'll want to include a matching set of device drivers.
Different classes of computers are referred to by Chromium OS as different target \"boards\"  The following are some example boards:

    x86-generic - builds a generic image suitable for computers with a x86-compatible CPU
    arm-generic - builds a generic image suitable for computers with an ARM CPU

You need to choose a board for your first build. Don't worry too much about this choice – you can always build for another board later. If you want a list of known boards, you can look in ~/trunk/src/overlays.

Each command in the build processes takes a --board parameter.  To facilitate this, it can be helpful to keep the name of the board in a shell variable. This is not strictly necessary, but if you do this, you can simply copy and paste the commands below into your terminal program. Enter the following inside your chroot (note: change x86-generic to whatever board you want to build for):
"
export BOARD=x86-generic

echo "This setting only holds while you stay in the chroot. If you leave and come back, you need to do specify this setting again.

Initialize the build for a board
To start building for a given board, issue the following command inside your chroot (you should be in the ~/trunk/src/scripts directory):
"

./setup_board --board=${BOARD}

echo "This command sets up the board target with a default sysroot of /build/${BOARD}. The command downloads a small amount of stuff and takes a few minutes to complete.


SIDE NOTES:

    If you pass the --default flag to setup_board, the command writes the board name in the file ~/trunk/src/scripts/.default_board (it does the same thing as echo ${BOARD} > ~/trunk/src/scripts/.default_board). This makes it so that you don't need to specify a --board argument to subsequent commands. These instructions do not use the --default flag so that you can explicitly see what commands are board-specific.
    If you have previously set up this board, the setup_board command will fail. If you really want to clobber your old board files and start fresh, try passing the --force flag, which deletes the old /build/${BOARD} directory for you. Like cros_sdk, most people only re-run setup_board when told to (they don't re-run it even after a repo sync).
    You can delete the board sysroot at any time with: sudo rm -rf /build/${BOARD}


Set the chronos user password
On a Chromium OS computer, you can get command line access (and root access through the sudo command) by logging in with the shared user account "chronos".  You should set a password for the chronos user by entering the command below from inside the ~/trunk/src/scripts directory:
./set_shared_user_password.sh
"
read readline
./set_shared_user_password.sh

echo "You will be prompted for a password, which will be stored in encrypted form in /etc/shared_user_passwd.txt. 

SIDE NOTES:

    The encrypted password is stored inside chroot. That means that if you recreate your chroot, you have to run this command again.
    If you don't set a shared user password, the password for the chronos account may end up being any number of things depending on some complicated (and constantly evolving) formula that includes whether you build a developer image, whether you boot into developer mode, and the current state of the scripts.  The password might be empty, or a well-known string, or it might be impossible to login with chronos.  It is strongly recommended that you simply set a shared user password.  TODO: put a link to some place with more info about this.


Build the packages for your board
To build all the packages for your board, run the following command from inside the ~/trunk/src/scripts directory:
"
read readine
./build_packages --board=${BOARD}
read readine

echo "This step is the rough equivalent of make all in a standard Makefile system.  This command handles incremental builds; you should run it whenever you change something and need to rebuild it (or after you run repo sync). 

Normally, the build_packages command builds the stable version of a package (i.e. from committed git sources), unless you are working on a package (with cros_workon). If you are working on a package, build_packages will build using your local sources. See below for information about cros_workon.


SIDE NOTES: 

    Even though there are some flags that can optimize your build (like --nowithdev, --nowithautotest, etc), you should not use these flags (even if you don't plan on building a developer / test image). There are some issues with virtual packages that can cause some hard-to-debug differences if you use one of these flags.
    The --nowithdebug flag is an exception to the previous point.  By default, packages other than Chrome will be compiled in debug mode; that is, with  NDEBUG undefined and with debugging constructs like  DCHECK,  DLOG, and the red "Debug image" message present.  If you supply --nowithdebug, then  NDEBUG will be defined and the debugging constructs will be removed.
    The first time you run the build_packages command, it will take a long time (around 90 minutes on a four core machine), as it must build every package, and also download about 1.7GB of source packages and 1.3GB of binary packages. See here for more information about what the build_packages command actually does. In short, it tries to download existing binary packages to avoid building anything (and puts them in/build/${BOARD}/packages for subsequent builds). Failing that, it downloads source packages, puts them in /var/lib/portage/distfiles-target, and builds them.


Build a disk image for your board
Once the build_packages step is finished, you can build a Chromium OS-base developer image by running the command below from inside the ~/trunk/src/scripts directory:
./build_image --board=${BOARD} --noenable_rootfs_verification dev
"
read readline
./build_image --board=${BOARD} --noenable_rootfs_verification dev

echo "The args for build_image specify what type of build you want (dev in the example above).  Developers should normally build developer (dev) images.  A developer image provides a Chromium OS-based image with additional developer packages.  The --noenable_rootfs_verification turns off verified boot allowing you to freely modify the root file system.  The system is less secure using this flag, however, for rapid development you may want to set this flag.  If you would like a more secure, locked-down version of Chromium OS, then simply remove the --noenable_rootfs_verification flag.  Finally if you want just the pristine Chromium OS-based image (closest to Chrome OS but not quite the same), pass in base rather than dev.  Use build_image --help for more information.

The image produced by build_image will be located in ~/trunk/src/build/images/${BOARD}/versionNum/ (where versionNum will actually be a version number).  The most recent image produced for a given board will be symlinked to ~/trunk/src/build/images/${BOARD}/latest.

IMPORTANT NOTE: It's up to you to delete old builds that you don't need. Every time you run build_image, the command creates files that take up over 4GB of space(!).

Look at your disk image (optional)
If you want, you can look at the rootfs of the disk image that you just created by using the following commands:
"
read readline

cd ~/trunk/src/build/images/${BOARD}/latest
./unpack_partitions.sh chromiumos_image.bin
mkdir -p rootfs
sudo mount -o loop part_3 rootfs
read readline
echo "This will do a loopback mount of the rootfs from your image to the location ~/trunk/src/build/images/${BOARD}/latest/rootfs in your chroot.

If you built an x86 Chromium OS image, you can probably even try chrooting into the image:"

read readline

sudo chroot ~/trunk/src/build/images/${BOARD}/latest/rootfs

echo "This is a little hacky (the Chromium OS rootfs isn't really designed to be a chroot for your host machine), but it seems to work pretty well. Don't forget to exit this chroot when you're done.

When you're done, unmount the root filesystem:
"
sudo umount ~/trunk/src/build/images/${BOARD}/latest/rootfs 

echo "If you don't want to unpack the partitions (which takes up extra disk space), you can also mount directly without unpacking:

./mount_gpt_image.sh --board=${BOARD} -f $(./get_latest_image.sh --board=${BOARD})

Again, don't forget to unmount the root filesystem when you're done:

./mount_gpt_image.sh --board=${BOARD} -u 
"
read readline

echo "Installing Chromium OS on your Device
Getting your image running on a computer without verified boot
If you are trying to run your image on a normal computer, laptop, or netbook (one that didn't come installed with Google Chrome OS), follow the instructions in this section. Said another way:

    This section is NOT for use on the Google Cr-48 Notebook. See below if you have a Cr-48 Notebook.

Put your image on a USB disk
The easiest way to get your image running on your target computer is to put the image on a USB flash disk (sometimes called a USB key), and boot the target computer from the flash disk. The first step is to insert a USB flash disk (4GB or bigger) into your build computer. This disk will be completely erased, so make sure it doesn't have anything important on it.  Wait ~10 seconds for the USB disk to register, then type the following command in the ~/trunk/src/scripts directory:

./image_to_usb.sh --board=${BOARD}

Since you didn't pass a --to parameter, the image_to_usb.sh command lists all the USB disks that it finds.  If your USB disk is not listed, wait a few seconds and try the command again. Note that your USB disk may show up as something like /dev/sdc. Once the command finds your USB disk, run the command again with the --to parameter (you should replace ${MY_USB_KEY_LOCATION} with the location for your disk, like /dev/sdc):

./image_to_usb.sh --board=${BOARD} --to=${MY_USB_KEY_LOCATION}

When the image_to_usb.sh command finishes, you can simply unplug your USB key and it's ready to boot from.

IMPORTANT NOTE: To emphasize again, image_to_usb.sh completely replaces the contents of your USB disk. Make sure there is nothing important on your USB disk before you run this command.

SIDE NOTES:

    By default, image_to_usb.sh uses the latest image for the given board. If you want to use an image from a different directory, you can specify the directory with the --from flag.
    If you want to create a test image (used for allowing Chromium OS to talk to autotest), see the Running Tests section.

Boot from your USB disk
You should be able to configure your target computer's BIOS to boot from your USB key. After you've done that, simply plug in your newly minted USB key and reboot your target computer – it should now boot from the Chromium OS image on your USB key. Your Chromium OS image may not have all the drivers to run all of the peripherals on your computer, but it should at least boot.

For specific information about what works on various different machines, see the Developer Hardware page.


Getting your image running on a Chrome OS Notebook
Follow the instructions in this section if you are trying to get your image running on a system has an official Chrome OS BIOS; eg, the Cr-48 Chrome Notebook. Said another way:

    Use the previous section for a normal computer. This section is ONLY for use on computers that have an official Google Chrome OS BIOS such as the Cr-48 Chrome Notebook.

    For "Alex" devices, see the Samsung Series 5 Chromebook developer page. 

A quick primer on verified boot
You must understand a bit about verified boot before you can go any further. Unless you crack open the hardware on your notebook (which probably voids any warranty you might have), having a computer with verified boot means:

    You can only boot from a USB disk if the boot image on the USB disk has been signed by the "recovery key" for your device. Since the recovery key is tightly controlled, that means you'll need to obtain a Recovery Kernel built and signed by a person with access to the key (like your hardware manufacturer).
    If your device is in "release mode":
        You can only boot from the internal SSD if the boot image on the SSD has been signed by the "release key". The release key is also tightly controlled, so that means devices in "release" mode can only boot official images.
    If your device is in "developer mode":
        You can boot any self-signed image from the internal SSD.

If you're quick, then you've probably figured out that one way to boot your image on your device is:

    Switch your device to Developer Mode.
    Use an officially-signed Recovery Kernel for your device to flash your self-signed image onto the device's SSD.

Let's go through that one step at a time.
Get your Chrome OS Notebook into Developer Mode
This is different for each computer, but it usually involves flipping a switch that's under the battery (and sometimes also under a sticker).  You'll want to reference the documentation for your Chrome OS Notebook.

SIDE NOTE: Switching into Developer Mode does a lot of stuff (erasing your stateful partition, disabling some of the checks that make sure you're running official code, etc). See the documentation for your Chrome OS Notebook for details.
Get an officially-signed Recovery Kernel for your Chrome OS Notebook
The recovery key is different for every version of Chrome OS Notebook, which means you'll need to get a different Recovery Kernel for the type of Chrome OS Notebook you have. You might be able to find a link to download a Recovery Kernel in the documentation for your Chrome OS Notebook. If not, you might be able to extract an officially-signed Recovery Kernel from an officially-signed Recovery Image (Recovery Images are sometimes easier to find).

As an example, you can get an officially-signed Recovery Kernel for the Cr-48 Chrome Notebook (AKA Mario) by running the steps below from inside the chroot:

curl https://dl.google.com/dl/edgedl/chromeos/recovery/mario_recovery_kernel.zip > ~/trunk/mario_recovery_kernel.zip
unzip -d ~/trunk ~/trunk/mario_recovery_kernel.zip

RECOVERY_KERNEL=~/trunk/mario_recovery_kernel.bin

The instructions below assume that you've set the RECOVERY_KERNEL variable as above.
Build your own recovery image
Now that you have a built image and an officially-signed Recovery Kernel, you can build your own recovery image using mod_image_for_recovery.sh.  This image will have the officially-signed Recovery Kernel (so you can boot from USB) and will install a self-signed SSD image (so you can boot only with developer mode).  Here's the magic set of steps (assuming that you've got a path to the recovery kernel in ${RECOVERY_KERNEL} and that the recovery kernel is a match for the ${BOARD} you built):

./mod_image_for_recovery.sh \
    --board=${BOARD} \
    --nominimize_image \
    --kernel_image ${RECOVERY_KERNEL} \
    --image ~/trunk/src/build/images/${BOARD}/latest/chromiumos_image.bin

SIDE NOTE: If you're interested in creating a test image (used for allowing Chromium OS to talk to autotest), you can run build_image test to create a test image that can be combined with the recovery image:

./build_image --board=${BOARD} test

./mod_image_for_recovery.sh \
    --board=${BOARD} \
    --nominimize_image \
    --kernel_image ${RECOVERY_KERNEL} \
    --image ~/trunk/src/build/images/${BOARD}/latest/chromiumos_test_image.bin

Copy the recovery image to a USB key
The first step is to insert a USB flash disk (4 GB or bigger) into your build computer. This disk will be completely erased, so make sure it doesn't have anything important on it.  Wait ~10 seconds for the USB disk to register, then type the following command in the ~/trunk/src/scripts directory:

./image_to_usb.sh --board=${BOARD}

Since you didn't pass a --to parameter, the image_to_usb.sh command lists all the USB disks that it finds.  If your USB disk is not listed, wait a few seconds and try the command again. Note that your USB disk may show up as something like /dev/sdc. Once the command finds your USB disk, run the command again with the --to parameter (you should replace ${MY_USB_KEY_LOCATION} with the location for your disk, like /dev/sdc):

./image_to_usb.sh --board=${BOARD} --image_name=recovery_image.bin --to=${MY_USB_KEY_LOCATION}

When the image_to_usb.sh command finishes, you can simply unplug your USB key and it's ready to boot from.

IMPORTANT NOTE: To emphasize again, image_to_usb.sh completely replaces the contents of your USB disk. Make sure there is nothing important on your USB disk before you run this command.

SIDE NOTES:

    By default, image_to_usb.sh uses the latest image for the given board. If you want to use an image from a different directory, you can specify the directory with the --from flag.
    If you want to create a test image (used for allowing Chromium OS to talk to autotest), see the Running Tests section.
    If you inspect the USB flash disk from outside the chroot before running image_to_usb.sh the script will be unable to mount the disk within the chroot.  Simply unmount the disk and try again.

Install your image to the SSD
In developer mode, your Chrome OS Notebook gives you an option to use a recovery image every time the machine boots. To install your recovery image, do the following:

    Turn your Chrome OS Notebook off.
    Turn it back on.
    During the boot warning, press space to enter recovery mode.
    Wait until prompted to put your USB disk in.
    Put the USB disk in.
    Wait while the image is copied to the SSD.

If you reboot now, you'll be booting from your image (you may need to wait past the recovery screen).  Congratulations!

IMPORTANT NOTE: You must stay in Developer Mode to continue booting your image. Since your image was not signed by the release keys (it's self-signed image), it will only boot in Developer Mode. If you want to go back to Release Mode, just copy (/bin/dd) the .bin file that you first extracted from the .zip file above directly to a USB drive, without making any modifications to it.

Getting to a command prompt on Chromium OS
Since you set the shared user password (with set_shared_user_password.sh) when you built your image, you have the ability to login as the chronos user:

    After your computer has booted to the Chromium OS login screen, press [ Ctrl ] [ Alt ] [ F2 ] to get a text-based login prompt.
    Login with the chronos user and enter the password you set earlier.

Because you built an image with developer tools, you also have an alternate way to get a terminal prompt. The alternate shell is a little nicer (in the very least, it keeps your screen from dimming on you), even if it is a little harder to get to. To use this alternate shell:

    Go through the standard Chromium OS login screen (you'll need to setup a network, etc.) and get to the web browser.  It's OK to login as guest.
    Press [ Ctrl ] [ Alt ] [ T ] to get the crosh shell.
    Use the shell command to get the shell prompt. NOTE: you don't need to enter the chronos password here, though you will still need the password if you want to use the sudo command.


Installing your Chromium OS image to your hard disk
If you followed the set of instructions for a Chrome OS Notebook, the image is already on your hard disk. However, if you booted Chromium OS straight from a USB key, you might want to put your image onto the hard disk.

Once you've booted from your USB key and gotten to the command prompt, you can install your Chromium OS image to the hard disk on your computer with this command:

/usr/sbin/chromeos-install

IMPORTANT NOTE: Installing Chromium OS onto your hard disk will WIPE YOUR HARD DISK CLEAN.

Building an image to run in a virtual machine
Many times it is easier to simply run Chromium OS in a virtual machine like kvm.  You can adapt the previously built Chromium OS image so that it is usable by kvm (which uses qemu images) by entering this command from the ~/trunk/src/scripts directory:

./image_to_vm.sh --board=${BOARD}

This command creates the file ~/trunk/src/build/images/${BOARD}/latest/chromiumos_qemu_image.bin.

SIDE NOTES:

    If you want to adapt the image for other virtual machines, see the --format=vmware and --format=virtualbox options. [Note: Only KVM/QEMU VM's are actively supported at the moment, other formats may or may not work on a given build]
    You can specify source/destination paths with the --from and --to parameters.
    If you're interested in creating a test image (used for allowing Chromium OS to talk to autotest), see the Running Tests section.



Making changes to packages whose source code is checked into Chromium OS git repositories
Keep the tree green
Now that you can build and run Chromium OS, you're ready to start making changes to the code.

Before you start, take a moment to understand Chromium's source management strategy of "keeping the tree green". For the Chromium OS project, keeping the tree green means:

    Any new commits should not destabilize the build:
        Images built from the tree should always have basic functionality working.
        There may be minor functionality not working, and it may be the case, for example, that you will need to use Terminal to fix or work around some of the problems. 

    If you must introduce unstable changes to the tree (which should happen infrequently), you should use parameterization to hide new, unstable functionality behind a flag that's turned off by default. The Chromium OS team leaders may need to develop mechanisms for parameterizing different parts of the system (such as the init script).

    Internal "dev channel" releases will be produced directly from the tree, with a quick branch to check-point the release version. Any fixes required for a release will be pulled from the tree, avoiding merges back to tree.

This strategy has many benefits, including avoiding separate build trains for parallel development (and the cost of supporting such development), as well as avoiding large, costly merges from forked branches.

SIDE NOTE: "Keep the tree green" means something a bit different for Chromium OS than for Chromium, which is much further along in its life cycle. 

The steps in this section describe how to make changes to a Chromium OS package whose source is checked into the Chromium OS source control system. Specifically, this is a package where:

    The ebuild for the package lives in the src/third_party/chromiumos-overlay or src/overlays/overlay-${BOARD} directories.
    There is an ebuild for the package that ends with 9999.ebuild.
    The ebuild inherits from the cros-workon class.
    The ebuild has a KEYWORD in the ebuild containing this architecture name (like "x86").

You can see a list of all such packages by running the following command from inside the ~/trunk/src/scripts directory:

cros_workon --board=${BOARD} list --all

Run cros_workon start
The first thing you need to do is to mark the package as active. Use the command below, replacing ${PACKAGE_NAME} with your package name (e.g., chromeos-wm):

cros_workon --board=${BOARD} start ${PACKAGE_NAME}

This command:

    Indicates that you'd like to build the 9999 version of the ebuild instead of the stable, committed version.
    Indicates that you'd like to build from source every time.
    If you specified that you wanted the minilayout when you did your repo init, this command adds a clause to your .repo/local_manifest.xml to tell repo to sync down the source code for this package next time you do a repo sync.


Run repo sync
After running cros_workon, sync down the sources. This is critical if you're using the minilayout, but is probably a good idea in any case to make sure that you're working with the latest code (it'll help avoid merge conflicts later).  Run the command below from outside the chroot, anywhere under your ~/chromiumos directory:

repo sync


Find out which ebuilds map to which directories
The cros_workon tool can help you find out what ebuilds map to each directory. You can view a full list of ebuilds and directories using the following command:

cros_workon info --board=${BOARD} --all

If you want to find out which ebuilds use source code from a specific directory, you can use grep to find them. For example:

cros_workon info --board=${BOARD} --all | grep platform/ec

This returns the following output:
    chromeos-base/ec-utils chromiumos/platform/ec src/platform/ec

This tells you the following information:

    The name of the ebuild is chromeos-base/ec-utils
    The path to the git repository on the server is chromiumos/platform/ec
    The path to the source code on your system is src/platform/ec

You can similarly find what source code is associated with a given ebuild by grepping for the ebuild name in the list.

To find out where the ebuild lives:

equery-${BOARD} which ${PACKAGE_NAME}

As an example, for PACKAGE_NAME=ec-utils, the above command might display:
    /home/.../trunk/src/third_party/chromiumos-overlay/chromeos-base/ec-utils/ec-utils-9999.ebuild

SIDE NOTE: If you run the same command without running cros_workon first, you can see the difference:
    /home/.../trunk/src/third_party/chromiumos-overlay/chromeos-base/ec-utils/ec-utils-0.0.1-r134.ebuild

Create a branch for your changes
Since Chromium OS uses repo/git, you should always create a local branch whenever you make changes.

First, find the source directory for the project you just used cros_workon on. This isn't directly related to the project name you used with cros_workon. (This isn't very helpful - someone with more experience, actually tell us how to find it reliably? --Meredydd)

cd into that directory, in particular the "files/" directory in which the actual source resides. In the command below, replace ${BRANCH_NAME} with a name that is meaningful to you and that describes your changes (nobody else will see this name):

repo start ${BRANCH_NAME} .

The branch that this creates will be based on the remote branch (which one? --Meredydd). If you've made any other local changes, they will not be present in this branch.

Make your changes
You should be able to make your changes to the source code now.  To incrementally compile your changes, use 

./bin/cros_workon_make --board=${BOARD} ${PACKAGE_NAME}

This will build your package inside your source directory.  Change a single file, and it will rebuild only that file and re-link.  If your package contains test binaries, using

./bin/cros_workon_make --board=${BOARD} ${PACKAGE_NAME} --test

will build and run those binaries as well.  Call cros_workon_make --help to see other options that are supported.

You probably want to get your changes onto your device now.  You need to install the changes you made by using 

./bin/cros_workon_make --board=${BOARD} ${PACKAGE_NAME} --install

You can then rebuild an image with build_image and reimage your device.  ...but you might also want to take a peek at the devserver instructions if you want something a little quicker.

Set your editor
Many of the commands below (in particular git) open up an editor. You probably want to run one of the three commands below depending on your favorite editor. 

If you're not a *nix expert, nano is a reasonable editor:

export EDITOR='nano'

If you love vi:

export EDITOR='vi'

If you love emacs (and don't want an XWindow to open up every time you do something):

export EDITOR='emacs -nw'

You should probably add one of those lines to your .bashrc (or similar file) too.

Submit changes locally
When your changes look good, commit them to your local branch using git. Full documentation of how to use git is beyond the scope of this guide, but you might be able to commit your changes by running something like the command below from the project directory:

git commit -a

The git commit command brings up a text editor. You should describe your changes, save, and exit the editor. Note that the description you provide is only for your own use. When you upload your changes for code review, the repo upload command grabs all of your previous descriptions, and gives you a chance to edit them.

Upload your changes and get a code review
Once your changes are committed locally, upload your changes using repo upload. The repo upload command takes all of the changes that are unmerged and asks them if you want to upload them.  You can specifically say to only look for unmerged changes in your current repo by passing in '.'.  Please note that you must have a Gerrit account before you can upload changes.

repo upload [.|project-name]

It is important to note that repo uses the Change-Id in your git commits to track code reviews.  So in order to work on a CL the standard work flow is to use git commit --amend rather than make a new commit.  This differs from our old git-cl style.

In your local commit logs make sure to add a BUG= field and TEST= field.  For BUG=, you should put something that looks like: BUG=bug-tracker:number. You can get a tracker name by looking in the upper-left corner of the tracker page (e.g. in the image on the right, the tracker name is "chromium-os"). If your changes are related to more than one tracker issue, you can list all the issues separated with commas.

For TEST=, you should describe what you did to test the changes.

Here's what a sample description should look like:

# Enter a description of the change.
# This will displayed on the codereview site.
# The first line will also be used as the subject of the review.
Here's a SHORT, one-line summary of my change.

And here are more details
...this can be as long as I want.

BUG=chromium-os:99999, chromium:88888
TEST=Ran all the white box tests

Change-Id: I8d7f86d716f1da76f4c85259f401c3ccc9a031ff
Once you run repo upload, this uploads the changes and prints out a URL for the code review (if its a new code review). Go to that URL (log in with your chromium.org account, which you might want to do in an "incognito" window in Chrome), and use the "Review->Publish Comments" link to mail your changes to your reviewers.

You should pick reviewers that know the code you're working on well and that will do the best reviews. Picking reviewers who will just rubber-stamp your changes is a bad idea. The point of submitting changes is to submit good code, not to submit as much code as you can. If you don't know who should review your changes, start by looking at the git log for the project that you're working on. Simply type the command below in a directory related to your project:

git log


Your reviewers will likely provide comments about changes that you should make before submitting your code. You should make such changes, submit them locally, and then re-upload your changes for code review by amending your changes to your git commit and re-running repo upload.
# make some changes
git add -u .
git commit --amend

If you have a chain of commits (which repo upload . converts to a chain of CLs), and you need to modify any commits that are not at the top of the chain, use interactive rebase:
git rebase -i
# This shows a list of cherry-picks into a temporary branch.
# Change some of the "pick" keywords to "edit".  Then exit the editor.
git log # shows you are at the first "edit"ed commit.  All earlier commits are cherry-picked.
# Make some modifications.
git add -u .
git commit --amend
git rebase --continue # goes to the next "edit"ed commit.
repo upload . # when all modifications are ready to be uploaded again.

Try seeing the mainline again
While you're working on your changes, you might want to go back to the mainline for a little while (maybe you want to see if some bug you are seeing is related to your changes, or if the bug was always there). If you want to go back to the mainline without abandoning your changes, you can run the following command from within a directory associated with your project:

git checkout cros/master

When you're done, you can get back to your changes by running:

git checkout ${BRANCH_NAME} 

Work on something else while you're waiting
If you want to start on another (unrelated) change while waiting for your code review, you can repo start another branch. When you want to get back to your first branch, run the following command from within a directory associated with your project:

git checkout ${BRANCH_NAME} 

Send your changes to the Commit Queue
Eventually, all your reviewers will be happy and will give you a Looks Good and Approved (the latter is only available to owners of the code) message in Gerrit.  If they choose to test it they can also mark Verify.  Both Looks Good and Approved + Verified must be set in order to commit your CL.  Once they are set, set the Commit Ready bit on your CL, and the commit queue will test the change.

Note it is possible that your change will be rejected because of a merge conflict.  If it is, rebase against any new changes and re-upload your patch.  This patch will have to be re-approved before it is allowed to be committed. (Note: If it's just a trivial rebase, you can approve the rebase yourself.)

Make sure your changes didn't break things
After you commit, make sure you didn't break the build by checking the buildbot.

(Non-committers) Submit your changes
If you're not a committer, you must push your changes by submitting a patch to the the Chromium OS dev group.  However, the patch should go through the standard Gerrit review process before-hand and you'll have to ask one of the reviewers (who is a committer) to submit it for you.

Share your changes using the Gerrit sandbox
It is possible to upload changes to a personal sandbox on Gerrit. This way, a change can be shared between developers before it is ready for code review.

project_url=ssh://gerrit.chromium.org:29418/$(git config remote.cros.projectname)
git push $project_url HEAD:refs/sandbox/${USER}/${BRANCH_NAME}

Other developers can then fetch your changes using the following commands:

git fetch cros refs/sandbox/${USER}/${BRANCH_NAME}
git checkout FETCH_HEAD

In a given repository, you can explore sandboxes using the ls-remote command:

git ls-remote cros "refs/sandbox/${USER}/*"
git ls-remote cros "refs/sandbox/*"

Once you're finished with a sandbox, you can delete it using the following commands:

project_url=ssh://gerrit.chromium.org:29418/$(git config remote.cros.projectname)
git push $project_url :refs/sandbox/${USER}/${BRANCH_NAME}

Clean up after you're done with your changes
After you're done with your changes, you're ready to clean up. The most important thing to do is to tell cros_workon that you're done by running the following command:

cros_workon --board=${BOARD} stop ${PACKAGE_NAME}

This command tells cros_workon to stop forcing the -9999.ebuild and to stop forcing a build from source every time.

You can also delete the branch that repo created. There are a number of ways to do so; here is one way:

repo abandon ${BRANCH_NAME} ${CROS_WORKON_PROJECT}


SIDE NOTES:

    If you don't specify a project name, the repo abandon command will throw out any local changes across all projects. You might also want to look at git branch -D or repo prune.
    If you're using the minilayout, doing a cros_workon stop will not remove your source code. The code will continue to stay on your hard disk and get synced down.

Making changes to non-cros_workon-able packages
If you want to make to changes to something other than packages whose source is checked into the Chromium OS source control system, you can follow the instructions in the previous section, but skip the cros_workon step. Note specifically that you still need to run repo start to create a branch for your changes.

The types of changes that fall into this category include:

    changes to build scripts (pretty much anything in src/scripts)
    changes to ebuild files themselves (like the ones in src/third_party/chromiumos-overlay)
    adding small patches to existing packages whose source code is NOT checked into Chromium OS git repositories
    changes to eclass files (like the ones in src/third_party/chromiumos-overlay/eclass)
    changes to the buildbot infrastructure (in crostools)
    TODO: anything else?

Adding small patches to existing packages
When you need to add small patches to existing packages whose source code is not checked into a Chromium OS git repository (e.g. it comes from portage, and is not a cros_workon-able package), you need to do the following:

First, find the package ebuild file under third_party/chromiumos-overlay.

Then, create a patch file from the exact version of the package that is used by the current ebuild.  If other patches are already in the ebuild, you'll want to add your patch LAST, and build the patch off of the source that has already had the existing patches applied (either do it by hand, or set FEATURES=noclean and build your patch off of the temp source).  Note that patch order is significant, since the ebuild expects each patch line number to be accurate after the previous patch is applied.

Place your patch in the "files" subdir of the directory that contains the ebuild file (e.g. third_party/chromiumos-overlay/dev-libs/mypackage/files/mypackage-1.0.0-my-little-patch.patch).

Then, in the prepare() section of the ebuild (create one if it doesn't exist), add an epatch line:

epatch "${FILESDIR}"/${P}-my-little-patch.patch

Lastly, you'll need to bump the revision number in the name of the ebuild file (or symlink) so the build system picks up the change.  The current wisdom is that the ebuild file should be symlinked instead of being renamed.  For example, if the original ebuild file is "mypackage-1.0.0.ebuild", you should create a "mypackage-1.0.0-r1.ebuild" symbolic link that points at the original ebuild file.  If that symlink already exists, create the next higher "rN" symlink.
Making changes to the way that the chroot is constructed
TODO: This section is currently a placeholder, waiting for someone to fill it in.  However, a few notes:

    Many of the commands that take a --board=${BOARD} parameter also take a --host parameter, which makes the commands affect the host (i.e. the chroot) rather than the board.
        Most notably, cros_workon --host says that you want to build a package used in the chroot from source.


Building an individual package
TODO: Document this better, and add the new cros_workon_make.

SIDE NOTE:To build an individual portage package, for a particular board, use emerge-${BOARD}.
For example, if you want to build dash to test on your device:

emerge-${BOARD} dash


Making changes to the Chromium web browser on Chromium OS
If you want to make modifications to the Chromium web browser and run your custom version of the Chromium web browser on Chromium OS, see Making changes to the Chromium web browser on Chromium OS.

Using Clang to get better compiler diagnostics

Description
The ChromeOS toolchain provides a feature to get Clang syntax-only compiler diagnostics without having to do a separate build with the Clang compiler. To enable this feature, add '-clang' to the C[XX]FLAGS used by the package for its build. 

Addition of the '-clang' option to the build is interpreted by the compiler driver wrapper script, which then invokes Clang with -fsyntax-only option, and after a successful Clang run, invokes the gcc compiler. Any errors generated by Clang will stop compilation just like a regular build does. In addition to Clang warnings, you will also see warning from gcc, in some cases for the same source construct. 

The presence of a few specific gcc options, for example, '-print-*' or '-E' will disable a clang run, even if '-clang' is specified. This is to allow package configure scripts to run correctly even in the presence of the '-clang' option. 


Wrapper Options

The wrapper script also interprets a few other options. All options specific to the wrapper only are tabulated below:

 Option 	Description
 -clang 	Invoke Clang front-end with -fsyntax-only and all other options specified on the command line. On successful completion of Clang compile, continue the build with gcc or g++. 
The presence of '-print-*', '-dump*', '@*', '-E', '-' or '-M' will disable clang invocation. 
 -Xclang-only=<option> 	This is a special option that can be used to pass <option> to Clang and not to gcc or g++. This can be used, for example, to turn off a specific Clang warning.
Example: -Xclang-only=-Wno-c++11-extensions will add -Wno-c++11-extensions to the Clang invocation.
-print-cmdline 	In addition to doing the builds, print the exact command-line used for both Clang and gcc. 


Testing
You can test your package with Clang before adding '-clang' to your ebuild or Makefiles using the CFLAGS or CXXFLAGS variable. While using this, you need to be careful not to overwrite existing CFLAGS or CXXFLAGS. Here's an example: 

(cr) $ CFLAGS="$(portageq-$board envvar CFLAGS) -clang" CXXFLAGS="$(portageq-$board envvar CXXFLAG) -clang" emerge-$board chromeos-chrome

After your package builds cleanly with Clang, you can add '-clang' to your e-build. 

Local Debugging

Debugging x86 binaries on your workstation.
If you build your projects incrementally, write unit tests and use them to drive your development, you may want to debug your code without shipping it over to a running device or VM.

gdb_x86_local sets gdb up to load and run your target-compiled binaries.


(cr) ~/trunk/src/platform/shill $ gdb_x86_local -h

USAGE: /usr/bin/gdb_x86_local [flags] args
flags:
  --board:  The board to debug for. (default: '')
  --sysroot:  Where your target binaries are. (default: '')
  --debug_file_dir:  Where your split-out debug symbols are. (default: '')
  -h,--[no]help:  show this help (default: false)

"--board" is required, the other args are not.  The following will start gdb with your incrementally-compiled unittest binary.

(cr) ~/trunk/src/platform/shill $ gdb_x86_local --board x86-generic shill_unittest [corefile]


Remote Debugging

Setting up remote debugging by hand.
If you want to manually run through all the steps necessary to set up your system for remote debugging and start the debugger, see Remote Debugging in Chromium OS.

Automated remote debugging using gdb_remote script.
gdb_remote is a script that automates many of the steps necessary for setting up remote debugging with gdb.  It should already be installed in your chroot.  If you do not have the script, update your repository to get the latest changes, then re-build your packages:

repo sync

./build_packages --board=...

This should install gdb_remote in the /usr/bin directory inside the chroot.  The gdb_remote script takes several options.  --board and --remote_file are required, the rest are optional:

"--board" is self-explanatory.

"--remote" is the ip_address for your VM or notebook.  It defaults to the localhost (for running the VM);  if you are not debugging in the VM, then you need to specify the ip_address of the notebook you are using.

"--port" is the ssh port that will be used for communication between gdb and gdbserver.  It defaults to 1234, but you can specify another port number to use if you wish.

"--remote_file" is the complete pathname, on the notebook or in the VM, of the binary to be debugged.

"--remote_pid" defaults to 0, which means gdbserver will start the specified binary running; if you want to attach to an already running binary (e.g. chrome), you need to specify the PID of the running binary (in the VM or notebook) to which to attach. The --remote_file parameter is not required if --remote_pid is passed.

When you invoke gdb_remote, it will connect to the notebook or VM (automatically setting up port-forwarding on the VM), make sure the port is entered into the iptables, and start up gdbserver, using the specified port and binary, either attaching to the binary (if a remote_pid was specified) or starting up the binary, and waiting for gdb to connect.

It will then write a special .gdbinit file for you that sets up the sysroot and debug file directory for gdb and creates and executes a gdb_macro named 'remote_connect', and will start up the cross-built gdb for you. 


Examples of debugging using the gdb_remote script.
Below are two examples of using gdb_remote to start up debugging sessions.  The first example shows connecting to a VM  and having gdbserver start up a fresh copy of the binary to be debugged.  The second example shows connecting to an external notebook and having gdbserver attach to an existing process:

Example 1:

$ gdb_remote --board=${BOARD} --remote_file=/bin/ls
Verifying IP address localhost (this will take a few seconds)...
Starting up gdbserver on your remote device.
Warning: Permanently added '[localhost]:9222' (RSA) to the list of known hosts.
Warning: Permanently added '[localhost]:9222' (RSA) to the list of known hosts.
gdbserver is now running remotely.  Output will be written to
/tmp/gdbserver.out on your remote device.

To connect to gdbserver, type 'remote_connect' at the gdb prompt.

GNU gdb (Gentoo 7.2 vanilla) 7.2-gg15
Copyright (C) 2010 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
Type "show copying" and "show warranty" for licensing/warranty details.
This GDB was configured as "--host=x86_64-pc-linux-gnu
--target=i686-pc-linux-gnu".

<http://bugs.gentoo.org/>

0x777459c0 in print_statistics () from /build/x86-mario/lib/ld-linux.so.2
(gdb) b main
Breakpoint 1 at 0x8830: file ls.c, line 1197.
(gdb)


Example 2:

$ gdb_remote --board=${BOARD} --remote_pid=626 --remote=123.45.678.99
Verifying IP address 123.45.678.99 (this will take a few seconds)...
Starting up gdbserver on your remote device.
gdbserver is now running remotely.  Output will be written to
/tmp/gdbserver.out on your remote device.

To connect to gdbserver, type 'remote_connect' at the gdb prompt.

GNU gdb (Gentoo 7.2 vanilla) 7.2-gg15
Copyright (C) 2010 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
Type "show copying" and "show warranty" for licensing/warranty details.
This GDB was configured as "--host=x86_64-pc-linux-gnu
--target=i686-pc-linux-gnu".

<http://bugs.gentoo.org/>

0x73706424 in __kernel_vsyscall ()
(gdb)




Troubleshooting

My build is failing, what's the problem?
Your build may break because of transient failures introduced when an upstream dependency is in-flight while your dependent is built. These types of failures are often manifested as missing files or configuration information. Try re-running your build.

If re-running doesn't help, check the buildbot to see if the problem exists there as well.

How do I fix network problems in the chroot?
TODO: This troubleshooting tip was from the old instructions.  Is it still relevant?

When running emerge inside the chroot, the command uses wget to fetch packages. The wget process is run as the portage user, and if that user is unable to talk on the network the command will be unable to resolve hostnames, among other things. This can happen if the machine is using a local firewall service such as UncomplicatedFireWall (ufw package on Ubuntu) that limits network traffic to a specific set of users.

This network traffic limitation can be verified by looking at the output of iptables, for example with ufw:

$ sudo iptables -L ufw-after-output | grep owner
ACCEPT     all  --  anywhere             anywhere            owner UID match root
ACCEPT     all  --  anywhere             anywhere            owner UID match yourname

One way to get around this limitation is to add the portage user to the list of allowed users:

First, create the user on the build machine:

sudo useradd -d /var/tmp/portage -N -s /bin/false portage

Then add the user to the list of allowed users in /etc/ufw/after.rules and /etc/ufw/after6.rules:

# allow outbound connections by portage user for building chromiumos
-A ufw-after-output -m owner --uid-owner portage -j ACCEPT

Finally, restart the firewall:

sudo restart ufw


I lost my developer tools on the stateful partition, can I get them back?
This happens sometimes because the security system likes to wipe out the stateful partition and a lot of developer tools are in /usr/local/bin. But all is not lost because there is a tool for updating the stateful partition from an image created by the auto-update part of the dev_server. Sadly, it is normally found in /usr/local so will have been lost too and you need to copy it over manually. This works for me:

$ cd /tmp
$ scp me@myworkstation:/path/to/chromiumos/chroot/build/x86-whatever/usr/bin/stateful_update .
$ sudo sh stateful_update
$ sudo reboot

Note you can clobber the stateful partition (remove user accounts etc and force OOBE) as part of this process by using a flag:

$ cd /tmp
$ scp me@myworkstation:/path/to/chromiumos/chroot/build/x86-whatever/usr/bin/stateful_update .
$ sudo sh stateful_update --stateful_change=clean
$ sudo reboot


Running Tests
Many of the automated tests that are part of the Chromium OS project run using the autotest framework. See Autotest User Documentation for details.

Various quick links:
Creating a new test
Running Smoke Suite On a VM Image
Seeing which tests are implemented by an ebuild
Getting an image that has been modified for test - This doesn't work if you want to create a recovery image and boot a Cr48 with it, see below

If you wish to produce a VM image instead, you should omit the --test flag to build_image and let ./image_to_vm.sh produce the test image:
./image_to_vm.sh --board=${BOARD} --test_image 

Note: this difference between ./image_to_usb.sh and ./image_to_vm.sh arises because ./image_to_vm.sh does not yet support the --image_name flag and by default looks for chromiumos_image.bin.  We expect this to change in the future.

Note that creating a test image will change the root password of the image to test0000.  The --test_image flag causes the image_to_xxx commands to make a copy of your chromiumos_image.bin file called chromiumos_test_image.bin (if that file doesn't already exist), modify that image for test, and use the test image as the source of the command.

SIDE NOTES:

    When creating a VM image for testing purposes, it is highly recommended that you expand its stateful partition with the --statefulfs_size parameter. Otherwise, certain autotest scenarios will run out of stateful partition disk space since its default size on ChromeOS image files is equal to rootfs size of 2G. TODO: Is this still needed?  I don't think so now that the default stateful size is 2G.
    If the directory already has a file called chromiumos_test_image.bin, that file is reused. That means that calling both image_to_usb.sh and image_to_vm.sh doesn't waste time by creating the test image twice.

Creating a recovery image that has been modified for test
After building a test image using ./build_image test as described above, you may wish to encapsulate it within a recovery image:

./mod_image_for_recovery.sh \
    --board=${BOARD} \
    --nominimize_image \
    --kernel_image ${RECOVERY_KERNEL} \
    --image ~/trunk/src/build/images/${BOARD}/latest/chromiumos_test_image.bin \
    --to ~/trunk/src/build/images/${BOARD}/latest/recovery_test_image.bin

You can write this recovery image out to the USB device like so:

./image_to_usb.sh --board=${BOARD} --image_name=recovery_test_image.bin --to=${MY_USB_KEY_LOCATION}

Note that there are some downsides to this approach which you should keep in mind.

    Your USB image will be a recovery mode/test image, but the ordinary image in your directory will be a non-test image.
    If you use devserver, this will serve the non-test image not the test-image.
    This means a machine installed with a test-enabled USB image will update to a non-test-enabled one.

Additional information

Switching Toolchain Compilers
As of July, 2011, the default toolchain compiler for both ARM- and x86-based boards is gcc-4.4.3. It is possible to switch to a supported gcc-4.6.0 and try building packages using that. You may not be able to build an image completely or boot it if you use this compiler, though.

At any given time in the chroot, the default cross-compiler can be gcc-4.4.3-based or gcc-4.6.0-based. To see what cross-compiler is the current default one, do:

    For ARM: armv7a-cros-linux-gnueabi-gcc -v
    For x86: i686-pc-linux-gnu-gcc -v

To list available compilers, type:

    src/platform/dev/cros_gcc_config -l

This will print the list of available compilers to switch to.

To install gcc-4.6.0 cross compiler and make it the default, type:

    For ARM: src/platform/dev/cros_gcc_config armv7a-cros-linux-gnueabi-4.6.0
    For x86: src/platform/dev/cros_gcc_config i686-pc-linux-gnu-4.6.0

NOTE: It may take a while to install the gcc-4.6.0 compiler if you haven't yet installed it in your chroot.  You may have to run source /etc/profile, or exit your chroot and re-enter it, for the switch to take effect.

To switch back to the 4.4.3-based compiler, type:

    For ARM: src/platform/dev/cros_gcc_config armv7a-cros-linux-gnueabi-4.4.3
    For x86: src/platform/dev/cros_gcc_config i686-pc-linux-gnu-4.4.3

NOTE: If you use ./build_packages after switching the toolchain compiler, make sure to pass in --skip_toolchain_update.
Developer mode
It can be confusing to figure out what "developer mode" means: Some parts of this document talk about switching your hardware to developer mode, while other parts talk about entering developer mode by running an image built with the --withdev flag. For the most part, the two actions enable the same set of things (like the shell command in crosh). Thus, you can think of either action as enabling developer mode.

To provide some details:

    Putting your hardware into developer mode makes /bin/cros_boot_mode print developer. It also makes the file /mnt/stateful_partition/.developer_mode appear.
    Building with the --withdev flag creates a file called /root/.dev_mode (in addition to adding a whole bunch of useful developer tools to your stateful partition). The presence of the /root/.dev_mode file enables developer mode and also prevents wiping of the stateful partition when you switch your hardware between developer mode and release mode.


Attribution requirements
When you produce a Chromium OS image, you need to fulfill various attribution requirements of third party licenses. Currently, the images generated by a build don't do this for you automatically. You must modify ~/chromium/src/chrome/browser/resources/about_os_credits.html.

Documentation on this site
You now understand the basics of building, running, modifying, and testing Chromium OS, but you've still got a lot to learn. Here are links to a few other pages on the chromium.org site that you are likely to find helpful (somewhat ordered by relevance):

    The Tips And Tricks for Chromium OS Developers page has a lot of useful information to help you optimize your workflow.
    If you haven't read the page about the devserver already, read it now.
    Learn about the Chromium OS directory structure.
    The Chromium OS developer FAQ might have useful info.  TODO: Double-check that the FAQ is still accurate, and resolve it with this page.
    The Chromium OS portage build FAQ might also have useful info.  TODO: Double-check that the FAQ is still accurate, and resolve it with this page.
     If you have questions about the --noenable_rootfs_verification option, you might find answers on this thread on chromium-os-dev.
    Running Smoke Suite on a VM Image has good information about how to get up and running with autotest tests and VMs.
    Debugging Tips contains information about how to debug the Chromium browser on your Chromium OS device.  TODO: Validate that the instructions are still accurate.
    Working on a Branch has tips for working on branches.
    Git server-side information talks about adding new git repositories.
    The Portage Package Upgrade Process documents how our Portage packages can be upgraded when they fall out of date with respect to upstream.


External documentation
Below are a few links to external sites that you might also find helpful (somewhat ordered by relevance):

    Definitely look at the Chromium OS dev group to see what people are talking about.
    Check out the Chromium OS bug tracker to report bugs, look for known issues, or look for things to fix.
    Get an idea of what's actively happening by looking at the Chromium Code Reviews site. (Note that this is the combined site for both Chromium and Chromium OS.)
    Browse the source code on the Chromium OS gitweb.
    Check the current status of the builds by looking at the Chromium OS build waterfall.
    Check out the #chromium-os channel on freenode.net (this is the IRC channel that Chromium OS developers like to hang out on).
    If you're learning git, check out Git for Computer Scientists, Git Magic, or the Git Manual.
    The Gentoo Development Guide might be useful for (TODO: short description)
    The Gentoo Embedded Handbook might be useful for (TODO: short description)
    The Gentoo Cross Development Guide might be useful for (TODO: short description)
    The Gentoo Wiki on Cross-Compiling might be useful for (TODO: short description)
    The Gentoo Package Manager Specification might be useful for (TODO: short description)
    The repo man page might help you if you're curious about repo. Or you can go straight to the repo source code.
    The repo-discuss group is a good place to talk about repo.

"

