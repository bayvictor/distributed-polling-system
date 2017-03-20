#!/usr/bin/python
# -*- coding: utf-8 -*-
#Menu system
import sys,os
import string
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
#	list=os.popen("for i in `cat "+cvs_filename+" | head -n "+head_lines+"|cut -d\",\" -f1|sed \"s/"+keyword+"//g\"`;do echo $i ;done").read().strip().split('\n')
#	cmdline = "`cat "+cvs_filename+" | head -n "+head_lines+"|cut -d\",\" -f1|sed \"s/"+argv[3]+"//g\"`"
#	list=os.popen(cmdline)

	lines = open(cvs_filename,'r').read().strip().split('\n')
#	for line in ff:
	for ii in range(0, int(head_lines)):
		print string.replace(lines[ii],keyword,'').strip()
