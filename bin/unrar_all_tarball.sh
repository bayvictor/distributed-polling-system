#/usr/bin/bash
echo "usage:$0 <dir_has_rar__tocurdir>"
echo "^c to break, anykey to proceed..."
read  readline
find $1 -type f -name '*.rar' -exec unrar x {} \;
