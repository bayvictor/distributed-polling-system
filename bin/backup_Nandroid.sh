echo "Make a Nandroid backup, and copy the folder off your SD card to your desktop."
read readline
BDIR=backup_$1__`timestamp`
mkdir $BDIR
#    cd ~/Desktop/path/to/backup/ 
cd $BDIR
    fastboot flash userdata data.img 
    fastboot flash system system.img 
    fastboot flash boot boot.img 
    fastboot reboot 
