echo "How-to: Cross-compile with scratchbox2
Post a reply
54 posts • Page 1 of 6 • 123456
How-to: Cross-compile with scratchbox2   

Postby macrule2001 » Wed Jan 05, 2011 2:22 pm
I've been doing quite some cross-compiling of all sorts of libraries for my attempts of getting webkit running. I started out with the traditional cross-compiling and had all sorts of little quirks to work around. A couple days ago I learnt about scratchbox2 and things became ridiculously simple once it's set up.

So here is my little how-to, hoping it makes the lives of those easier who want to compile whatever for the WDTV. This is for the advanced reader who knows their way around the usual "configure/make/make install".

Setting up scratchbox2

1. Get sbox2 from git://gitorious.org/scratchbox2/scratchbox2.git, compile and install.

Code: Select all
"
    git clone git://gitorious.org/scratchbox2/scratchbox2.git sbox2
    cd sbox2
    ./autogen.sh
    ./configure --prefix=/usr/local
    make
    sudo make install


echo "Don't be tempted by debian packages, they are likely to be way behind the current version.

2. Install qemu-user and fakeroot (you can use aptitude or other package manager here). sbox2 uses qemu to run mips-binaries as they are needed during the configure phase or for tests.

3. Find "rootfs" in WDTV GPL package (can be downloaded from WDTV support page) and extract it into our buildroot directory (from now on called $BUILDROOT, and you can put it wherever you like):

Code: Select all
"
    export BUILDROOT=/home/wdtv/buildroot
    ./cramfs_linux/cramfsck -x $BUILDROOT rootfs


echo "Search this forum for cramfsck if it doesn't work right away.

4. Extract the WDTV toolchain package anywhere you like (can be downloaded from WDTV support page).

5. Set up the sbox2 environment:

Code: Select all
    cd "

$BUILDROOT
    sb2-init -c "/usr/bin/qemu-mipsel -cpu 24Kf" -A mipsel -M mips wdtvmipsel /home/wdtv/toolchain/mips-4.3/bin/mips-linux-gnu-gcc


echo "This will fail because the -C option for sb2-init doesn't work yet. We have to tweak the config manually first.

So edit ~/.scratchbox2/wdtvmipsel/sb2.config.d/gcc.config.sh and ~/.scratchbox2/wdtvmipsel/sb2.config.d/gcc.config.lua to contain -EL in SBOX_EXTRA_CROSS_COMPILER_ARGS and extra_cross_compiler_args (-EL is the gcc switch for little-endian mips)

Now retry the failed step:

Code: Select all
"
    sb2 /usr/local/bin/sb2-build-libtool



echo "6. Install some tools into the buildroot that may be required. This is pretty much optional until you run into a situation where configure or make demand any of the tools below and are run with qemu. Choose and pick as you desire and need:

Code: Select all
"
    cd bash-4.1/
    sb2 ./configure --prefix=$BUILDROOT
    sb2 make
    sb2 make install

    cd make-3.82/
    sb2 ./configure --prefix=$BUILDROOT/usr
    sb2 make
    sb2 make install

    cd coreutils-8.8/
    sb2 ./configure --prefix=$BUILDROOT/usr
    sb2 make
    sb2 make install
    cd $BUILDROOT/bin
    ln -s ../usr/bin/mkdir

    cd binutils-2.21/
    sb2 ./configure --prefix=$BUILDROOT/usr
    sb2 make
    sb2 make install

    cd gawk-3.1.8/
    sb2 ./configure --prefix=$BUILDROOT/usr
    sb2 make
    sb2 make install

    cd gcc-4.3.2/
    tar xjf mpfr-2.4.2.tar.bz2
    mv mpfr-2.4.2 mpfr
    tar xjf gmp-5.0.1.tar.bz2
    mv gmp-5.0.1 gmp
    tar xzf mpc-0.8.2.tar.gz
    mv mpc-0.8.2 mpc
    mkdir build
    cd build
    [source toolchain.env here]
    ../configure --target=mipsel-linux --host=mipsel-linux --build=i686 --prefix=/usr --enable-languages=c --disable-libmudflap
    make
    make install prefix=$BUILDROOT/usr



echo "Now sbox2 is ready to compile whatever you like. Anything you install will be installed below $BUILDROOT.

Using sbox2 to cross-compile

It's pretty simple. You do the same what you always do to compile something, but you now prepend the command with sb2. So for a simple project it looks like this:

Code: Select all
"
    sb2 ./configure --prefix=/usr
    sb2 make
    sb2 -eR make install



