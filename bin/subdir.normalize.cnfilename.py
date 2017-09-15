#!/usr/bin/env python
import os
import sys
import string

# we put all chars which will be replace with "_" in filename
stop_strings = " ()[]{}\"\'#<>$%!&*?/:\\@"
p = os.popen('find . -type f ' , 'r')
#p = os.popen('find . -type f |sed \'s/\.\/\.//g\' ' , 'r')
lines = p.readlines()
p.close()



os.system("find . ")
for jj in range(0, len(lines)):
  line0 = lines[jj].split("\n")[0]
  line_len = len(line0)
  print "line0=("+line0+")"
  blank_ii = 0

  for blank_ii in range(0,len(line0)):
    if not line0[blank_ii] in "./":
        break
  print "blank_ii="+str(blank_ii)
  line=line0[blank_ii:]  
  new_line = ''.join( ch if not(ch in stop_strings) else '_' for ch in line )
  words = new_line.split("_")
  new_line2 = '_'.join( word for word in words[:-1] ) + "." + words[-1]
  if new_line2[0] == '.':
    new_line2 = new_line2[1:]
  for kk in range(0, line_len):
    if -1 == new_line2.find("___"):
      break
    else:
      new_line2 = new_line2.replace("___","__")
  os.system("mv "+ "\"" + line0+"\" "+ new_line2 + " " )

	
