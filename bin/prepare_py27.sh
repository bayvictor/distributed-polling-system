echo "Python 2.7 on Dreamhost
Python 2.7 was released on 3 July 2010 and I wanted to use it on my Dreamhost account, but the usual installation method yields some warnings:
Python build finished, but the necessary bits to build these modules were not found:
_bsddb             _tkinter           bsddb185
bz2                dl                 imageop         sunaudiodev
To find the necessary bits, look in setup.py in detect_modules() for the module's name.

Three of these modules cannot be installed on Dreamhost’s 64-bit Debian servers anyway and one of them is an older version of a module I am going to install:
bsddb185: Older version of Oracle Berkeley DB. Undocumented. Install version 4.8 instead.
dl: For 32-bit machines. Deprecated. Use ctypes instead.
imageop: For 32-bit machines. Deprecated. Use PIL instead.
sunaudiodev: For Sun hardware. Deprecated.
Now, if you don’t need any of those remaining modules, then you should be able to just complete the installation and be done with it. If you want all the modules that you can get, you are in for some extra building. This post does a good job of explaining the installation of Python 2.6; mine is based on it. Let’s put the files in the following directories:
Python 2.7
$HOME/local/Python-2.7
Berkeley DB 4.8
$HOME/local/BerkeleyDB.4.8
Other executables
$HOME/local/bin
Header files
$HOME/local/include
Libraries
$HOME/local/lib
Temporary artifacts
$HOME/temp
We’ll need to push these values $into the UNIX environment by using the export tool under the default bash shell:
$" 

export LDFLAGS="-L$HOME/local/lib -L$HOME/local/BerkeleyDB.4.8/lib"
 export CPPFLAGS="-I$HOME/local/include -I$HOME/local/BerkeleyDB.4.8/include"
 export CXXFLAGS=$CPPFLAGS
 export CFLAGS=$CPPFLAGS
 export LD_LIBRARY_PATH=$HOME/local/lib:$HOME/local/BerkeleyDB.4.8/lib
 export LD_RUN_PATH=$LD_LIBRARY_PATH
echo "xt make the directories:
$ 
"
mkdir  ~/local
ln -s ~/src ~/temp
echo "It’s also a good idea to check your machine (note the “x86_64” token). It should look similar to this:
$ 
"
uname -a
#Linux machine 2.6.32.8-grsec-2.1.14-modsign-xeon-64 #2 SMP Sat Mar 13 00:42:43 PST 2010 x86_64 GNU/Linux

 gcc -v
echo "Using built-in specs.
Target: x86_64-linux-gnu
Configured with: ../src/configure -v --with-pkgversion='Debian 4.3.2-1.1' --with-bugurl=file:///usr/share/doc/gcc-4.3/README.Bugs --enable-languages=c,c++,fortran,objc,obj-c++ --prefix=/usr --enable-shared --with-system-zlib --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --enable-nls --with-gxx-include-dir=/usr/include/c++/4.3 --program-suffix=-4.3 --enable-clocale=gnu --enable-libstdcxx-debug --enable-objc-gc --enable-mpfr --enable-cld --enable-checking=release --build=x86_64-linux-gnu --host=x86_64-linux-gnu --target=x86_64-linux-gnu
Thread model: posix
gcc version 4.3.2 (Debian 4.3.2-1.1) 
$
Berkeley DB will be hooked into the installed TCL, so you should install TCL before you install Berkeley DB. Install Python last. Other than that, I don’t believe that order of installation should matter. Let’s do it!
TCL/TK
The warning “_tkinter” indicates that the _tkinter module was not built. You will need to build both TCL and TK:
$ 
"
cd ~/temp
 pwd
/home/username/temp
 wget http://prdownloads.sourceforge.net/tcl/tcl8.5.8-src.tar.gz
 tar zxvf tcl8.5.8-src.tar.gz
 cd tcl8.5.8/unix
 ./configure --prefix=$HOME/local
 make
sudo make install
 cd ../..
 wget http://prdownloads.sourceforge.net/tcl/tk8.5.8-src.tar.gz
 tar zxvf tk8.5.8-src.tar.gz
 cd tk8.5.8/unix
 ./configure --prefix=$HOME/local
 make
 sudo make install 
 cd ../..
echo "Berkeley DB 4.8
The warning “_bsddb” will go away when you install version 4.8 of the Oracle Berkeley DB:
$ "
cd ~/temp
 wget http://download.oracle.com/berkeley-db/db-4.8.30.tar.gz
 tar zxvf db-4.8.30.tar.gz
 cd db-4.8.30/build_unix
 ../dist/configure --prefix=$HOME/local/BerkeleyDB.4.8 --enable-tcl --with-tcl=$HOME/local/lib
 make
 sudo make install 
 cd ../..
BZip2
echo "Dreamhoot has an earlier version of BZip2 (version 1.0.4) and no library (at least I couldn’t find one). To get the latest version:
$ 
"
cd ~/temp
 wget http://www.bzip.org/1.0.5/bzip2-1.0.5.tar.gz
 tar zxvf bzip2-1.0.5.tar.gz
 cd bzip2-1.0.5
 make -f Makefile-libbz2_so
 make
 sudo make install  PREFIX=$HOME/local
 cp ./libbz2.so.1.0.4 $HOME/local/lib
 ln -s $HOME/local/lib/libbz2.so.1.0.4 $HOME/local/lib/libbz2.so.1.0
 cd ..
echo "
Python 2.7
You should be able to build and install Python 2.7 now, less the modules that either cannot be built on a 64-bit platform or cannot coexist with a contemporary version.
$ 
"
cd ~/temp
 wget http://python.org/ftp/python/2.7/Python-2.7.tgz
 tar zxvf Python-2.7.tgz
 cd Python-2.7
 ./configure --prefix=$HOME/local/Python-2.7
 make
 sudo make install 

echo "
At the end of the make process, you will see this:
Python build finished, but the necessary bits to build these modules were not found:
bsddb185           dl                 imageop         
sunaudiodev                                       
To find the necessary bits, look in setup.py in detect_modules() for the module's name.

As mentioned earlier, these modules are either not buildable on Dreamhost’s 64-bit machines or not compatible with the newer version of Berkeley DB.
Hooking up the new Python
You want to put the new Python 2.7 on your PATH so that bash executes it before the systemwide Python 2.5. If you don’t want to append these export statements, you can also do it via a text editor (vim, emacs, etc).
$ cd ~
$ echo "export PATH=\"$HOME/local/bin:\$PATH\"" >> .bashrc
$ echo "export PATH=\"$HOME/local/Python-2.7/bin:\$PATH\"" >> .bashrc
$ source .bashrc
$ which python
/home/username/local/Python-2.7/bin/python
$ python -V
Python 2.7
Try it out!
Try out your new modules…at the shell prompt type “python”!
>>> import bsddb
>>> db = bsddb.btopen('/tmp/spam.db', 'c')
>>> for i in range(10): db['%d'%i] = '%d'% (i*i)
...
>>> db['3']
'9'
>>> db.keys()
['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
>>> db.sync()
>>> db.isOpen()
True
>>> import bz2
>>> print bz2.__author__
The bz2 python module was written by:
 
    Gustavo Niemeyer <niemeyer@conectiva.com>
 
>>> import Tkinter
>>> Tkinter.__version__
'$Revision: 81008 $'
"

