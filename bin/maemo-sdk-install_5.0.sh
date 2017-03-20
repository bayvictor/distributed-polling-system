#!/bin/sh
# Copyright (C) 2006-2009 Nokia Corporation
#
# This is proprietary software owned by Nokia Corporation.
# 
# Contact: Maemo Integration <integration@maemo.org>
# Version: $Revision: 2041 $

# TODO: * document examples of commandline usage, "-d -f -y"
#

__self=`basename $0`

# Release configuration
__version=5.0
__release=fremantle
__repository=explicit
__url=http://repository.maemo.org/stable/5.0/
__maemo_sdk_version=_20.2010.36-2

# Target configurations
__target_toolchain=cs2007q3-glibc2.5
__target_prefix=FREMANTLE
__rootstrap_prefix=maemo-sdk-rootstrap
__rootstrap_suffix=tgz

# Target configuration for armel
__armel_toolchain=${__target_toolchain}-arm7
__armel_target=${__target_prefix}_ARMEL
__armel_devkits=perl:debian-squeeze:qemu:doctools:autotools-legacy:python-legacy:svn:git
__armel_cputransp=qemu-arm-sb

# Target configuration for i386
__i386_toolchain=${__target_toolchain}-i486
__i386_target=${__target_prefix}_X86
__i386_devkits=perl:debian-squeeze:doctools:autotools-legacy:python-legacy:svn:git

# Scratchbox 
__scratchbox_group=sbox
__scratchbox_require=1.0.26
__scratchbox_devkits=`echo "$__armel_devkits $__i386_devkits" | sed 's,:,\n,g' | sort -u`

# SDK module
__installed_module=maemo-sdk-dev

__clear=`which clear`

if [ ! -n "$TERMINFO_DIRS" ]; then
    export TERMINFO_DIRS=/etc/terminfo:/usr/share/terminfo:/lib/terminfo
fi


# Shows usage text
usage () {
	cat <<EOF
Usage: $__self [OPTIONS]

Installer for Maemo $__version $__release release.
Scratchbox installation is a precondition of running this script.

Creates '$__armel_target' and '$__i386_target' scratchbox targets, downloads
and installs the maemo $__version rootstraps and installs system files
to these targets.

If you choose not to accept the license or download the installer (e.g.
using the '-f' option), these components will not be installable and
they are not available anywhere else.

Options:
	-v	Display version and exit.
	-h	Show this usage guide.
	-y	Yes, force remove of existing targets.
	-d	Use defaults. Non-interactive mode.
	-p URI	Specify http_proxy for scratchbox user (default no proxy).
	-s PATH	Specify Scratchbox installation path (default /scratchbox).
	-q NAME	Specify Qemu version (default $__armel_cputransp).
	-a FILE	Specify alternative sources.list file for both targets.
	-A	Advanced mode
	-D	Set the DISPLAY to export (default :2, noop if already set)
	-n	Specify a prefix for the target names.
	-m PKG	Specify the installed module for non-interactive mode.
		(default options: none, maemo-sdk-runtime, maemo-sdk-dev,
		maemo-sdk-debug. Defaults to maemo-sdk-dev.)

EOF
}

# Show the 'open source license'
license () {

more <<EOF
1) IMPORTANT: READ CAREFULLY BEFORE INSTALLING, DOWNLOADING, OR USING THE
SOFTWARE DEVELOPMENT KIT ("SDK" AS DEFINED BELOW) AND/OR SOFTWARE INCLUDED INTO
THE SDK

2) The SDK comprises of a) some software copyrighted by Nokia Corporation or
third parties in binary form (collectively "Licensed Software") and/or b) Open
Source Software in binary and source code form.

3) Licensed Software (including, without limitation, the downloading,
installation and/or the use thereof) is subject to, and licensed to you under,
the Nokia Software Development Kit Agreement, which you have to accept if you
choose to download the Licensed Software. Licensed Software is distributed to
you only in binary form.

4) The SDK is provided to you "AS IS" and Nokia, its affiliates and/or its
licensors do not make any representations or warranties, express or implied,
including, without any limitation, the warranties of merchantability or
fittness for a particular purpose, or that the SDK will not infringe any any
third party patents, copyrights, trademarks or other rights, or that the SDK
will meet your requirements or that the operation of the SDK will be
uninterrupted and/or error-free. By downloading and/or using the SDK you accept
that installation, any use and the results of the installation and/or happens
and is solely at your own risk and that Nokia assumes no liability whatsoever
for any damages that you may incur or suffer in connection with the SDK and/or
the installation or use thereof.

5) The Open Source Software is licensed and distributed under the GNU General
Public License (GPL), the GNU lesser General Public License (LGPL, aka. The GNU
Library General Public License) and/or other copyright licenses, permissions,
notices or disclaimers containing obligation or permission to provide the
source code of such software with the binary / executable form delivery of the
said software. Any source code of such software that is not part of this
delivery is made available to you in accordance with the referred license terms
and conditions on http://www.maemo.org. Alternatively, Nokia offers to provide
any such source code to you on CD-ROM for a charge covering the cost of
performing such distribution, such as the cost of media, shipping and handling,
upon written request to Nokia at:

