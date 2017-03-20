# finding your binary missing which 32bit lib
#ldd /path/to/binary | grep need
sudo apt-get install -y  lib32ncurses5 lib32z1 libc6-i386 libc6-dev-i386 lib32gcc1  lib32stdc++6
sudo apt-get install -y libcloog-ppl0

sudo dpkg -i --force-architecture /sda354T/qt/libcloog-ppl/0.15.8/libcloog-ppl-dev_0.15.8-1_i386.deb
