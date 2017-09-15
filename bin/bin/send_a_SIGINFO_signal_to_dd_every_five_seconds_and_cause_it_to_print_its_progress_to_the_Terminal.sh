sudo bash
while [ : ] ; do killall -SIGINFO dd && sleep 5 || exit ; done

