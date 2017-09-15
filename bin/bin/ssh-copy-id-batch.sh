echo "usage: $0 <user> <hostname"
echo "e.g.:   $0 vhuang 127.0.0.1 "
echo "^C to break, anykey to continue...";read readline
user=$1
hostname=$2
cat ~/.ssh/id_rsa.pub | ssh ${user}@${hostname} 'umask 0077; mkdir -p .ssh; cat >> .ssh/authorized_keys && echo "Key copied"'


