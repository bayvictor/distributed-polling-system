echo "
How-to: Cross-compile with scratchbox2   
by macrule2001 » Wed Jan 05, 2011 2:22 pm

I've been doing quite some cross-compiling of all sorts of libraries for my attempts of getting webkit running. I started out with the traditional cross-compiling and had all sorts of little quirks to work around. A couple days ago I learnt about scratchbox2 and things became ridiculously simple once it's set up.

So here is my little how-to, hoping it makes the lives of those easier who want to compile whatever for the WDTV. This is for the advanced reader who knows their way around the usual "configure/make/make install".

Setting up scratchbox2

1. Get sbox2 from git://gitorious.org/scratchbox2/scratchbox2.git, compile and install.
CODE: SELECT ALL
"
mkdir ~/src/scratchbox2
cd  ~/src/scratchbox2


git clone git://gitorious.org/scratchbox2/scratchbox2.git sbox2
cd sbox2
./autogen.sh
./configure --prefix=/usr/local
make
sudo make install

echo "Don't be tempted by debian packages, they are likely to be way behind the current version.

2. Install qemu-user and fakeroot (you can use aptitude or other package manager here). sbox2 uses qemu to run mips-binaries as they are needed during the configure phase or for tests.

3. Find \"rootfs\" in WDTV GPL package (can be downloaded from WDTV support page) and extract it into our buildroot directory (from now on called $BUILDROOT, and you can put it wherever you like):
CODE: SELECT ALL
"
echo "^C to break, anykey to continue....";read readline



export BUILDROOT=/home/wdtv/buildroot
./cramfs_linux/cramfsck -x $BUILDROOT rootfs

echo "Search this forum for cramfsck if it doesn't work right away.

4. Extract the WDTV toolchain package anywhere you like (can be downloaded from WDTV support page).

5. Set up the sbox2 environment:
CODE: SELECT ALL
"

echo "^C to break, anykey to continue....";read readline

cd $BUILDROOT
sb2-init -c "/usr/bin/qemu-mipsel -cpu 24Kf" -A mipsel -M mips wdtvmipsel /home/wdtv/toolchain/mips-4.3/bin/mips-linux-gnu-gcc

echo "This will fail because the -C option for sb2-init doesn't work yet. We have to tweak the config manually first.

So "

echo "
gedit ~/.scratchbox2/wdtvmipsel/sb2.config.d/gcc.config.sh 

gedit  ~/.scratchbox2/wdtvmipsel/sb2.config.d/gcc.config.lua 


to contain -EL in SBOX_EXTRA_CROSS_COMPILER_ARGS and extra_cross_compiler_args (-EL is the gcc switch for little-endian mips)

Now retry the failed step:
CODE: SELECT ALL
"

echo "^C to break, anykey to continue....";read readline

gedit ~/.scratchbox2/wdtvmipsel/sb2.config.d/gcc.config.sh 

gedit  ~/.scratchbox2/wdtvmipsel/sb2.config.d/gcc.config.lua 


echo "^C to break, anykey to continue....";read readline

sb2 /usr/local/bin/sb2-build-libtool


echo "6. Install some tools into the buildroot that may be required. This is pretty much optional until you run into a situation where configure or make demand any of the tools below and are run with qemu. Choose and pick as you desire and need:

CODE: SELECT ALL
"

echo "^C to break, anykey to continue....";read readline

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



echo "[source toolchain.env here]
"


../configure --target=mipsel-linux --host=mipsel-linux --build=i686 --prefix=/usr --enable-languages=c --disable-libmudflap
make
make install prefix=$BUILDROOT/usr

Now sbox2 is ready to compile whatever you like. Anything you install will be installed below $BUILDROOT.

Using sbox2 to cross-compile

It's pretty simple. You do the same what you always do to compile something, but you now prepend the command with sb2. So for a simple project it looks like this:
CODE: SELECT ALL
sb2 ./configure --prefix=/usr
sb2 make
sb2 -eR make install

echo "^C to break, anykey to continue....";read readline

echo "What happens here exactly? sb2 ensures that certain paths are remapped before being used. For example if configure calls "gcc" it will really use the mips-linux-gcc, but it won't know about it. Also /usr is really $BUILDROOT/usr when we make install.

Here are a few good points to know:
\"sb2 -e\" forces running a binary through qemu, if you don't use it, it will use qemu only when needed.
\"sb2 -eR for make install\" will run the mips make binary, it's the recommended way, but it may fail depending on the project. If that is the case a good workaround is "sb2 make install DESTDIR=$BUILDROOT"
In most cases you will want to set PKG_CONFIG_PATH to "$BUILDROOT/usr/lib/pkgconfig", sb2 doesn't seem to remap that automatically
My first tries went horribly wrong because I wanted to install in a nonstandard location "/webkit". sb2 didn't remap those paths and nothing worked. Once I found out about that, I installed into /usr. I don't know if /usr/local or anything works. But if things go wrong look out for that.

Testing without going to the WDTV

The beauty of this all is, that you can now also test the compiled binaries easily:
CODE: SELECT ALL
"

sb2 -eR /usr/bin/gtk-demo


echo "^C to break, anykey to continue....";read readline

echo "ieThis will run the mipsel-binary $BUILDROOT/usr/bin/gtk-demo. It will find all its libraries in $BUILDROOT/usr/lib and for the most part things just work if qemu can deal with them.
macrule2001

 
Posts: 22
Joined: Mon Nov 08, 2010 4:56 pm
"


