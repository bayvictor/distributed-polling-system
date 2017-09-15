cd /home/bsquare/dragonboard/8660_GB_2_3_5_2_AU50/
source build/envsetup.sh
choosecombo 1 1 msm8660_surf eng

cd '/home/bsquare/dragonboard/8660_GB_2_3_5_2_AU50/out/target/product/msm8660_surf' 

sudo /home/bsquare/bin/adb kill-server
sudo /home/bsquare/bin/adb start-server
adb devices
sudo /home/bsquare/bin/adb reboot-bootloader
sudo /home/bsquare/dragonboard/8660_GB_2_3_5_2_AU50/out/host/linux-x86/bin/fastboot devices
sudo /home/bsquare/dragonboard/8660_GB_2_3_5_2_AU50/out/host/linux-x86/bin/fastboot boot boot.img