echo "What happens here exactly? sb2 ensures that certain paths are remapped before being used. For example if configure calls "gcc" it will really use the mips-linux-gcc, but it won't know about it. Also /usr is really $BUILDROOT/usr when we make install.

Here are a few good points to know:
"
echo "#    "sb2 -e" forces running a binary through qemu, if you don't use it, it will use qemu only when needed.
#    "sb2 -eR for make install" will run the mips make binary, it's the recommended way, but it may fail depending on the project. If that is the case a good workaround is "sb2 make install DESTDIR=$BUILDROOT"
    In most cases you will want to set PKG_CONFIG_PATH to "$BUILDROOT/usr/lib/pkgconfig", sb2 doesn't seem to remap that automatically
    My first tries went horribly wrong because I wanted to install in a nonstandard location "/webkit". sb2 didn't remap those paths and nothing worked. Once I found out about that, I installed into /usr. I don't know if /usr/local or anything works. But if things go wrong look out for that.


Testing without going to the WDTV

The beauty of this all is, that you can now also test the compiled binaries easily:

Code: Select all
"
    sb2 -eR /usr/bin/gtk-demo



echo "This will run the mipsel-binary $BUILDROOT/usr/bin/gtk-demo. It will find all its libraries in $BUILDROOT/usr/lib and for the most part things just work if qemu can deal with them.

macrule2001
    Developer
     
    Posts: 22
    Joined: Mon Nov 08, 2010 4:56 pm

Top
Re: How-to: Cross-compile with scratchbox2   

Postby macrule2001 » Wed Jan 05, 2011 2:32 pm
Here are some of my notes, how I built libraries as I needed them for webkit testing. They should work, but YMMV:
"
echo "
zlib-1.2.3

Code: Select all
"
    sb2 ./configure --prefix=/usr --shared
    sb2 make
    sb2 -eR make install

echo "
libpng-1.2.14

Code: Select all
"
    sb2 ./configure --prefix=/usr --with-libpng-compat
    sb2 make
    sb2 -eR make install

echo "
jpeg-6b

Code: Select all
"
    replace config.guess with a more recent one (like from the WDTV GPL jpeg package)
    sb2 ./configure --prefix=/usr --enable-shared
    sb2 make
    mkdir -p $BUILDROOT/usr/man/man1
    sb2 -eR make install


echo "libiconv-1.12

Code: Select all
"
    sb2 ./configure --prefix=/usr
    sb2 make
    sb2 make install DESTDIR=$BUILDROOT

echo "
icu4c-4_4_2

Code: Select all
    cd source
    sb2 ./configure --prefix=/usr
    sb2 make
    sb2 -eR make install


libxml2-2.7.8

Code: Select all
    sb2 ./configure --prefix=/usr
    sb2 make
    sb2 -eR make install


libxslt-1.1.26

Code: Select all
    sb2 ./configure --prefix=/usr --without-crypto
    sb2 make
    sb2 make install DESTDIR=$BUILDROOT


glib-2.26.1

Code: Select all
    sb2 ./configure --prefix=/usr --with-libiconv=gnu
    sb2 make
    (sb2 make test-report)
    sb2 make install DESTDIR=$BUILDROOT


atk-1.32.0

Code: Select all
    PKG_CONFIG_PATH=$BUILDROOT/usr/lib/pkgconfig sb2 ./configure --prefix=/usr
    sb2 make
    sb2 -eR make install


freetype-2.3.7

Code: Select all
    PKG_CONFIG_PATH=$BUILDROOT/usr/lib/pkgconfig sb2 ./configure --prefix=/usr
    sb2 make
    sb2 -eR make install


fontconfig-2.7.3

Code: Select all
    PKG_CONFIG_PATH=$BUILDROOT/usr/lib/pkgconfig sb2 ./configure --prefix=/usr
    sb2 make
    sb2 -eR make install


DirectFB-1.0.0

Code: Select all
    PKG_CONFIG_PATH=$BUILDROOT/usr/lib/pkgconfig sb2 ./configure --prefix=/usr --enable-x11=no --with-gfxdrivers=none
    sb2 make
    sb2 make install DESTDIR=$BUILDROOT


pixman-0.20.0

Code: Select all
    PKG_CONFIG_PATH=$BUILDROOT/usr/lib/pkgconfig sb2 ./configure --prefix=/usr
    sb2 make
    sb2 -eR make install


cairo-1.10.0

Code: Select all
    modify src/cairo-directfb-surface.c by commenting out lines with DSPF_RGB444/DSPF_RGB555 in them
    PKG_CONFIG_PATH=$BUILDROOT/usr/lib/pkgconfig sb2 ./configure --prefix=/usr --enable-directfb=yes --without-x --disable-xlib --disable-xlib-xrender --enable-png
    sb2 make
    sb2 make install DESTDIR=$BUILDROOT


