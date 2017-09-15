echo "usage: $0 <device>     ...  changing the uuid for any harddrive .."
echo "e.g.: $0 /dev/sda7"
echo "press any key to do $0 $1, ^C to break"
read readline

uuidgen | xargs tune2fs $1 -U


