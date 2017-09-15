echo "it's example to grow everything starting from this single file as seed!"

#sudo apt-get install -y git-doc git-gui gitcore gitosis
sudo apt-get install -y git-doc git-gui #gitcore gitosis


echo "know your build ID and board target
Connect your device to a PC and ensure that Developer mode is enabled. Once you have your
device connected correctly, issue a:
$ adb shell getprop ro.product.board
"
read readline

adb shell getprop ro.product.board

echo "This now provides you the value you need when you create your build
Now determine the version number of your build:
$ adb shell getprop ro.build.version.incremental
"
read readline

adb shell getprop ro.build.version.incremental

echo "Dragonboard APQ8060 Programming Guide
Page 5
BSQUARE Confidential
2.3.2 Building Open Sources
If the build number from your device is M8660AAABQNLYA3136-Dragon, then you can follow
these instructions on building. Otherwise, please contact MDPSupport@bsquare.com for build
instructions, giving them the values obtained in section 2.3.1.
"
read readline

wget https://www.codeaurora.org/patches/quic/la/PATCH_MSM8660_8230_Dragonboard_required_modifications_20110928.tar.gz
tar -xzvf PATCH_MSM8660_8230_Dragonboard_required_modifications_20110928.tar.gz
mkdir 8660_GB_2_3_5_2_AU50
cd 8660_GB_2_3_5_2_AU50
repo init --repo-url=git://codeaurora.org/tools/repo.git -u git://codeaurora.org/platform/manifest.git -b gingerbread_house -m M8660AAABQNLYA3136.xml
repo sync -j4
source build/envsetup.sh
choosecombo 1 1 msm8660_surf eng
repo start work --all
cd bootable/bootloader/lk/
git am --ignore-whitespace ../../../../patches/local/bootable/bootloader/lk/*.patch
cd ../../../kernel
git am --ignore-whitespace ../../patches/local/kernel/*.patch
cd ..
make -j4 BUILD_NUMBER=M8660AAABQNLYA3136-Dragon

