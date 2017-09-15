
#fixing: scratchbox err: tset: unknown terminal type xterm

sudo mkdir -p /usr/share/terminfo/x
cd /usr/share/terminfo/x
sudo ln -s /lib/terminfo/x/xterm xterm


sudo su
echo "vm.mmap_min_addr = 0" >> /etc/sysctl.conf
sysctl -p
exit #to go back to user


