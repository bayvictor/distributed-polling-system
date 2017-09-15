sudo umount /dev/cdrom
echo "Now, you need to use the dd command to create backup image of the DVD like this:

Code:"

sudo dd if=/dev/cdrom of=~/raw_dvd_backupdata_cn_db.img bs=512 conv=notrunc,noerror
