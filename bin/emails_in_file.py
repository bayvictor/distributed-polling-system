#!/usr/bin/python
# -*- coding: utf-8 -*-
#Menu system
import sys,os
import string
import re

if __name__=="__main__":
	argv=sys.argv
	usage = """\
Usage: "+argv[0]" cvs_filename[.csv] head_lines keyword"""

	if len(argv) < 4:
		print(usage)
		sys.exit(1)

	cvs_filename = argv[1]
	head_lines = argv[2]
	keyword = argv[3]	
	print"cvs_filename,lines,keyword =(";
	print cvs_filename;
	print head_lines;
	print keyword;
	print")"

	lines = open(cvs_filename,'r').read().strip().split('\n')
 
	for ii in range(0, int(head_lines)):
		print string.replace(lines[ii],keyword,'').strip()



# filename variables
#filename = 'file.txt'
filename = argv[1]  #'file.txt'
newfilename = filename+'.emails.txt'

# read the file
if os.path.exists(filename):
        data = open(filename,'r')
        bulkemails = data.read()
else:
        print "File not found."
        raise SystemExit

# regex = something@whatever.xxx
r = re.compile(r'(\b[\w.]+@+[\w.]+.+[\w.]\b)')
results = r.findall(bulkemails)
emails = ""
for x in results:
        emails += str(x)+"\n"

# function to write file
def writefile():
        f = open(newfilename, 'w')
        f.write(emails)
        f.close()
        print "File written."


