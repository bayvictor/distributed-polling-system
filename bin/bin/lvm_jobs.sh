echo "run as root!"


echo "^C to break, anykey to continue...";read readline
umount /dev/sde1
umount /dev/sdb1
umount /dev/sdc1
umount /dev/sdf2
pvcreate /dev/sde1
pvcreate /dev/sdb1
pvcreate /dev/sdc1
pvcreate /dev/sdf2
vgcreate matrix /dev/sde1 /dev/sdb1 /dev/sdc1 /dev/sdf2

pvdisplay

sudo apt-get install -y  kpartx
file -Ls /dev/matrix/petadisk 
kpartx -av /dev/matrix/petadisk 


echo "^C to break, anykey to continue...";read readline
echo "
samples:
sudo lvcreate -n bar -L 5g foo 

This creates a Logical Volume named bar in Volume Group foo using 5 GB of space. If you are installing, you probably want to create a Logical Volume like this to use as a root filesystem, and one for swap, and maybe one for /home. I currently have a Logical Volume for a Lucid install, and one for a Maverick install, so that is what I named those volumes. You can find the block device for this Logical Volume in '/dev/foo/bar' or 'dev/mapper/foo-bar'.

You might also want to try the lvs and pvs commands, which list the Logical Volumes and Physical Volumes respectively, and their more detailed variants; lvdisplay and pvdisplay.

If you are doing this from the desktop livecd, once you have created your Logical Volumes from the terminal, you can run the installer, and use manual partitioning to select how to use each Logical Volume, and then install.

Resizing Partitions
You can extend a Logical Volume with:

 sudo lvextend -L +5g foo/bar 

This will add 5 GB to the bar Logical Volume in the foo Volume Group. You can specify an absolute size if you want instead of a relative size by omitting the leading +. The space is allocated from any free space anywhere in the bar Volume Group. If you have multiple Physical Volumes you can add the names of one or more of them to the end of the command to limit which ones should be used to satisfy the request.

After extending the Logical Volume you need to expand the filesystem to use the new space. For ext 3/4, you simply run:

 sudo resize2fs /dev/foo/bar 

Moving Partitions
If you only have one Physical Volume then you probably will not ever need to move, but if you add a new disk, you might want to. To move the Logical Volume bar off of Physical Volume /dev/sda1, you run:

 sudo pvmove -n bar /dev/sda1 

If you omit the -n bar argument, then all Logical Volumes on the /dev/sda1 Physical Volume will be moved. If you only have one other Physical Volume, then that is where it will be moved to, or you can add the name of one or more specific Physical Volumes that should be used to satisfy the request, instead of any Physical Volume in the Volume Group with free space. This process can be resumed safely if interrupted by a crash or power failure, and can be done while the Logical Volume(s) in question are in use. You can also add -b to perform the move in the background and return immediately, or -i s to have it print how much progress it has made every s seconds. If you background the move, you can check its progress with the lvs command.

Snapshots
When you create a snapshot, you create a new Logical Volume to act as a clone of the original Logical Volume. The snapshot volume initially does not use any space, but as changes are made to the original volume, the changed blocks are copied to the snapshot volume before they are changed, in order to preserve them. This means that the more changes you make to the origin, the more space the snapshot needs. If the snapshot volume uses all of the space allocated to it, then the snapshot is broken and can not be used any more, leaving you only with the modified origin. The lvs command will tell you how much space has been used in a snapshot Logical Volume. If it starts to get full, you might want to extend it with the lvextend command. To create a snapshot of the bar Logical Volume and name it snap, run:

 sudo lvcreate -s -n snap -L 5g foo/bar 

This will create a snapshot named snap of the original Logical Volume bar and allocate 5 GB of space for it. Since the snapshot volume only stores the ares of the disk that have changed since it was created, it can be much smaller than the original volume. I recently used a 5 GB snapshot of a 12 GB Logical Volume holding my Maverick root filesystem and ran an dist-upgrade to Natty on the origin, which only used about 50-60% of the snapshot space.

While you have the snapshot, you can mount it if you wish and will see the original filesystem as it appeared when you made the snapshot. In the above example you would mount the /dev/foo/snap device. You can modify the snapshot without affecting the original, and the original without affecting the snapshot. If you take a snapshot of your root Logical Volume, and then upgrade some packages, or to the next whole distribution release, and then decide it isn't working out, you can merge the snapshot back into the origin volume, effectively reverting to the state at the time you made the snapshot. To do this, you simply run:

 sudo lvconvert --merge foo/snap 

IconsPage/info.png
Note that this requires a more recent version of LVM than ships with Maverick. You can get one from my ppa by running sudo apt-add-repository ppa:psusi/ppa then installing/upgrading the lvm2 package.
If the origin volume of foo/snap is in use, it will inform you that the merge will take place the next time the volumes are activated. If this is the root volume, then you will need to reboot for this to happen. At the next boot, the volume will be activated and the merge will begin in the background, so your system will boot up as if you had never made the changes since the snapshot was created, and the actual data movement will take place in the background while you work.

Lvm (last edited 2012-11-09 12:27:29 by flimm)

"




 
