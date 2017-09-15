#!/bin/bash
echo "umount all remote_host mapping, ^c to break, anykey to preceed.."
read read_line

#df -h | cut -d'%' -f2 | grep strk | sed 's/^/umount /g'
umount  /strkc101
umount  /strkc102
umount  /strkc103
umount  /strkb06
umount  /strkb08
umount  /strkb09
umount  /strkb10
umount  /strkb25/project