Source Code Requests
Nokia Corporation
P.O.Box 407
FIN00045 Nokia Group
Finland.

This offer is valid for a period of three (3) years.

The exact license terms of GPL, LGPL and said certain other licenses, as well
as the required copyright and other notices, permissions and acknowledgements
are reproduced in and delivered to you as part of the referred source code.

EOF

echo "Press Enter to accept (Crtl+C to cancel)."
read agree

}

# Show version information
version () {
	echo "Installer for Maemo $__version $__release release."
}


# Fail in case str is empty and print out message
# empty (str,msg)
empty () {
	local str
	local message
	str=$1
	message=$2
	if [ "x$str" = "x" ] ; then
		echo "E: Program error. $message"
		echo "E: If this problem persists please report to <integration@maemo.org>"
		exit 1
	fi
}

# Downloads file in url given with parameter
# download (outdir,url)
#	outdir must be non-empty
#	url must be non-empty
download () {
	local outdir
	local url
	local file
	outdir=$1
	url=$2
	file=`basename $url`
	empty "$outdir" "Download output directory string must be non-empty."
	empty "$url"  "Download URI string must be non-empty."
	# TODO Add timeout to file download
	wget -nd -P $outdir $url
	if [ $? != 0 ] ; then
		echo "E: Couldn't retrieve file '$file'."
		exit 1
	fi
	# TODO Check that downloaded file is readable from path
}

# Run gunzip archive integrity check on file
# test_integrity (file)
#	file must be non-empty
test_integrity () {
	local file
	file=$1
	empty "$file" "File to be checked must be non-empty."
	gunzip -qt $file 2>/dev/null
	return $?
}

# Taken from earlier maemo installer
# This function takes two version number strings as an argument.
# Return value is
#   0, if the version numbers are identical
#   1, if the first version number is greater
#   2, if the second version number is greater
# TODO Check that arguments lhs and rhs are in the form DIGIT.DIGIT.DIGIT
# compare_version_numbers (lhs,rhs)
# FIXME: This function breaks if the version numbers have characters
compare_version_numbers () {
	local lhs
	local rhs
	local c
	lhs=$1
	rhs=$2
	c=1
	if [ -n $__dpkg ] ; then
		$__dpkg --compare-versions lhs eq rhs
		if [ $? -eq 0 ] ; then
			return 0
		fi
		$__dpkg --compare-versions lhs gt rhs
		if [ $? -eq 0 ] ; then
			return 1
		fi
		$__dpkg --compare-versions lhs lt rhs
		if [ $? -eq 0 ] ; then
			return 2
		fi
	else
		while [ 1 ]; do
			V1=`echo $lhs | cut -d . -f $c`
			V2=`echo $rhs | cut -d . -f $c`
			LEN1=`echo $V1 | wc -c`
			LEN2=`echo $V2 | wc -c`

			if [ "$LEN1" -le "1" ] && [ "$LEN2" -le "1" ]; then
				return 0
			fi
			if [ "$LEN2" -le "1" ] || [ "$V1" -gt "$V2" ]; then
				return 1
			fi
			if [ "$LEN1" -le "1" ] || [ "$V1" -lt "$V2" ]; then
				return 2
			fi
			c=`expr $c + 1`
		done
	fi
}

# Scratchbox installation has minimum Qemu version
# TODO Add more cputransp sanity tests
# has_cputransp (scratchbox,cputransp)
# 	cputransp must be non-empty
has_cputransp () {
	local scratchbox
	local cputransp
	scratchbox=$1
	cputransp=$2
	empty "$cputransp" "Scratchbox CPU transparency string must be non-empty."
	if [ -x $scratchbox/devkits/qemu/bin/$cputransp ] ; then
		return 0
	fi
	return 1
}

# Scratchbox installation has toolchain installed
# TODO Add more toolchain sanity tests
# has_toolchain (scratchbox,toolchain)
# 	toolchain must be non-empty
has_toolchain () {
	local scratchbox
	local toolchain
	scratchbox=$1
	toolchain=$2
	empty "$toolchain" "Scratchbox toolchain string must be non-empty."
	if [ -d $scratchbox/compilers/$toolchain ] ; then
		return 0
	fi
	return 1
}

# Scratchbox installation has devkit installed
# TODO Add more devkit sanity tests
# TODO Required devkit minimum version check
# has_devkit (scratchbox,devkit)
# 	devkit must be non-empty
has_devkit () {
	local scratchbox
	local devkit
	scratchbox=$1
	devkit=$2
	empty "$devkit" "Scratchbox devkit string must be non-empty."
	if [ -d $scratchbox/devkits/$devkit ] ; then
		return 0
	fi
	return 1
}

# Scratchbox installation has target installed
# has_target (scratchbox,target)
# 	target must be non-empty
has_target () {
	local scratchbox
	local target
	scratchbox=$1
	target=$2
	empty "$target" "Scratchbox target string must be non-empty."
	if [ -d $scratchbox/users/$USER/targets/$target ] ; then 
		return 0
	fi
	return 1
}


