#!/usr/bin/python
# -*- coding: utf-8 -*-
#Menu system
"""
input: id.txt firefox profile.ini(path)
output: username within email in id.txt file be added to firefox profile
  cloned with firefox default!
  so later it can be called from command-line by:
firefox -no-remote -P secondprofilename

to do: wget --load-cookies + login to update cookies in real-time!  ...
"""


import sys,os
import string
import random
import re

## tested OK! with given example....   
def get_last_profile_number( profile_filename ):
  found = False

  lines = open( profile_filename,'rt').read().strip().split('\n')
  for ii in range( 1, len(lines)):
    line =  lines[-ii]  ## note: find from bottom up, in order to get last line...
    if -1 == line.find("[Profile"):
      continue

    # found now!
    found = True
    pos = line.find("[Profile") + len ("[Profile")
    seg = line[pos:]
    num = string.atoi ( seg.split(']')[0], 10 )
    print "max existing profilenum=("+str(num)+")"
    break

  if False == found:
    print "No [Profile..] found in file ("+profile_filename+")!"
    return(0)
  return( num )
  
def   create_profile_ini( prof_fn, hash_dir_lines, dir_lines ):
  outf =  open(prof_fn, 'wt')
  outf.write("[General]\n");
  outf.write("StartWithLastProfile=1\n\n");

  out_seg = "\n[Profile0]\nName=default\nIsRelative=1\n"
  test_seg = "Path=" + hash_dir_lines[dir_lines.index("Isacaus")] + "\n\n"

  out_seg += "Path=" + hash_dir_lines[dir_lines.index("default")] + "\n\n"
  print "inserting ("+out_seg+ ") into filename=(" + prof_fn + ")..."	
  outf.write( out_seg );

  email_num = 1


  for ii in range(0, len(dir_lines)):
      if "default" == 	dir_lines[ii]:
	print "skipping default ....."
        continue
      if " " in dir_lines[ii]:
	continue
      if -1 == hash_dir_lines[ii].find("."):  # no "." in dirname, error!
	continue
      if 0== len( dir_lines[ii] ):
	continue

      out_seg = "\n[Profile"+str(  email_num  ) + "]\nName="+dir_lines[ii]+"\nIsRelative=1\n"
      out_seg += "Path=" + hash_dir_lines[ii] + "\n\n"
      print "inserting ("+out_seg+ ") into filename=(" + prof_fn + ")..."	
      outf.write( out_seg );
      email_num += 1

  outf.close()

if __name__=="__main__":
  argv=sys.argv
  usage = """\
    Usage: "+argv[0]" txt_filename[.txt] firefox_profilepath
    e.g.:  "+argv[0]" idlist.txt /home/vhuang/.mozilla/firefox/profiles.ini
   """
#  profile_filename = "~/.mozilla/firefox/profiles.ini"
  
  if len(argv) < 3:
		print(usage)
		sys.exit(1)
  prof_fn = argv[2]
    
  cvs_filename = argv[1]
  os.popen('tree ~/.mozilla/firefox -d -L 1|grep -v "Crash\ Report" |grep -v "├── _" > alldir.txt ');
  hash_dir_lines0 = os.popen('cat alldir.txt |cut -d" " -f2 | sed "1d"|sed \'$d\'|sed \'$d\' ' ).readlines()
  dir_lines0 = os.popen('cat alldir.txt |cut -d"." -f2 | sed "1d"|sed \'$d\'|sed \'$d\' ' ).readlines()

  #hash_dir_lines0 = os.popen('tree ~/.mozilla/firefox -d -L 1|grep -v " "|cut -d" " -f2').readlines()
  #dir_lines0 = os.popen('tree ~/.mozilla/firefox -d -L 1|cut -d"." -f2').readlines()

  ## strip out the last '\n' at the end of the lines in both lists:
  hash_dir_lines = [ ss.strip() for ss in hash_dir_lines0 ]
  dir_lines = [ ss.strip() for ss in dir_lines0 ]

  print hash_dir_lines
  print dir_lines

  create_profile_ini( prof_fn, hash_dir_lines, dir_lines ) ## map existing hash.dir to 
                                                           ## newly created profile.ini  
  outf =  open(prof_fn, 'a+') ## append to the ini end after mapping existing dirs
  email_num = 0
  start_new_prof_num =  get_last_profile_number(  prof_fn )

  lines = open(cvs_filename,'rt').read().strip().split('\n')

  #	for line in ff:
  for ii in range(0, len(lines)):
    hash_str = ''.join(random.choice('0123456789abcdefghijklmnopqrstuvwxyz') for i in range(8))
    line = lines[ii].strip()
    if len(line) == 0:
      continue
    if '#' == line[0]:
      continue  #comment line
    if -1 == lines[ii].find('@'):
      continue
    at_left = lines[ii].split("@")[0]
    if -1 != at_left.find(' '):
      username = at_left.split(" ")[-1] #get "huangxd" from "huangxd@yahoo.com"
    else:
      username = at_left.split("\x09")[-1]  #tab



    new_dir = "~/.mozilla/firefox/"+hash_str+ "."+ username

    out_seg = "\n[Profile"+str(  start_new_prof_num + email_num  ) + "]\nName="+username+"\nIsRelative=1\n"
    if username not in dir_lines: # clone only for non-existing profile
      out_seg += "Path=" +hash_str+ "."+ username + "\n\n"
      print "creating new: "+out_seg
      email_num += 1
    else:
      out_seg += "Path=" + hash_dir_lines[dir_lines.index( username )] + "\n\n"
      print "dir ("+out_seg+") exists! skipping cloning default to it..."
      continue   # not writing in case of existing already...

    outf.write( out_seg );
    print "newdir=("+new_dir+")"   
    print "profile item_added=("+out_seg+")"   
    #   os.mkdir(new_dir)

 
    if username not in dir_lines: # clone only for non-existing profile
      ret =   os.popen( "cp -fr ~/.mozilla/firefox/*.default "+ new_dir )
    else: 
      continue   # if dir exist, skip clone dir to profile


  outf.close() ## close it after loop



 
