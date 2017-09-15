#!/bin/bash

if [ -z $1 ]; then
echo -e "\n Error: you need to define the arm-linux-gnueabi version"
echo -e " Usage: switch_arm-linux-gnueabi.sh \n"
exit
fi

if [ ! -f /usr/bin/arm-linux-gnueabi-cpp-$1 ]; then
echo -e "\n Error: arm-linux-gnueabi version $1 do not exist\n"
exit
fi

# Unlink symbolic links
sudo unlink /usr/bin/arm-linux-gnueabi-cpp
sudo unlink /usr/bin/arm-linux-gnueabi-gcc
sudo unlink /usr/bin/arm-linux-gnueabi-gcov

#Define new links for arm-linux-gnueabi
sudo ln -s /usr/bin/arm-linux-gnueabi-cpp-$1 /usr/bin/arm-linux-gnueabi-cpp
sudo ln -s /usr/bin/arm-linux-gnueabi-gcc-$1 /usr/bin/arm-linux-gnueabi-gcc
sudo ln -s /usr/bin/arm-linux-gnueabi-gcov-$1 /usr/bin/arm-linux-gnueabi-gcov
#EOF