# Scratchbox installation has sessions running 
# has_sessions (scratchbox)
has_sessions () {
	local scratchbox
	scratchbox=$1
	if ! $scratchbox/tools/bin/sb-conf list --targets 2>&1 | \
		grep -q "^sbrsh-conf: No current target$" 1>/dev/null; then
		if [ `$scratchbox/tools/bin/sb-conf list --sessions | grep '^/dev' | wc -l` -gt 1 ] ; then
			return 0
		fi
	fi
	return 1
}

# Download a file from url to dest directory
# get_file (url, dest, cached, description)
get_file () {
	local url
	local dest
	local cached
	local description
	local file
	local destfile
	url=$1
	dest=$2
	cached=$3
	description=$4
	file=`basename $url`
	destfile=$dest/$file

	empty "$dest" "Download output directory string must be non-empty."
	empty "$url"  "Download URI string must be non-empty."
	# Remove files downloaded earlier (default yes)
	if [ "x$cached" != "xyes" ] && [ -r $destfile ] ;  then
		rm -f $destfile
	fi 

	# Check integrity of already downloaded rootstrap if one exists
 	if [ -r  $destfile ] ; then
 		# check existing file for integrity		
 	        if ! test_integrity $destfile ; then
                 	echo "W: Previously downloaded $__arch rootstrap file failed integrity test."
 	                rm $destfile
 	        fi
         fi

	# Download file found from URI if not already found
	if [ ! -r  $destfile ] ; then
		echo "Downloading $description."
		download $dest $url
	else
		echo "Using previously downloaded $description."
	fi
}

# Set up Scratchbox target
# setup_target (scratchbox,target, rootstrap, toolchain, devkits, cputransp)
setup_target () {
	local scratchbox
	local target
	local rootstrap
	local toolchain
	local devkits
	local cputransp
	scratchbox=$1
	target=$2
	rootstrap=$3
	toolchain=$4
	devkits=$5
	cputransp=$6
	empty "$target" "Scratchbox target name must be non-empty."
	empty "$rootstrap" "Scratchbox target rootstrap filename must be non-empty."
	empty "$toolchain" "Scratchbox target toolchain must be non-empty."
	echo "Setting up '$target' target."
	# Settings string
	local setup_string
	setup_string="--compiler=$toolchain"
	if [ "x$devkits" != "x" ] ; then
		setup_string="$setup_string --devkits=$devkits"
	fi
	if [ "x$cputransp" != "x" ] ; then
		setup_string="$setup_string --cputransp=$cputransp"
	fi
	# Setup
	$scratchbox/tools/bin/sb-conf setup $target --force $setup_string
	if [ $? != 0 ] ; then 
		echo "E: Scratchbox command 'sb-conf setup' returned error $?."
		exit 1
	fi
	# Reset
	$scratchbox/tools/bin/sb-conf reset -f $target
	if [ $? != 0 ] ; then
		echo "E: Scratchbox command 'sb-conf reset' returned error $?."
		exit 1
	fi
	# Select
	$scratchbox/tools/bin/sb-conf select $target
	if [ $? != 0 ] ; then 
		echo "E: Scratchbox command 'sb-conf select' returned error $?."
		exit 1
	fi
	# Rootstrap
	$scratchbox/tools/bin/sb-conf rootstrap $target $rootstrap
	if [ $? != 0 ] ; then 
		echo "E: Scratchbox command 'sb-conf rootstrap' returned error $?."
		exit 1
	fi
	# Install
	$scratchbox/tools/bin/sb-conf install $target -L --etc --devkits --fakeroot
	if [ $? != 0 ] ; then 
		echo "E: Scratchbox command 'sb-conf install' returned error $?."
		exit 1
	fi

	cp $scratchbox/etc/resolv.conf $scratchbox/users/$USER/targets/$target/etc/

	if [ -h "$scratchbox/users/$USER/targets/$target/opt" ] ; then
		rm $scratchbox/users/$USER/targets/$target/opt
		mkdir $scratchbox/users/$USER/targets/$target/opt
	fi

	echo "Target '$target' has been created."
	echo
}

# Prints out an underlined text banner
# phase (text)
phase () {
	local text
	local underline
	text=$1
	underline=`echo $text | sed 's,.,-,g'`
	echo
	echo "$text"
	echo "$underline"
	echo
}

run_dialog () {
	exec 3>&1
	__answer=$($__dialog "$@" 2>&1 1>&3)
	__retval=$?
	exec 3>&-
}

