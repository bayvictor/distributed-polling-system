 ZLIB_CFLAGS=-I/home/myuser/cross_lib/include/libzlib \
ZLIB_LIBS="-L/home/myuser/cross_lib/lib/libzlib/raspberry -lz" \
LDFLAGS="-L/home/myuser/cross_lib/libffi/lib -lffi -L/home/myuser/cross_lib/lib/libzlib/raspberry -lz" 
LIBFFI_CFLAGS=-I/home/myuser/cross_lib/libffi/lib/libffi-3.0.11/include \
LIBFFI_LIBS="-L/home/myuser/cross_lib/libffi/lib -lffi" \
./configure --host=arm-bcm2708hardfp-linux-gnueabi glib_cv_stack_grows=yes \
glib_cv_uscore=yes ac_cv_func_posix_getpwuid_r=no \
ac_cv_func_posix_getgrgid_r=no --with-libiconv=no --without-pcre \
--enable-gtk-doc-html=no --enable-xattr=no --prefix=/home/cross_lib/glib23


