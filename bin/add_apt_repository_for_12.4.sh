echo " Ubuntu 12.4 install notes
Also related with install of Ubuntu 12.04 is my other post  Ubuntu 12.04 review on Lenovo Q150.

Add medibuntu repositories by running the commands below and use Software center to add the packages you need.
 Medibuntu is a packaging project dedicated to distributing software that cannot be included in Ubuntu for various reasons, related to geographical  variations in legislation regarding intellectual property, security and other issues, some examples of packages included in Medibuntu we find libdvdcss package from VideoLAN, FFMpeg codecs not supported in multiverse, and the external binary codecs package (commonly known as w32codecs) used by MPlayer and xine.

Medibuntu repositories are available for Ubuntu, Kubuntu, Xubuntu, Lubuntu and LinuxMint for both 32 and 64 bit.
Install Medibuntu on Ubuntu 12.04  LTS  Precise Pangolin:

Open terminal and enter the following commands:
"
sudo -E wget --output-document=/etc/apt/sources.list.d/medibuntu.list http://www.medibuntu.org/sources.list.d/$(lsb_release -cs).list && sudo apt-get --quiet update && sudo apt-get --yes --quiet --allow-unauthenticated install medibuntu-keyring && sudo apt-get --quiet update

    sudo apt-get --yes --quiet --allow-unauthenticated install medibuntu-keyring && sudo apt-get --quiet update

    sudo apt-get install app-install-data-medibuntu apport-hooks-medibuntu 

    sudo apt-get install non-free-codecs ubuntu-restricted-extras libdvdcss2



echo "For google applications add one by one, the apps will add the repositories of the apps you install.
http://www.google.com/linuxrepositories/

Flash:
"
    sudo apt-get install flashplugin-installer


echo "Minitube and Vlc:
"
    sudo apt-get install minitube vlc

echo "
Links:
http://www.unixmen.com/medibuntu-repositories-available-for-ubuntu-12-04-lts-precise-pangolin-ppa/
https://bugs.launchpad.net/ubuntu/+source/minitube/+bug/921287/comments/7
 Ubuntu 12.4 install notes
Also related with install of Ubuntu 12.04 is my other post  Ubuntu 12.04 review on Lenovo Q150.

Add medibuntu repositories by running the commands below and use Software center to add the packages you need.
"
sudo -E wget --output-document=/etc/apt/sources.list.d/medibuntu.list http://www.medibuntu.org/sources.list.d/$(lsb_release -cs).list && sudo apt-get --quiet update && sudo apt-get --yes --quiet --allow-unauthenticated install medibuntu-keyring && sudo apt-get --quiet update

    sudo apt-get --yes --quiet --allow-unauthenticated install medibuntu-keyring && sudo apt-get --quiet update

    sudo apt-get install app-install-data-medibuntu apport-hooks-medibuntu 

    sudo apt-get install non-free-codecs ubuntu-restricted-extras libdvdcss2


echo "
For google applications add one by one, the apps will add the repositories of the apps you install.
http://www.google.com/linuxrepositories/

Flash:
 On an APT-based system (Debian, Ubuntu, etc.), download the key and then use apt to install it.
"
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

echo "Recent versions of apt-get will automatically attempt to verify packages on download. If an appropriate key is not found or if the package is corrupted, you will get a message like the following:

(WARNING: The following packages cannot be authenticated!
packagename)
"
read readline

    sudo apt-get install flashplugin-installer


echo "Minitube and Vlc:
"
    sudo apt-get install minitube vlc

echo "
Links:
http://www.unixmen.com/medibuntu-repositories-available-for-ubuntu-12-04-lts-precise-pangolin-ppa/
https://bugs.launchpad.net/ubuntu/+source/minitube/+bug/921287/comments/7
"