# Print Canceling notification
cancel_installation () {
	if [ $# != 0 ] ; then 
		$__dialog --msgbox "Installation Canceled\n$*" 6 40
	else
		$__dialog --msgbox "Installation Canceled" 5 30
	fi

	exit 0
}

# Main
# TODO Add long command line options
while getopts "Aa:cD:dhm:n:p:q:s:vy" opt ; do
	case "$opt" in
		h)
			usage
			exit 0
			;;
		v)
			version 
			exit 0
			;;
		m)
			if [ "$OPTARG" = "none" ] ; then
				__installed_module=
			else
				__installed_module=$OPTARG
			fi
			;;
		n)
			__target_prefix=$OPTARG
			__armel_target=${__target_prefix}_ARMEL
			__i386_target=${__target_prefix}_X86
			;;
		y)
			__force=yes 
			;;
		d)
			__defaults=yes
			;;
		p)
			__proxy=$OPTARG 
			;;
		s)
			__scratchbox=$OPTARG 
			;;
		q)
			__armel_cputransp=$OPTARG 
			;;
		a)
			__sources_list=$OPTARG 
			if [ "x$__sources_list" != "x" ] && [ ! -r $__sources_list ] ; then
				echo "E: Alternative sources.list '$__sources_list' file not found."
				echo "E: Please check that '-a FILE' option arg file exists."
				exit 1
			fi
			;;
		A)
			__advanced_mode=yes
			;;
		D)
			__display=$OPTARG
			;;
		*)
			echo "W: Unknown option '$opt'"
			;;
	esac
done

# Runtime options
if [ -z $__scratchbox ] ; then
	__scratchbox=/scratchbox
fi
__sbhome=$__scratchbox/users/$USER/home/$USER 

# Set defaults
if [ -z $__defaults ] ; then
	__defaults=no
else
	__cached=yes
fi

if [ -z $__force ] ; then
	__force=no
fi

if [ -z $__cached ] ; then
	__cached=yes
fi

if [ -z $__display ] ; then
	__display=":2"
fi

# If no proxy is given use the same as the host environment
if [ -z $__proxy ] ; then
	__proxy=$http_proxy
fi

if [ -z $__advanced_mode ] ; then
	__advanced_mode=no
fi

cat <<END
This script will install maemo SDK $__version $__release release to your computer.

Install options
Force remove of existing targets ($__force)
Alternative sources.list ('$__sources_list')

Target configuration for armel ($__armel_target)
compiler=$__armel_toolchain
devkits=$__armel_devkits
cputransp=$__armel_cputransp

Target configuration for i386 ($__i386_target)
compiler=$__i386_toolchain
devkits=$__i386_devkits
END

phase "Checking for prerequisites"

# TODO Check that all parameters are non-empty

# Check for wget
__wget=`which wget`
echo -n "wget tool in path... "
if [ -z $__wget ] || [ ! -x $__wget ] ; then
	echo "not found"
	echo "E: This script requires wget to download rootstraps and installer files."
	echo "E: On most Linux distributions this is provided by the 'wget' package."
	exit 1
else
	echo "$__wget"
fi

# Check for dpkg, optional, only used for comparing version numbers
echo -n "Checking for dpkg tool in path... "
__dpkg=`which dpkg`
if [ -z $__dpkg ] || [ ! -x $__dpkg ] ; then
	echo "not found."
else
	echo $__dpkg
fi

# Check for running inside scratchbox
echo -n "Running outside of scratchbox... "
if [ -r /targets/links/scratchbox.config ] ; then
	echo "no"
	echo "E: This script needs to be run outside of scratchbox."
	exit 1
else
	echo "yes"
fi

# Check not run as user root
echo -n "Script not run as user root... "
__user=`whoami`
if [ x$__user = "xroot" ] ; then
	echo "no"
	echo "E: This script should NOT be run as user root."
	exit 1
else
	echo "yes"
fi


# Check for scratchbox installation
echo -n "Scratchbox installation found... "
if [ ! -d $__scratchbox	 ] ; then
	echo "no"
	echo "E: Scratchbox not found in installation path '$__scratchbox'."
	echo "E: Please complete scratchbox installation first."
	echo "E: Specify an alternative installation path using '-s PATH' option."
	exit 1
else
	echo "yes"
fi

# Check for scratchbox user
echo -n "Scratchbox home directory... "
if [ ! -d $__scratchbox/users/$USER ] ; then
	echo "no"
	echo "E: Scratchbox directory for user not present."
	echo "E: Add user with '$__scratchbox/sbin/sbox_adduser $USER'."
	echo "E: Specify an alternative installation path using '-s PATH' option."
	exit 1
else
	echo "yes"
fi

# Check for dialog tool
# set __dialog only if using interactive setup
if [ "$__defaults" = "no" ] ; then
	# sb dialog won't work outside sb if sb is not installed in default path
	if [ "$__scratchbox" = "/scratchbox" ] ||
	   [ "$__scratchbox" = "/scratchbox/" ]; then
		__dialog=$__scratchbox/tools/bin/dialog
	else
		__dialog=`which dialog`
		if [ -z "$__dialog" ] ; then
			echo "E: Dialog not found in default path."
			echo "E: For interactive installation please install dialog."
			echo "E: Or use the non-interactive mode using -d option."
			exit 1
		fi
	fi
fi

# Check for sb-conf tool
echo -n "Scratchbox sb-conf tool... "
if [ ! -x $__scratchbox/tools/bin/sb-conf ] ; then
	echo "no"
	echo "E: Scratchbox sb-conf tool not found in '$__scratchbox'."
	echo "E: This is most likely due to old version of scratchbox."
	echo "E: Please complete scratchbox installation first."
	echo "E: Specify an alternative installation path using '-s PATH' option."
	exit 1
