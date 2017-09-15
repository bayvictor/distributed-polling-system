wget http://ftp.gnu.org/gnu/libc/glibc-2.18.tar.xz
wget http://ftp.gnu.org/gnu/libc/glibc-2.14.tar.xz

tar -Jxf glibc-2.18.tar.xz
tar -Jxf glibc-2.14.tar.xz
source ~/setenv

subdirquickarm.sh glibc-2.18
subdirquickarm.sh glibc-2.14   


 
