echo "As I learned from https://www.virtualbox.org/ticket/10085 [^] it seems shared folders on VirtualBox do not support shared links out of the box (pun to be done).
Half-official workaround is to use
"
VBoxManage setextradata ubu14045 VBoxInternal2/SharedFoldersEnableSymlinksCreate/D_DRIVE 1