else
	echo "yes"
fi

# Check for scratchbox bind mount
echo -n "Scratchbox user's bind mount... "
if [ ! -d $__scratchbox/users/$USER/scratchbox ] ; then
	echo "no"
	echo "E: Scratchbox bind mount for user not present."
	echo "E: Start scratchbox service with 'sudo $__scratchbox/sbin/sbox_ctl start'."
	echo "E: Specify an alternative installation path using '-s PATH' option."
	exit 1
else
	echo "yes"
fi

# Check for scratchbox properly set up
echo -n "Scratchbox user's /dev set up... "
if [ ! -r $__scratchbox/users/$USER/dev/null ]; then
	echo "no"
	echo "E: Scratchbox user's /dev is not properly set up. Couldn't read /dev/null."
	echo "E: Start scratchbox service with 'sudo $__scratchbox/sbin/sbox_ctl start'."
	echo "E: Specify an alternative installation path using '-s PATH' option."
	exit 1
else
	echo "yes"
fi

# Check for home directory inside scratchbox
echo -n "Scratchbox home directory... "
if [ ! -d $__sbhome ] ; then
	echo "no"
	echo "E: Scratchbox home directory '$__sbhome' not found."
	echo "E: Add user with '$__scratchbox/sbin/sbox_adduser $USER'."
	echo "E: Specify an alternative installation path using '-s PATH' option."
	exit 1
else
	echo "yes"
fi

# Check for scratchbox login
echo -n "Scratchbox login... "
if [ ! -r $__scratchbox/login ] ; then
	echo "no"
	echo "E: Scratchbox login not found in '$__scratchbox'."
	echo "E: Please complete scratchbox installation first."
	echo "E: Specify an alternative installation path using '-s PATH' option."
	exit 1
else
	echo "yes"
fi

# Check for scratchbox login
# User in sbox group
echo -n "Scratchbox login executable... "
if [ ! -x $__scratchbox/login ] ; then
	echo "no"
	echo "E: Scratchbox login found but not executable by user."
	echo "E: Please check that user is member of the group specified in scratchbox"
	echo "E: installation (default '$__scratchbox_group')."
	echo "E: Also start a new login terminal after adding group membership."
	exit 1
else
	echo "yes"
fi

# Execute sb-conf tool
# TODO Check that version string is in the form DIGIT.DIGIT.DIGIT
echo -n "Scratchbox sb-conf tool works... "
__scratchbox_version=`$__scratchbox/tools/bin/sb-conf version 2>/dev/null | tail -1`
if [ $? != 0 ]	; then
	echo "no"
	echo "E: Couldn't execute scratchbox utility sb-conf."
	echo "E: Please complete scratchbox installation first."
	echo "E: Specify an alternative installation path using '-s PATH' option."
	exit 1
else
	echo "yes"
fi

# Check for scratchbox version
echo -n "Scratchbox version requirement met... "
compare_version_numbers $__scratchbox_require $__scratchbox_version 
if [ $? = 1 ] ; then
	echo "no"
	echo "E: Scratchbox version is too old (scratchbox-core $__scratchbox_version)."
	echo "E: The minimum required scratchbox-core version is $__scratchbox_require."
	echo "E: Please refer to http://scratchbox.org/"
	echo "E: Specify an alternative installation path using '-s PATH' option."
	exit 1
else
	echo "yes"
fi

# Check for CPU transparency method
echo -n "Scratchbox CPU transparency method for ARMEL is present... "
if ! has_cputransp $__scratchbox $__armel_cputransp ; then
	echo "no"
	echo "E: CPU transparency method '$__armel_cputransp' not found."
	echo "E: Please complete scratchbox installation first."
	echo "E: Specify an alternative CPU transparency method using '-q NAME' option."
	exit 1
else
	echo "yes"
fi

# Check that toolchains are found
echo -n "Scratchbox toolchains... "
if ! has_toolchain $__scratchbox $__armel_toolchain || ! has_toolchain $__scratchbox $__i386_toolchain ; then
	echo "no"
	echo "E: Toolchain $__armel_toolchain required for '$__armel_target' target."
	echo "E: Toolchain $__i386_toolchain required for '$__i386_target' target."
	echo "E: Please complete scratchbox installation first."
	echo "E: Specify an alternative installation path using '-s PATH' option."
	exit 1
else
	echo "yes"
fi

# Check that devkits are found
# TODO: This detects only the first missing devkit, should check all
#       missing devkits
echo -n "Scratchbox required devkits... "
for __devkit in $__scratchbox_devkits ; do 
	if ! has_devkit $__scratchbox $__devkit ; then
		echo "no"
		echo "E: Scratchbox devkit $__devkit not found."
		echo "E: Please complete scratchbox installation first."
		echo "E: Specify an alternative installation path using '-s PATH' option."
		exit 1
	fi
done
echo "yes"

# Check for scratchbox sessions running
echo "Check for scratchbox sessions running..."
if has_sessions $__scratchbox ; then
	echo "E: You must close your other scratchbox sessions first"
	echo "E: Specify an alternative installation path using '-s PATH' option."
	exit 1
