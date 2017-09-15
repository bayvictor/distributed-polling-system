sudo apt-get install -y gddrescue

echo "
To clone the disk at /dev/sdb onto the one at /dev/sda with maximal chance of error recovery, you'd use
ddrescue --direct --max-retries=10 /dev/sdb /dev/sda sdb.log
Before doing this, make sure /dev/sdb really is your source disk - ddrescue will happily copy a blank drive over the top of your data if you ask it to.
"

