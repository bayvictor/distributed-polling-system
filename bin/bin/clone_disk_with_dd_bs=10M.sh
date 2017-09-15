echo " dd if=/dev/ad0 of=/dev/ad1 bs=1M "
echo "your destined drive /dev/sdap1 will be destroyed & cloned by /dev/sdb!!!!!"
echo "we will do: \"sudo dd if=/dev/sdb of=/dev/sdap bs=10M \"!!!"
echo "^C to break, anykey to contiue...";read readline
echo "it will take a long time, using kill -9 to see the progress!
& pid=$!
kill -USR1 #pid=$! 
kill -USR1 $pid; ~/bin/timestamp 

"
echo "we start at timestamp="
~/bin/timestamp

sudo dd if=/dev/sdb of=/dev/sdap bs=10M  #pid=$!

kill -USR1 $pid; ~/bin/timestamp 

