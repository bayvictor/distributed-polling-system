echo "
  export partition=/dev/sda11
 export device=/dev/sda
 mount $partition /mnt/radicula
 df -h
 grub-install --root-directory=/mnt/radicula $device

"
echo "^C to break, anykey to run....";read readline

  export partition=/dev/sda11
 export device=/dev/sda
 mount $partition /mnt/radicula
 df -h 
 grub-install --root-directory=/mnt/radicula $device


