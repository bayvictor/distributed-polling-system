#!/usr/bin/python
# -*- coding: utf-8 -*-
#Menu system
import sys,os
import string
import re


# function to write file
def writefile(newfile, emails):
        f = open(newfilename, 'w')
        f.write(emails)
        f.close()
        print "File written."


argv=sys.argv
usage = """\
Usage: "+argv[0]" txt_filename[.txt] """

if len(argv) < 2:
	print(usage)
	sys.exit(1)


# filename variables
#filename = 'file.txt'
filename = argv[1]  #'file.txt'
newfilename = filename+'.emails.txt'

# read the file
if os.path.exists(filename):
        data = open(filename,'r')
        #bulkemails = data.read()
        lines = data.readlines()
else:
        print "File not found."
        print "usage: "+
        raise SystemExit

for line in lines:
  words = line.split('@')
  for seg in words:
    head_parts = seg.split()
      for ii in len(parts):
        email = parts

# regex = something@whatever.xxx
r = re.compile(r'( \b[\w.]+@+[\w.]+.+[\w.]\b )')
results = r.findall(bulkemails)
emails = ""
for x in results:
        emails += str(x)+"\n"

writefile( newfilename, emails )


