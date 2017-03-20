#!/bin/bash

# use manual mounting instead of putting them in fstab,
# where a small error can resulting a whole system disaster -- shuting down or unusable

sudo mount -t ext4 	/dev/sda2	 /sda2
sudo mount -t swap 	/dev/sda3	 /sda3
sudo mount -t ext4 	/dev/sda5	 /sda5
sudo mount -t swap 	/dev/sda6	 /sda6
sudo mount -t ext4 	/dev/sda7	 /sda7
sudo mount -t ext4 	/dev/sda8	 /sda8
sudo mount -t ext4 	/dev/sda9	 /sda9
sudo mount -t ext4 	/dev/sda10	 /sda10
sudo mount -t ext2 	/dev/sdb2	 /sdb2
sudo mount -t ext4 	/dev/sdb3	 /sdb3
sudo mount -t ext4 	/dev/sdd2	 /sdd2
sudo mount -t ext4 	/dev/sdc1	 /sdc1
sudo mount -t ext4 	/dev/sde1	 /sde1
sudo mount -t ext4 	/dev/sdf2	 /sdf2
sudo mount -t swap 	/dev/sdf3	 /sdf3
sudo mount -t ext4 	/dev/sdg1	 /sdg1
sudo mount -t ext4 	/dev/sdh1	 /sdh1
sudo mount -t ext4 	/dev/sdi1	 /sdi1
sudo mount -t ext4 	/dev/sdj1	 /sdj1

# above we still leave out the two 2Duo 4T disks, which is noisy.
# will use blkid later to add them !

