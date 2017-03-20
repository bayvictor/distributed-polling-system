#!/bin/bash -x 
echo "android download number=(1244)?"
unset readline
read readline
python -c "for x in xrange(0,"${readline}"):print x" |sed 's|^|<a href="http://download.cnet.com/android/most-popular/3101-20_4-0-|g;s|$|.html\?rpp=100">1</a>|g'>android_down.html

echo "manually set every line export to get start!"; read readpause 

echo "ios download number=(96291)?"
unset readline02
#read readline02
export readline02="190583"

echo "mac download number=(241)?"
unset readline03
#read readline03 
export readline03="16619"
echo "windows download number=(2214)?"
unset readline04
#read readline04
export readline04="35744"

echo "web download number=(73)?"
unset readline05
#read  readline05
export readline05="15006"

unset readline06 
unset readline07 
export readline06="15560" #other mobile like symbian
export readline07="14563" #linux

echo "^C to break, any key to continue...."; read readpause 

python -c "for x in xrange(0,"${readline02}"):print x" |sed 's|^|<a href="http://download.cnet.com/ios/\?sort=most-popular\&page=|g;s|$|">1</a>|g'>ios_down.html

python -c "for x in xrange(0,"${readline03}"):print x" |sed 's|^|<a href="http://download.cnet.com/mac/most-popular/3101-20_4-0-|g;s|$|.html\?rpp=100">1</a>|g'>mac_down.html

python -c "for x in xrange(0,"${readline04}"):print x" |sed 's|^|<a href="http://download.cnet.com/windows/most-popular/3101-20_4-0-|g;s|$|.html\?rpp=100">1</a>|g'>windows_down.html
python -c "for x in xrange(0,"${readline05}"):print x" |sed 's|^|<a href="http://download.cnet.com/webware/most-popular/3101-20_4-0-|g;s|$|.html\?rpp=100">1</a>|g'>webware_down.html



python -c "for x in xrange(0,"${readline06}"):print x" |sed 's|^|<a href="http://download.cnet.com/mobile/most-popular/3101-20_4-0-|g;s|$|.html\?rpp=100">1</a>|g'>mobile_down.html
:
python -c "for x in xrange(0,"${readline07}"):print x" |sed 's|^|<a href="http://download.cnet.com/linux/most-popular/3101-20_4-0-|g;s|$|.html\?rpp=100">1</a>|g'>linux_down.html


firefox ios_down.html &
echo "firefox android_down.html &

firefox webware_down.html &
firefox mac_down.html &

firefox windows_down.html &
firefox mobile_down.html &
firefox linux_down.html &
"
