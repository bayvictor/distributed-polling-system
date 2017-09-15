
export PKG_CONFIG_PATH=/opt/crosstool/libs/pkgconfig/

sudo ./configure --prefix=/opt/crosstool/ --host=arm-linux --build=i686-linux CC=arm-linux-gcc RANLIB=arm-linux-ranlib LD=arm-linux-ld --cache-file=arm-linux-cache LDFLAGS="-L/opt/crosstool/lib" CFLAGS="-I/opt/crosstool/include"
 
checking for msgfmt... no
configure: error:
*** You must have either have gettext support in your C library, or use the
*** GNU gettext library. (http://www.gnu.org/software/gettext/gettext.html
 
I had made gettext in /opt/crosstool/ , 
in include file ,there have gettext-po.h
 
in lib file, there have 
libgettextlib-0.14.so  libgettextpo.a   libgettextpo.so.0      libgettextsrc.la
libgettextlib.la       libgettextpo.la  libgettextpo.so.0.1.0  libgettextsrc.so
libgettextlib.so       libgettextpo.so  libgette xtsrc-0.14.so
 
and i had set the LDFLAGS and CFLAGS, Why the configure cann't find the gettext?
Is my setting error?Please tell me how to solve this problem

Hi Jjon, this appears to be because autoconf can't find the package config files... try something like this:

export PKG_CONFIG_PATH=/opt/crosstool/libs/pkgconfig/
./configure ... etc..




