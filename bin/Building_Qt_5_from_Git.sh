echo "
Building Qt 5 from Git
Introduction

This article will try to give some hints for checking out the modularized Qt5 from git and getting it built. Please feel free to update this article as things change during development. Raise issues related to the article on http://developer.qt.nokia.com/forums/viewthread/7018 .
System Requirements

You need obviously git (>= 1.6.x) to get the packages. To properly configure and build Qt 5 from source you also need Perl and Python, as well as a working compiler.
Linux/X11
Build essentials on Ubuntu/Debian:
"
    sudo apt-get install -y build-essential perl python git

echo "
Libxcb [xcb.freedesktop.org] is now the default window-system backend for platforms based on X11/Xorg, and you should therefore install libxcb and its accompanying packages. Qt5 should build with whatever libxcb version is available in your distro’s packages (but you may optionally wish to use v1.8 or higher to have threaded rendering support). src/plugins/platforms/xcb/README [qt.gitorious.org] lists the required packages.

Libxcb and friends on Ubuntu/Debian:
"
    sudo apt-get install -y "^libxcb.*" libx11-xcb-dev libglu1-mesa-dev libxrender-dev

echo "When you want to compile webkit, more dependencies need to be satisfied:
Webkit dependencies on Ubuntu/Debian:
"
    sudo apt-get install -y flex bison gperf libicu-dev libxslt-dev
   sudo apt-get install -y libxcomposite-dev libwayland-dev
echo "
QtWayland dependencies

To build the QtWayland module, the Wayland [wayland.freedesktop.org] development libraries should be installed ( libxcomposite-dev and libwayland-dev ) .
Mac OS X

XCode and git should be enough.
Windows
Windows Graphics Drivers

For QML2 to work, you need an OpenGL driver (NVidia,etc) that provides OpenGL 2.1 or higher for your graphics card. The Windows default driver provides only OpenGL 1.1, which is not sufficient.

Alternatively, the ANGLE-library [code.google.com] , which provides Open GL ES 2.0 by translating Open GL calls into Direct X, can be used. In order to build it, you need to

    Install the Direct X SDK [msdn.microsoft.com]
    Checkout and build ANGLE (SVN repository) as explained here [code.google.com]
    Note: When building for 64bit, de-activate the WarnAsError option in every project file (as otherwise integer conversion warnings will break the build).
    When configuring Qt, pass the command line options -opengl es2 -angle <path>

Supported Compilers on Windows

    Windows SDK 7.1 with Visual Studio 2010 (recommended). As of 16.3.2012, installing the SDK requires installing the following packages in this order (see readme.html provided with the service pack):

    Install Visual Studio 2010
    Install Windows SDK 7.1
    Install Visual Studio 2010 SP1
    Install Visual C++ 2010 SP1 Compiler Update for the Windows SDK 7.1

    Windows SDK 7 with Visual Studio 2008
    MinGW [mingw.org] or TDM MinGW [tdm-gcc.tdragon.net] with g++ version 4.6 or higher (not supported for all modules)

Windows Build environment

We recommend creating a command prompt that provides the build environment (see the Qt Creator README [qt.gitorious.org] ). In this environment, Python (e.g. Active Python 2.7 later) and Perl (e.g. Active State Perl 5.12 or later) should be in the PATH.

Multicore building: When using nmake, the environment variable CL (specifying Visual Studio compiler options) can be set to set CL=/MP, instructing the compiler to use all cores. Alternatively, the tool jom [qt-project.org] can be used. Note however, that it has issues with module interdependencies, which can cause builds to fail.

Hint: Make sure that Perl is added to the path in front of git since that ships an outdated version (Perl 5.8), which will cause the scripts to fail.
ICU on Windows

Qt 5 can make use of the ICU [site.icu-project.org] library for UNICODE and Globalization support. This is required for building QtWebKit.

At compile time, the include and lib folders of the ICU installation must be appended to INCLUDE and LIB environment variables after calling the setup script of the Windows SDK.

At run-time, the ICU DLLs need to be found. This can be achieved by copying the DLLs to the application folder or adding the bin folder of the ICU installation to the PATH environment variable.
Getting the source code

First clone the top-level Qt 5 git repository:
"
mkdir ~/src/qt5
cd ~/src/qt5
    git clone git://gitorious.org/qt/qt5.git qt5

echo "or (if you’re behind a firewall and want to use the https protocol):

    git clone https://git.gitorious.org/qt/qt5.git qt5

