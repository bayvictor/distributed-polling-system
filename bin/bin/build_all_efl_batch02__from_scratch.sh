#!/bin/sh
set -e
PREFIX="/usr/local"
PROJECTS="\
eina eet evas evas_generic_loaders ecore embryo edje e_dbus efreet eeze e"
SITE="svn.enlightenment.org"
SVN="http://$SITE/svn/e/trunk"
OPT="--prefix=$PREFIX"
svn co $SVN
PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"
PATH="$PREFIX/bin:$PATH"
LD_LIBRARY_PATH="$PREFIX/lib:$LD_LIBRARY_PATH"
for PROJ in $PROJECTS; do
  cd trunk/$PROJ
  make clean distclean || true
  ./autogen.sh $OPT
  make
  sudo make install
  cd ../..
  sudo ldconfig
done

