#sudo dd if=/dev/hda of=/media/ExternalHardDisk/rawimage.img or replace /dev/hda with /dev/hda1 for just the partition
echo "sudo dd if=/dev/sda5 of=/sde1/victor_saved_logs/gigabit_sda5_redmineOK_rawimage.dd.img.bin bs=100M"

echo "waiting... dd redmine partition takes a long time....."

#sudo dd if=/dev/sda5 of=/sde1/victor_saved_logs/gigabit_sda5_redmineOK_rawimage.dd.img.bin bs=100M  
sudo dd if=/dev/sda8 of=/sde1/victor_saved_logs/gigabit_sda8_redmineOK_rawimage.dd.img.bin bs=100M  

#sudo dd if=/dev/hda of=/media/ExternalHardDisk/rawimage.img or replace /dev/hda with /dev/hda1 for just the partition