pango-1.28.2

Code: Select all
    PKG_CONFIG_PATH=$BUILDROOT/usr/lib/pkgconfig sb2 ./configure --prefix=/usr --without-x
    sb2 make
    sb2 make install DESTDIR=$BUILDROOT


gtk+-2.16.6

Code: Select all
    PKG_CONFIG_PATH=$BUILDROOT/usr/lib/pkgconfig sb2 ./configure --prefix=/usr --with-gdktarget=directfb --without-libjasper --without-libtiff --with-included-loaders=jpeg,gif,png,xpm
    sb2 make
    sb2 make install DESTDIR=$BUILDROOT
    cp -Rp /usr/share/fonts/truetype $BUILDROOT/usr/share/fonts/


enchant-1.6.0

Code: Select all
    PKG_CONFIG_PATH=$BUILDROOT/usr/lib/pkgconfig sb2 ./configure --prefix=/usr --disable-ispell --disable-myspell --disable-aspell
    sb2 make
    sb2 -eR make install


sqlite-3.7.3

Code: Select all
    PKG_CONFIG_PATH=$BUILDROOT/usr/lib/pkgconfig sb2 ./configure --prefix=/usr
    sb2 make
    sb2 -eR make install


libsoup-2.32.0

Code: Select all
    PKG_CONFIG_PATH=$BUILDROOT/usr/lib/pkgconfig sb2 ./configure --prefix=/usr --without-gnome --disable-ssl
    sb2 make
    sb2 -eR make install

macrule2001
    Developer
     
    Posts: 22
    Joined: Mon Nov 08, 2010 4:56 pm

Top
Re: How-to: Cross-compile with scratchbox2   

Postby recliq » Wed Jan 05, 2011 5:55 pm
:shock: Very nice, I have to try this...

