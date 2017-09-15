grub-mkconfig
update-grub
ls /boot/`ls /boot -lt|head|grep initrd |cut -d":" -f2 |cut -d" " -f2|head -n 1`
echo "^c to break, anykey to contiue...";read readline

update-initramfs -u # /boot/`ls /boot -lt|head|grep initrd |cut -d":" -f2 |cut -d" " -f2|head -n 1`

grub-install /dev/sda


 modprobe dm-mod
 grub-install  --grub-setup=/bin/true --recheck --debug /dev/sda
 mkdir -p /boot/grub/locale
 cp /usr/share/locale/en@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo


grub-mkconfig -o /boot/grub/grub.cfg

echo "If grub-mkconfig fails, convert your /boot/grub/menu.lst file to /boot/grub/grub.cfg using:
# grub-menulst2cfg /boot/grub/menu.lst /boot/grub/grub.cfg
"



