Following the README [qt.gitorious.org] – file we initialize the repository using the script init-repository which clones the various sub-modules of Qt5. Relevant options:

    —no-webkit : Consider skipping qtwebkit by passing this option. This module is quite big, takes a long time to compile and if often a source of compile errors, so it is recommend to only download it if you intend to use it. You can always re-run init-repository later on to add it.
    —http : Pass this option if you’re behind a firewall.
"

    cd qt5
    perl init-repository

echo "If you plan to contribute to Qt, you should specify your codereview username so that the git remotes are properly set up:
    perl init-repository --codereview-username <Jira/Gerrit username>
"
read readline
    perl init-repository --codereview-username <Jira/Gerrit username>

echo "Configuring and building

Setup your path so that we pick up the Qt5 tools rather than any old Qt4 ones that may be present on your system:

For Linux/Mac OS X:
"
    unset QTDIR
    export PATH="$PWD/qtbase/bin:$PWD/qtrepotools/bin:$PATH"

echo "For Windows:

    set QTDIR=
    set PATH=%CD%\qtbase\bin;%CD%\qtrepotools\bin;%PATH%

Now configure the build (from top level dir). Disabling tests and examples will greatly speed up compilation:

For Linux/Mac OS X:
"
    ./configure -developer-build -opensource -nomake examples -nomake tests

echo "For Windows:

    configure -developer-build -opensource -nomake examples -nomake tests

The -developer-build options export more symbols than in a traditional Qt build in order to allow more classes and functions to be unit tested. It also defaults to a ‘debug’ build, and installs the binaries in the current directory, avoiding the need for ‘make install’. ‘-opensource’ sets the license to be LGPL 2.1. The -nomake examples and -nomake tests parameters make sure examples and tests aren’t compiled by default. You can always decide to compile them later by hand.

    Hint1: On Linux you should also pass -no-gtkstyle. This is because on a number of systems (at least SUSE and Gentoo) pkg-config —cflags gtk+-2.0 actually returns paths that include the system Qt4.x include directories.

    Hint2: You can add -confirm-license to get rid of the question whether you agree to the license.

    Hint3: On Windows, you might not be able to build if sh.exe is in your PATH (for example due to a git or msys installation). Such an error is indicated by qt5-srcqtbasebinqmake.exe: command not found and alike. In this case, make sure that sh.exe is not in your path. You will have to re-configure if your installation is already configured.

Building happens by invoking the build perl script:

For Linux:
"
read readline

    ./build -j 3

echo "For Windows (MSVC):

    perl build

Or just make a specific module, e.g. declarative, and modules it depends on:
"
    make module-qtdeclarative

echo "*Hint 1: The build script should be used for all configuration. For in-source developer builds, executing the platform’s make command also works.
*Hint 2: jom, the drop-in replacement of nmake on Windows, doesn’t work right now for top-level builds. You can, however, use it to (re-)build individual submodules.
Building QtWebKit
Linux, Mac

The tools bison, flex and gperf which are required for building.
"

    cd qtwebkit
    export WEBKITOUTPUTDIR="$PWD/WebKitBuild"
    perl Tools/Scripts/build-webkit --qt --qmake="$PWD/../qtbase/bin/qmake" --install-libs=<install dir> --debug --makeargs="$MAKEFLAGS"

echo "Windows

WebKit.org [trac.webkit.org] has instructions for building WebKit on Windows. Besides ICU [site.icu-project.org] library , phtreads-win32 [sourceware.org] is required. After unzipping a release package (say to c:\phtreads) , you need to:

    Add c:\phtreads\pthreads.2 to the INCLUDE environment variable
    Add c:\phtreads\Pre-built.2\lib\x64 or c:\phtreads\Pre-built.2\lib\x86 to the LIB environment variable
    Add c:\phtreads\Pre-built.2\dll\x64 or c:\phtreads\Pre-built.2\dllx86 to the PATH environment variable

The tools bison, flex and gperf which are required for building are provided for convenience in the folder gnuwin32\bin.

    set PATH=%PATH%;%CD%\gnuwin32\bin
    cd qtwebkit
    set WEBKITOUTPUTDIR=%CD%\WebKitBuild
#    perl Tools\Scripts\build-webkit --qt --qmake="%CD%\\..\\qtbase\\bin\\qmake.exe" --install-libs=<install dir> --release --makeargs="%MAKEFLAGS%"

Installing (Linux / Mac OS X)

    Note: Installation is only needed if you haven’t used the configure options -developer-build or -prefix “PWD/qtbase”. Otherwise you can just use Qt from the build directory.

To install, run
"

    make install

