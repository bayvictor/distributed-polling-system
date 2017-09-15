aclocal

cp confgiure.ac configure.ac.`timestamp`
autoscan
cp configure.scan configure.ac 
autoheader
autoconf configure.ac > configure


# run order
#aclocal autoconf autoheader 

automake --add-missing









