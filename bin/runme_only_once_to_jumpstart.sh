sudo echo "-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT " >> /etc/sysconfig/iptables
sudo echo "-A INPUT -m state --state NEW -m tcp -p tcp --dport 20 -j ACCEPT " >> /etc/sysconfig/iptables
sudo echo "COMMIT \n" >> /etc/sysconfig/iptables

echo "^C to break, anykey to conitnue..."; read readline



