
echo "we are going to make dirs \"$1\""
echo "^C to break, anykey to continue...."
read  readline
mkdir $1
ls $1
cd $1

echo "we are going to flash ROMs to diR \"$1\""
echo "^C to break, anykey to continue...."
read  readline
    fastboot flash userdata data.img 
    fastboot flash system system.img 
    fastboot flash boot boot.img 
    fastboot reboot 
echo "we now have all files under  diR \"$1\""
ls -ltah

