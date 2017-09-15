#!/usr/bin/env python
import os
import sys
import string

p = os.popen('find . -type f |sed \'s/\.\/\.//g\' ' , 'r')
lines = p.readlines()
p.close()



for jj in range(0, len(lines)):
  line=lines[jj].split("\n")[0]
  new_line = ''.join( ch if ch.isalnum() else '_' for ch in line )
  words = new_line.split("_")
  new_line2 = '_'.join( word for word in words[:-1] ) + "." + words[-1]
  os.system("mv "+ "\"" + line+"\" "+ new_line2 + " " )

	
