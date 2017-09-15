grub-mkconfig
update-grub
ls /boot/`ls /boot -lt|head|grep initrd |cut -d":" -f2 |cut -d" " -f2|head -n 1`
echo "^c to break, anykey to contiue...";read readline

update-initramfs -u # /boot/`ls /boot -lt|head|grep initrd |cut -d":" -f2 |cut -d" " -f2|head -n 1`



