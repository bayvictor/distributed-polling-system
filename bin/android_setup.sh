cd ~
DIR=`ls ~/adt-bundle-linux|grep adt-bundle-linux`
if test -z $DIR; then
unzip  /home/vhuang/Downloads/adt-bundle-linux-x86_64.zip
tar -jxf /home/vhuang/Downloads/android-ndk-r8d-linux-x86.tar.bz2

echo "export PATH=~/adt-bundle-linux/bin:~/android-ndk-r8d/bin:~/android-ndk-r8d/eclipse:$PATH
" >> ~/.bashrc

source ~/.bashrc

env|grep JAVA_HOME

env|grep PATH|tr ':' '\n' | grep adt
env|grep PATH|tr ':' '\n' | grep ndk


fi

