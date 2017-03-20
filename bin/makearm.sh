export curdir=${PWD}
export ARMROOT=${PWD}/../armroot

export PATH=${ARMROOT}/bin:$PATH
export LD_LIBRARY_PATH=${ARMROOT}/lib:$LD_LIBRARY_PATH
CC=arm-cisco-linux-gnueabi-gcc AR=arm-cisco-linux-gnueabi-ar RANLIB=arm-cisco-linux-gnueabi-ranlib SKIP_RMDIR_CHECK=yes ./configure --target=arm-cisco-linux  --host=armel --prefix=${ARMROOT}  --enable-shared

 

 
