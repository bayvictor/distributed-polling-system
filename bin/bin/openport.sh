#iptables -A INPUT -p tcp -d 0/0 -s 0/0 --dport (replaced with my port) -j ACCEPT

iptables -A INPUT -p tcp -d 0/0 -s 0/0 --dport $1 -j ACCEPT