echo "But if you’re installing into a non-standard path for testing qt5, you’ll need to set your path to include the installation directory’s bin directory. You should either make sure you don’t have QTDIR set in your environment, or set QTDIR to the installation path before running make install. For example, if installing into /opt/qt5 (this assumes you are using bash; for csh-derived shells you’ll need to run setenv equivalents first):
"
    PATH=/opt/qt5:$PATH QTDIR=/opt/qt5 make install

echo "Cleaning

To really get a clean tree use:

    git submodule foreach --recursive 'git clean -dfx'

since make confclean no longer works from the top-level of the repo.
Getting updates

To update both the qt5.git repo as well as the submodules to the list of revisions that are known to work, run

    git pull
    git submodule update --recursive

If you are planning to do nightly builds, consider using the script qt5_tool that lives in qtrepotools/bin. It provides options for updating the repository, cleaning and building. For example, qt5_tool -u -c -b can be used to clean, update and build. qt5_tool -p -c – b would be used to pull all modules to the head of their master branches.

    Hint1: git submodule update does a hard reset on submodules, potentially getting rid of any local commits you’ve done! If the latter happened to you (and you haven’t been working with branches anyhow), git reflog is your friend ….
    Hint2: When creating scripts for updates on Windows, note that git clean often fails if some process locks a file or folder.

Using master branches in the submodules

By default the checkout will not contain the latest master branches of each individual submodule repository, but a combination of versions that are known to work together. If you want to get the absolute latest stuff you can do so on a per-module basis, e.g.

    cd qtdeclarative
    git fetch
    git checkout master origin/master

or use qt5_tool to update all repositories to master:

    ./qtrepotools/bin/qt5_tool -p

However, there’s a good chance that compilation will fail due to incompatible versions of submodules! You might want to ask other persons actively working on a module how to resolve these incompatibilities.
Issues
Linux
configure fails with “No QPA platform plugin enabled!” (Linux)

You should install the libxcb and it’s accompanying packages, see ‘System Requirements’.
qmlscene segfaults “Cannot create platform GL context, none of GLX, EGL, DRI2 is enabled” (Linux)

Try installing the libx11-xcb-dev package:

    sudo apt-get install libx11-xcb-dev

afterwards you have to re-run configure and force qtbase/src/plugins/platforms/xcb to recompile.
WebKit doesn’t compile, missing ICU

Currently there is no configure time check for ICU, so install it through the package manager through
on Ubuntu/Debian:

    sudo apt-get install libicu-dev

on Fedora:

    yum search ICU

Alternatively you can also compile Qt without webkit by deleting / renaming the qtwebkit, qtwebkit-examples-and-demos directories. The -no-webkit option of configure does not work yet : https://bugreports.qt-project.org/browse/QTBUG-20577
Windows
qdeclarative doesn’t compile because of missing v8.lib (Windows)

Compiling v8 in qtbase requires Python. Make sure you have a python.exe in your %PATH%, go to qtjsbackend, run qmake && nmake.
Debugging OpenGL issues (Windows)

Set the environment variable QT_QPA_VERBOSE=gl:1 and run the application with DebugView [technet.microsoft.com] installed. The log will show the requested vs obtained OpenGL version. If the log tells you that it only has OpenGL 1.1, QML2 will not work. Note that qmlscene will not report errors about unsupported OpenGL versions.
Questions & Comments

Please raise questions & comments about this article in the forum : http://developer.qt.nokia.com/forums/viewthread/7018
Categories:

    Developing_with_Qt
        Qt 5
    HowTo

Creative Commons Attribution-ShareAlike 2.5 Generic

Content is available under

Creative Commons Attribution-ShareAlike 2.5 Generic
 

    Qt Info
    Downloads
    Features & benefits
    Qt in Education
    Learning Qt
    Partnering

    Tasks
    Purchasing Qt (Digia)
    Bug reporting
    Code review
    Qt repositories (read-only)
    Newsletter sign-up

    Popular
    Qt Previews and Betas
    Qt Creator
    Qt Road map

    Activity
    Developer Blogs
    The Qt Blog
    Official News
    Events
    Activity Stream

    Contact
    Contact us | About us
     
    Qt on Twitter / Youtube
    Facebook / Linkedin

 

© 2011 Qt Project Hosting. Qt® and the Qt logo is a registered trade mark of Nokia Corporation and/or its subsidiaries and is used pursuant to a license from Nokia Corporation and/or its subsidiaries.
All other trademarks are property of their respective owners. Privacy Policy
This site is hosted by Gitorious AS. Your use of this web site is governed by these terms of service.

Qt Project Hosting, P.O. Box 4332 Nydalen, 0402 Oslo, Norway. Phone: +47 21 60 27 32. Org. Nr. 997 447 913
"