fi

# Show the license before modifications
license

# Set the display
if [ -r $__sbhome/.bashrc ] && grep -q "DISPLAY"  $__sbhome/.bashrc ; then
	echo "DISPLAY already set."
else
	echo "Setting DISPLAY..."
	echo "export DISPLAY=$__display" >> $__sbhome/.bashrc
fi

# Set installation environment
if [ -r $__sbhome/.bashrc ] && grep -q ".installation_environment"  $__sbhome/.bashrc ; then
	echo "Installation environment already set."
else
	echo "Setting installation environment..."
	echo "if [ -f ~/.installation_environment ]; then" >> $__sbhome/.bashrc
	echo "    . ~/.installation_environment" >> $__sbhome/.bashrc
	echo "fi" >> $__sbhome/.bashrc
fi

# Debian frontend to noninteractive
echo "export DEBIAN_FRONTEND=noninteractive" > $__sbhome/.installation_environment 
echo "export DEBIAN_PRIORITY=critical" >> $__sbhome/.installation_environment
echo "Added debconf frontend setting in scratchbox."
echo >> $__sbhome/.installation_environment
# Don't start stuff 
echo "# fake start-stop-daemon" >> $__sbhome/.installation_environment
echo "SBOX_REDIRECT_BINARIES=\$SBOX_REDIRECT_BINARIES,/sbin/start-stop-daemon:$__scratchbox/tools/bin/true" >> $__sbhome/.installation_environment
echo "SBOX_REDIRECT_BINARIES=\$SBOX_REDIRECT_BINARIES,$__scratchbox/devkits/debian/bin/start-stop-daemon:$__scratchbox/tools/bin/true" >> $__sbhome/.installation_environment
echo >> $__sbhome/.installation_environment
echo "# fake invoke-rc.d " >> $__sbhome/.installation_environment
echo "SBOX_REDIRECT_BINARIES=\$SBOX_REDIRECT_BINARIES,/usr/sbin/invoke-rc.d:$__scratchbox/tools/bin/true " >> $__sbhome/.installation_environment
echo "SBOX_REDIRECT_BINARIES=\$SBOX_REDIRECT_BINARIES,$__scratchbox/devkits/debian/bin/invoke-rc.d:$__scratchbox/tools/bin/true" >> $__sbhome/.installation_environment
echo >> $__sbhome/.installation_environment
echo "# fake install-info " >> $__sbhome/.installation_environment
echo "SBOX_REDIRECT_BINARIES=\$SBOX_REDIRECT_BINARIES,/usr/sbin/install-info:$__scratchbox/tools/bin/true " >> $__sbhome/.installation_environment
echo "SBOX_REDIRECT_BINARIES=\$SBOX_REDIRECT_BINARIES,$__scratchbox/devkits/debian/bin/install-info:$__scratchbox/tools/bin/true" >> $__sbhome/.installation_environment
echo >> $__sbhome/.installation_environment
echo "# fake dpkg-divert " >> $__sbhome/.installation_environment
echo "SBOX_REDIRECT_BINARIES=\$SBOX_REDIRECT_BINARIES,/usr/sbin/dpkg-divert:$__scratchbox/tools/bin/true " >> $__sbhome/.installation_environment
echo "SBOX_REDIRECT_BINARIES=\$SBOX_REDIRECT_BINARIES,$__scratchbox/devkits/debian/bin/dpkg-divert:$__scratchbox/tools/bin/true" >> $__sbhome/.installation_environment
echo >> $__sbhome/.installation_environment
echo "# fake update-alternatives " >> $__sbhome/.installation_environment
echo "SBOX_REDIRECT_BINARIES=\$SBOX_REDIRECT_BINARIES,/usr/sbin/update-alternatives:$__scratchbox/tools/bin/true " >> $__sbhome/.installation_environment
echo "SBOX_REDIRECT_BINARIES=\$SBOX_REDIRECT_BINARIES,$__scratchbox/devkits/debian/bin/update-alternatives:$__scratchbox/tools/bin/true" >> $__sbhome/.installation_environment
#echo "export SBOX_REDIRECT_TO_DIRS=\`echo -n \"\$SBOX_REDIRECT_TO_DIRS\" | tr -s :\`" >> $__sbhome/.installation_environment

__log_file=maemo-sdk-install.log

