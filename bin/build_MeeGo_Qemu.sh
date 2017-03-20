git clone git://gitorious.org/qemu-maemo/qemu.git 
cd qemu
./configure --target-list="arm-softmmu" --enable-gles2 --gles2dir=/opt/dgles2
make
cp arm-softmmu/qemu-system-arm ~/bin/meego-qemu

