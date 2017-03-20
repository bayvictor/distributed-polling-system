#下载android源码并打包压缩供下载[2012-11-29验证]
sudo apt-get install -y git
 
sudo apt-get install -y curl
 
mkdir ~/bin
 
curl https://dl-ssl.google.com/dl/googlesource/git-repo/repo > ~/bin/repo
 
chmod a+x ~/bin/repo

#git-config --global user.name [your mailbox]
#git-config --global user.user [your name]


git config --global user.user bayvictor 
git config --global user.name bayvictor@gmail.com 


export atag='android-4.2.2_r1.2b'
 
export ASRC=~/android_src_${atag}   
mkdir $ASRC 
cd $ASRC  
echo "download android.src 4.2.2!   it will take a long time! result in ~/Download/$atag  !"
echo "^C to break, anykey to contiue....android-4.2.2_r1.2  downloading...."; read readline
 
repo init -u https://android.googlesource.com/platform/manifest -b $atag    
 
repo sync
 

tar zcvf ~/Downloads/${atag}.src.tar.gz $ASRC

 

