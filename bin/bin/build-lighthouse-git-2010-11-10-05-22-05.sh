#!/bin/bash

export NDK_ROOT=/home/vhuang/src/android/android-ndk-r4b
export NDK_PROJECT_PATH=/home/vhuang/src/android/lighthouse4.7/git/lighthouse
export APP_MODULES=qt-lighthouse471
#export APP=qt-lighthouse471
cd $NDK_ROOT
make APP=qt-lighthouse471 V=4.71 #-j X  , where X is the number of CPU cores+1 
#make V=4.71 #-j X  , where X is the number of CPU cores+1 
#make
