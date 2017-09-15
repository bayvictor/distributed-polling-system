# ls -lt|head -n 25 | cut -d":" -f2| cut -d" " -f2 | sed -e '$d;s/^/backup_domain.sh /g'
echo "usage: $0 <latest_nn_diritem>"

 ls -lt|grep -ve "\.sh$"| head -n $1 | cut -d":" -f2| cut -d" " -f2 | sed -e '$d;s/^/backup_domain.sh /g'
