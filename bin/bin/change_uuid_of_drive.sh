echo "usage: $0 <drive>"
echo "e.g.: $0 /dev/sda17"
echo "^C to break, anykey to continue";read readline
unset uuid
export uuid=`uuidgen`
echo "old uuid of drive "+$1+":"
df -h|grep $1
#sudo tune2fs /dev/sde5 -U $uuid
sudo tune2fs $1 -U $uuid

echo "new uuid of drive "+$1+":"
df -h|grep $1