THX :mrgreen:
­WDLXTV Project Maintainer
-:] If you like my contributions feel free to donate for a beer or a new flash drive. ...and always remember: RTFM! (README, FAQ, WIKI) [:-

User avatar
recliq
    WDLXTV Team
     
    Posts: 5078
    Joined: Thu Apr 15, 2010 8:09 am
    Location: Kiel, Germany

Top
Re: How-to: Cross-compile with scratchbox2   

Postby RMerlin » Sat Jan 08, 2011 2:09 pm
Tried to install this under Ubuntu 10.04, no luck.

I tried compiling qemu from git (as explained in sb2's doc, except I used mipsel-linux-user as my target-list. Tried applying some kernel level tweaks as explained on the Maemo Wiki:

Code: Select all
    vm.vdso_enabled = 0
    vm.mmap_min_addr = 4096



So far, still no luck.

Code: Select all
    merlin@WDTVDev:~/buildroot$ sb2 /usr/local/bin/sb2-build-libtool
    checking for a BSD-compatible install... /usr/bin/install -c
    checking whether build environment is sane... yes
    checking for a thread-safe mkdir -p... /bin/mkdir -p
    checking for gawk... gawk
    checking whether make sets $(MAKE)... yes
    checking for gcc... gcc
    checking for C compiler default output file name... a.out
    checking whether the C compiler works... configure: error: cannot run C compiled programs.
    If you meant to cross compile, use `--host'.
    See `config.log' for more details.



Where is that config.log so I could have a look at it?
WDLXTV Webend maintainer. Visit http://www.lostrealm.ca/wdlxtv to see my other WDLXTV projects.
If you like my work, please consider donating.

User avatar
RMerlin
    WDLXTV Team
     
    Posts: 3236
    Joined: Sat Jun 26, 2010 9:25 am
    Location: Montreal, Canada

Top
Re: How-to: Cross-compile with scratchbox2   

Postby macrule2001 » Sat Jan 08, 2011 2:20 pm
I'm on debian squeeze (so not that far from Ubuntu) and installed the "qemu-user" package with aptitude. I got the same error before adding "-EL" to the gcc flags in the sb2 config. You probably aren't using the "right" qemu for mipsel yet (wrong path perhaps? It's stored in ~/.scratchbox2/wdtvmipsel/sb2.config), or don't have the gcc flags right yet.

The config.log is somewhere below ~/.scratchbox2 I believe.

macrule2001
    Developer
     
    Posts: 22
    Joined: Mon Nov 08, 2010 4:56 pm

Top
Re: How-to: Cross-compile with scratchbox2   

Postby RMerlin » Sat Jan 08, 2011 2:24 pm
I had the same issue with both the qemu from Ubuntu (theirs was named qemu-mipsel-static) and my own built from git. I'm now trying again but compiling mipsel-softmmu instead of mipsel-linux-user, will see what happens.
WDLXTV Webend maintainer. Visit http://www.lostrealm.ca/wdlxtv to see my other WDLXTV projects.
If you like my work, please consider donating.

User avatar
RMerlin
    WDLXTV Team
     
    Posts: 3236
    Joined: Sat Jun 26, 2010 9:25 am
    Location: Montreal, Canada

Top
Re: How-to: Cross-compile with scratchbox2   

Postby RMerlin » Sat Jan 08, 2011 2:32 pm
Alright, definitely related to qemu:

Code: Select all
    merlin@WDTVDev:~/buildroot$ /home/merlin/sb2/bin/qemu-system-mipsel -cpu 24Kf
    qemu: Could not load MIPS bios 'mipsel_bios.bin', and no -kernel argument was specified



I can see the same error message in config.log:

Code: Select all
    configure:2967: checking whether the C compiler works
    configure:2977: ./a.out
    qemu: Could not load MIPS bios 'mipsel_bios.bin', and no -kernel argument was specified
    configure:2980: $? = 1
    configure:2989: error: cannot run C compiled programs.



This is the error I'm getting with the mipsel-softmmu I just recompiled.

UPDATE:

I re-compiled again with the mipsel-linux-user version, getting a different error in configure.log:

Code: Select all
    gcc version 4.3.2 (Sourcery G++ Lite 4.3-51)
    configure:2849: $? = 0
    configure:2856: gcc -V >&5
    mips-linux-gnu-gcc: couldn't run '/home/merlin/toolchain/mips-4.3/bin/mips-linux-gnu-gcc--specs=/usr/local/share/scratchbox2/mod
    econf/gcc-specs.simple': No such file or directory
    configure:2859: $? = 1
    configure:2882: checking for C compiler default output file name
    configure:2909: gcc    conftest.c  >&5
    configure:2912: $? = 0
    configure:2950: result: a.out
    configure:2967: checking whether the C compiler works
    configure:2977: ./a.out
    /lib/ld.so.1: No such file or directory
    configure:2980: $? = 255
    configure:2989: error: cannot run C compiled programs.
    If you meant to cross compile, use `--host'.
    See `config.log' for more details.



At least I got an error log to work with now. I'll do some digging around this after supper, will keep you informed, thanks.
Last edited by RMerlin on Sat Jan 08, 2011 2:41 pm, edited 1 time in total.
WDLXTV Webend maintainer. Visit http://www.lostrealm.ca/wdlxtv to see my other WDLXTV projects.
If you like my work, please consider donating.

User avatar
RMerlin
    WDLXTV Team
     
    Posts: 3236
    Joined: Sat Jun 26, 2010 9:25 am
    Location: Montreal, Canada

Top
Re: How-to: Cross-compile with scratchbox2   

Postby macrule2001 » Sat Jan 08, 2011 2:35 pm
Ah! Not qemu-system-mipsel. You'll want qemu-mipsel since sb2 emulates single commands, not a complete linux system.

macrule2001
    Developer
     
    Posts: 22
    Joined: Mon Nov 08, 2010 4:56 pm

Top
Re: How-to: Cross-compile with scratchbox2   

Postby RMerlin » Sat Jan 08, 2011 2:48 pm
I found it! Was missing a space at the end, probably on the original sb2-init line. See there:

Code: Select all
    mips-linux-gnu-gcc: couldn't run '/home/merlin/toolchain/mips-4.3/bin/mips-linux-gnu-gcc--specs=/usr/local/share/scratchbox2/mod

WDLXTV Webend maintainer. Visit http://www.lostrealm.ca/wdlxtv to see my other WDLXTV projects.
If you like my work, please consider donating.

User avatar
RMerlin
    WDLXTV Team
     
    Posts: 3236
    Joined: Sat Jun 26, 2010 9:25 am
    Location: Montreal, Canada

Top
Re: How-to: Cross-compile with scratchbox2   

Postby macrule2001 » Sat Jan 08, 2011 2:54 pm
That would do it :)

macrule2001
    Developer
     
    Posts: 22
    Joined: Mon Nov 08, 2010 4:56 pm

Top
Next Display posts from previous: Sort by
Post a reply
54 posts • Page 1 of 6 • 123456

Return to WDTV Live
Jump to:
Who is online

Users browsing this forum: No registered users and 3 guests

    Board index
    The team • Delete all board cookies • All times are UTC - 8 hours

Powered by phpBB © 2000, 2002, 2005, 2007 phpBB Group
To register for all WDLXTV sites you must sign up at wdlxtv.com


"




