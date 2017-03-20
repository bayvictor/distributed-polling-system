#!/usr/bin/env python

"""
open source domain lisensed in MIT, by Victor X.D. Huang, bayvictor@gmail.com
simple a few line filename fixxing for ilegal characters for all subdirs.
run under proxy-style environment like cywin,mingw, linux, mac etc.
"""

import os
import sys
import string

def cp_downthemall_filename_to_newdir_with_shorten_name():
  # ls|tr '\t' '\n'
  #p = os.popen('find . -type f |sed \'s/\.\/\.//g\' ' , 'r')
  p = os.popen("ls|tr '\t' '\n' " , "r")
  lines = p.readlines()
  p.close()

  new_directory_name = "subdir_shorten_fn"
  if not os.path.exists(new_directory_name):
    os.makedirs(new_directory_name)

  for jj in range(0, len(lines)):
    line=lines[jj].split("\n")[0]
    if -1 == line.find('.'):
      continue	
    if -1 == line.find('_'):
      continue	
    segs = line.split(".")
    words = line.split("_")
    new_line2 = words[0] + "_" + words[1] + "." + segs[-1]
    #print "copy...(" + line + ") => {" + new_directory_name+"/"+ new_line2 + "}"
    os.system("cp "+ "\"" + line+"\" " + new_directory_name+"/"+ new_line2 + " " )

if __name__=="__main__":
  cp_downthemall_filename_to_newdir_with_shorten_name()


	
