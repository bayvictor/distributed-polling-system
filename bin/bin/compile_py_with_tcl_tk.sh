export LOCAL=/usr/local

export PYPATH=$LOCAL/lib/python/2.7.13 
export PYPATH=$LOCAL/lib/python/3.5.3  
echo "First, let’s do Tcl:
"
cd ~/src
mkdir py
cd py
wget http://prdownloads.sourceforge.net/tcl/tcl8.4.20-src.tar.gz
tar xvf tcl8.4.20-src.tar.gz
cd tcl8.4.20-src
./configure --prefix=$LOCAL
make
make install
echo "And Tk next:
"
cd ..
wget http://prdownloads.sourceforge.net/tcl/tk8.4.20-src.tar.gz
tar xvf tk8.4.20-src.tar.gz
cd tk8.4.20-src
./configure --prefix=$LOCAL
make
make install
echo "
OK that was easy. Now let’s install python. You should have shell variable, PYPATH, defined that specifies where python will be installed. For instance, in my .bashrc, I have: export PYPATH=$LOCAL/lib/python/2.7.6.
"
cd ..

#wget --no-check-certificate https://www.python.org/ftp/python/2.7.6/Python-2.7.6.tgz
#tar xvf Python-2.7.6.tgz
#cd Python-2.7.6.tgz
cd ~/src/Python-2.7.13

./configure --prefix=$PYPATH --enable-shared --with-tcltk-includes="-I$LOCAL/include" --with-tcltk-libs="-L$LOCAL/lib -ltcl8.4 -L$LOCAL/lib -ltk8.4"
make
make install
cd ..

cd ~/src/Python-3.5.3 

./configure --prefix=$PYPATH --enable-shared --with-tcltk-includes="-I$LOCAL/include" --with-tcltk-libs="-L$LOCAL/lib -ltcl8.4 -L$LOCAL/lib -ltk8.4"
make
make install
cd ..


echo "


Update (or define if they aren’t already) the following in your .bashrc:
i
"

export LIBRARY_PATH=$PYPATH # $PYPATH:$LIBRARY_PATH if already defined
export LD_LIBRARY_PATH=$PYPATH # similar ^
echo "Now we need to create some symlinks:
"
export PATH=$LOCAL/bin:$PATH # append only if PATH is defined. change dir as you manage.
ln -s $PYPATH/bin/python $LOCAL/bin/python
ln -s $PYPATH/bin/python-config $LOCAL/bin/python-config
echo "Now check
"
python -V # should return 2.7.6
echo "Finally, you should install pip. Pip is a package manager for python libraries that, when possible, makes installing and book-keeping python extensions a breeze. Install as follows:
"

wget --no-check-certificate https://raw.github.com/pypa/pip/master/contrib/get-pip.py
python get-pip.py
ln -s $PYPATH/pip $LOCAL/bin/pip
ln -s $PYPATH/easy_install $LOCAL/bin/easy_install
echo "
Great. Now you can install some other great packages easily:
"
pip install cython # for compiling python into c
pip install nose # unit tests
pip install memory_profiler # great tool for tracking the line-by-line memory behavior of a script



