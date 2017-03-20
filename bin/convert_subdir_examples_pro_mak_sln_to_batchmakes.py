#!/usr/bin/python

import os, sys
os.popen("export QTDIR=$PWD")
os.popen("export PATH=${QTDIR}/bin:$PATH")
os.popen("export QMAKESPEC=${QTDIR}/bin/mkspec/win32-g++")

os.popen("mkdir batchmakes")
os.popen("cd batchmakes")
kk=os.popen('find .. | grep -e "\\bexample"|grep -e "\.pro$" ' ).readlines()
print "len(kk)=(";len(kk);")"
for f in kk:
	print "line=("+f+")"
	f = f.rstrip()
	tobase = os.popen('norm.sh ' +  f + '| sed "s/\.\._//g"').readlines()[0];
	com1="qtbase/bin/qmake "+f+" -o "+tobase+" .mak" 
	com2="qtbase/bin/qmake -spec win32-msvc2010 -t vc "+f+" -o batchmakes\/"+tobase+" .mak"
	print "com1=(";com1;")"
	print "com2=(";com2;")"
        os.popen(com1)
        os.popen(com2)
	


