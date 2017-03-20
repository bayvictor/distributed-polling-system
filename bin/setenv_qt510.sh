#!/usr/bin/bash 
unset QTDIR
export QTDIR=/home/vhuang/Qt/5.1.0/5.1.0-rc2/Src


PATH=/home/vhuang/Qt/Tools/QtCreator/bin:/home/vhuang/adt-bundle-linux/eclipse:/home/vhuang/adt-bundle-linux/sdk/tools:/home/vhuang/adt-bundle-linux/sdk/platform-tools:/home/vhuang/android-ndk-r8e:/home/vhuang/bin:/usr/lib/jvm/java-6-openjdk-amd64/bin:/usr/bin:/usr/local/bin:/home/vhuang/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/vhuang/.gem/ruby/1.8/bin:/home/vhuang/qtcreator-2.7.0/bin

LD_LIBRARY_PATH=/home/vhuang/home/lib:/home/usr/lib:/home/usr/local/lib:/home/vhuang/lib:/usr/lib/jvm/java-6-openjdk-amd64/lib:/usr/lib:/usr/local/lib:/lib


export PATH=${QTDIR}/../../Tools/QtCreator/bin:${QTDIR}/../gcc_64/bin:${QTDIR}/qtbase/bin:${QTDIR}/qtjsbackend/bin:${QTDIR}/qtdeclarative/bin:$PATH

export LD_LIBRARY_PATH=${QTDIR}/../../Tools/QtCreator/lib:${QTDIR}/../gcc_64/lib:${QTDIR}/qtbase/lib:${QTDIR}/qtjsbackend/lib:${QTDIR}/qtdeclarative/lib:$LD_LIBRARY_PATH


