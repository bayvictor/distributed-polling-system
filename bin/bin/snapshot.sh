#!/bin/csh

set CURDIR=${PWD}
cd /tmp


set vTIMESTAMP=`date +%m:%d:%Y:%T | sed 's/:/_/g'| sed 's/\//_/g'`

set vhost=`hostname|cut -d"." -f1`
set vprefix=${vhost}_`echo $PWD|sed "s|/|__|g"`.${vTIMESTAMP}
echo "vprefix={$vprefix}"
ps -ef > learning_sample_${vprefix}.ps.ef.txt
history > learning_sample_${vprefix}.hst.txt

cd ${CURDIR}
mkdir ../diary
mv /tmp/learning*.txt ../diary