## If dialog is found and defaults are not used, start the interactive setup
if [ $__dialog ] ; then

	# Select the desired module
	run_dialog --title "Package Selection" \
		--radiolist "Select Installed Packages:" 10 60 5 \
		1 "Minimal Rootstrap only" off \
		2 "Runtime Environment" off \
		3 "Runtime Environment + All Dev Packages" on \
		4 "Runtime Environment + All Dev and Dbg Packages" off 

	if [ $__retval -eq 0 ] ; then
		case $__answer in
			1)
				__installed_module=
				;;
			2)
				__installed_module=maemo-sdk-runtime
				;;
			3)
				__installed_module=maemo-sdk-dev
				;;
			4)
				__installed_module=maemo-sdk-debug
				;;
		esac
	else
		cancel_installation
	fi

	# Advanced questions for those who want them
	if [ $__advanced_mode = "yes" ] ; then

		# Target names
		__loop=yes
		until [ $__loop = "no" ]
		do
			# X86 target
			run_dialog --inputbox "Enter name for X86 target:" 8 40 $__i386_target

			if [ $__retval -eq 0 ] ; then
				if [ $__answer ] ; then
					__i386_target=$__answer
					__loop=no
				fi
			else
				cancel_installation 
			fi

		done

		__loop=yes
		until [ $__loop = "no" ]
		do
			# ARMEL target
			run_dialog --inputbox "Enter name for ARMEL target:" 8 40 $__armel_target

			if [ $__retval -eq 0 ] ; then
				if [ $__answer ] ; then
					__armel_target=$__answer
					__loop=no
				fi
			else
				cancel_installation
			fi

		done
	fi

	# Check existing targets
	if [ "x$__force" != "xyes" ] && ( has_target $__scratchbox $__i386_target || has_target $__scratchbox $__armel_target ) ; then

		__targets=""

		if ( has_target $__scratchbox $__i386_target ) &&
		   ( has_target $__scratchbox $__armel_target ) ; then
			__targets="s $__i386_target and $__armel_target"
		elif ( has_target $__scratchbox $__i386_target ) ; then 
			__targets=" $__i386_target"
		else
			__targets=" $__armel_target"
		fi

		run_dialog --title "Targets with the same name found" --defaultno --yesno "Do you wish to remove the existing target$__targets?" 7 48

		if [ $__retval -eq 0 ] ; then
			__force=yes
		else
			cancel_installation 'Conflicting target names found.'
		fi
	fi

	# Advanced questions for those who want them
	if [ $__advanced_mode = "yes" ] ; then


		# Proxy settings
		__loop=yes
		until [ $__loop = "no" ]
		do
			run_dialog --inputbox "Enter proxy server:" 8 40 $__proxy

			if [ $__retval -eq 0 ] ; then
				if [ "x$__answer" != "x" ] && [ `expr match "$__answer" \
					'http://'` -ne 7 ] ; then
					run_dialog --title 'Malformed Proxy URI' \
						--msgbox 'Proxy has to start with http://' 5 38
				else
					__proxy=$__answer
					__loop=no
				fi
			else
				cancel_installation
			fi
		done		

		# Alternative sources.list
		__loop=yes
		until [ $__loop = "no" ]
		do
			run_dialog --inputbox "Enter alternative sources.list:" 8 40 $__sources_list

			if [ $__retval -eq 0 ] ; then
				if [ ! -r $__answer ] ; then
					run_dialog --title 'Alternative sources.list not found' \
						--msgbox "File: $__answer not found" 6 50
				else
					__sources_list=$__answer
					__loop=no
				fi
			else
				cancel_installation
			fi
		done		
	# End advanced
	fi

	run_dialog --title "Selection summary" --yes-label Continue \
		--no-label Cancel --yesno "Installation about to begin with following settings:\n\nInstalled component: $__installed_module\nX86 target name: $__i386_target\nArmel target name: $__armel_target\nOverwrite existing targets: $__force\nProxy server: $__proxy\nAlternative sources.list: $__sources_list" 15 60

	if [ $__retval -ne 0 ] ; then
		cancel_installation
	fi

	$__clear
# End interactive
else

	# Acceptance
	echo -n "Acceptance to reset existing targets... "
	if [ "x$__force" != "xyes" ] && \
		( has_target $__scratchbox $__i386_target || \
		has_target $__scratchbox $__armel_target ) ; then
		echo "no"
		echo "E: Targets already exist ($__i386_target and $__armel_target)"
		echo "E: You need to force overwriting existing targets with '-y'."
		exit 1
	else
		echo "not needed"
	fi

	# Alternative sources.list
	echo -n "Alternative sources.list file exists... "
	if [ "x$__sources_list" != "x" ] && [ ! -r $__sources_list ] ; then
		echo "no"
		echo "E: Alternative sources.list '$__sources_list' file not found."
		echo "E: Please check that '-a FILE' option arg file exists."
		exit 1
	else
		echo "yes"
	fi

	# Check that http_proxy URI is formed correctly
	echo -n "Checking http_proxy URI format... "
	if [ "x$__proxy" != "x" ] && \
		[ `expr match "$__proxy" 'http://'` -ne 7 ] ; then
		echo "wrong"
		echo "E: Proxy URI is malformed. Must start with 'http://'."
		echo "E: Specify an alternative http proxy URI using '-p URI' option."
		exit 1
	else
		echo "ok"
	fi

fi

# Set http_proxy URI in .bashrc
if [ "x$__proxy" != "x"  ]  ; then
	if [ -r $__sbhome/.bashrc ] && grep -q "^export http_proxy=" $__sbhome/.bashrc ; then
		echo "Found http_proxy setting in scratchbox user's .bashrc , not set."
	else
		echo "export http_proxy=$__proxy" >>  $__sbhome/.bashrc
		echo "Added http_proxy setting to scratchbox user's .bashrc ."
	fi
