#!/bin/bash

mkdir ~/victor_saved_logs
echo "$0 <dirname> \"<comments-can-have-spaces>\""
echo "^C to break, any other key to proceed..."
#read readline

mid=`echo "$1"| sed 's|[^0-9a-zA-Z]|_|g'   `
mid2=`echo "$2"| sed 's|[^0-9a-zA-Z]|_|g'   `
echo "mid=$mid"
echo "mid2=$mid2"
tar -zcf ~/victor_saved_logs/`hostname`_${mid}_${mid2}_`timestamp`.tgz $1

