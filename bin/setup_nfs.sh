 service iptables stop
 chkconfig iptables off
 iptables -F
 iptables -L (to check if any rules exists)
 exportfs -a
 service portmap restart
 service nfs restart
chkconfig portmap on
chkconfig nfs on