fi

echo
echo "Everything seems to be ok."

phase "Downloading rootstraps and installer files"

# Download i386 and armel rootstraps, check for archive integrity
for __arch in armel i386 ; do
	get_file ${__url}/${__arch}/${__rootstrap_prefix}_${__version}${__maemo_sdk_version}_${__arch}.${__rootstrap_suffix} $__sbhome $__cached "$__arch rootstrap"
	echo "Testing downloaded $__arch rootstrap integrity."
	if ! test_integrity ${__sbhome}/${__rootstrap_prefix}_${__version}${__maemo_sdk_version}_${__arch}.${__rootstrap_suffix} ; then
		echo "E: Downloaded $__arch rootstrap file failed integrity test."
		exit 1
	fi
done

phase "Setting up scratchbox targets"

# Setup and create SDK_ARMEL targets
setup_target $__scratchbox \
	$__armel_target \
	${__rootstrap_prefix}_${__version}${__maemo_sdk_version}_armel.${__rootstrap_suffix} \
	$__armel_toolchain \
	$__armel_devkits \
	$__armel_cputransp

# Setup and create SDK_X86 target
setup_target $__scratchbox \
	$__i386_target \
	${__rootstrap_prefix}_${__version}${__maemo_sdk_version}_i386.${__rootstrap_suffix} \
	$__i386_toolchain \
	$__i386_devkits

# TODO Setup and create SDK_KERNEL target

# Set build flags for ARMEL target
echo "export DEB_BUILD_OPTIONS=maemo-launcher,thumb,vfp" > $__scratchbox/users/$USER/targets/$__armel_target.environment

# Replace sources.list on both targets
if [ "x$__sources_list" != "x" ] ; then
	for __update_target in $__armel_target $__i386_target ; do 
		echo "Replacing sources.list on '$__update_target' target."
		cp $__sources_list $__scratchbox/users/$USER/targets/$__update_target/etc/apt/sources.list
	done
fi


# Add proxy configuration to apt on both targets
if [ "x$__proxy" != "x"  ]  ; then
	for __update_target in $__armel_target $__i386_target ; do
		echo "Adding proxy configuration for apt in $__update_target..."
		echo "Acquire::http::Proxy \"$__proxy\";" >  $__scratchbox/users/$USER/targets/$__update_target/etc/apt/apt.conf.d/99proxy
	done
fi

phase "Update list of available packages"

# Run apt-get update on both targets
for __update_target in $__armel_target $__i386_target ; do 
	echo "Running apt-get update on '$__update_target'."
	$__scratchbox/tools/bin/sb-conf select $__update_target
	$__scratchbox/login apt-get -o Acquire::http::TimeOut=15 -o Acquire::http::Retries=2 update
	__sb_return=$?
	if [ $__sb_return != 0 ] ; then 
		echo "E: Unable to run 'apt-get update' on the target."
		echo "E: Please correct any network problems."
		echo "E: Scratchbox login returned error $__sb_return."

		echo 
		echo "The installation process was unable to run 'apt-get update' inside"
		echo "the installed targets in order to update the local package database."
		echo "This could be due to an error in network configuration inside scratchbox."
		echo "Common causes are incorrect proxy	settings and the 'hosts' line in"
		echo "$__scratchbox/etc/nsswitch.conf."
		echo "For the 'hosts' line in /scratchbox/etc/nsswitch.conf the following"
		echo "should usually be enough:"
		echo "hosts:          files dns"
		echo

		echo "Once network issues have been resolved, you should run the installer again."
		exit 1
	fi
	echo
done

# Install the requested metapackage
if [ x$__installed_module != "x" ] ; then
	for __update_target in $__armel_target $__i386_target ; do 
		echo "Installing packages on '$__update_target'."
		$__scratchbox/tools/bin/sb-conf select $__update_target
		$__scratchbox/login fakeroot apt-get install -y --force-yes -o Acquire::http::Pipeline-Depth=0 -o Acquire::http::Retries=10 $__installed_module 2>&1
		__sb_return=$?
		if [ $__sb_return != 0 ] ; then
			echo "E: Unable to install $__installed_module on $__update_target target."
			echo "E: Please check the sources.list for errors."
			echo "E: Scratchbox login returned error $__sb_return."
			exit 1
		fi
	done
fi

phase "Installation was successful!"

# Remove the installation time environment
rm $__sbhome/.installation_environment

cat <<END
IMPORTANT! Please read this. 

You now have the maemo $__version $__release installed on your computer.
You can now start your maemo SDK session with $__scratchbox/login and
then select your target with 'sb-conf select $__armel_target' for the
armel target or 'sb-conf select $__i386_target' for the i386 target.

If you have any problems with targets' package databases, you can try
running 'fakeroot apt-get -f install' on your scratchbox target.
This command will try to fix any problems with the package database.

***NOKIA BINARIES***
In order to obtain Nokia-closed binaries, visit
http://tablets-dev.nokia.com/eula/index.php to accept the End User
License Agreement. You will be given a token to access the Nokia
binaries repository with further instructions.

END

echo "Happy hacking!"
echo


