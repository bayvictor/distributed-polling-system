# finding your binary missing which 32bit lib
#ldd /path/to/binary | grep need
sudo apt-get install -y  lib32ncurses5 lib32z1 libc6-i386 libc6-dev-i386 lib32gcc1  lib32stdc++6
sudo apt-get install -y libcloog-ppl0

