#!/usr/bin/env python
# ******************************************************************************
#   scan through all subdir AndroidManifest.xml files, cd that dir one by one
#     Then "android.bat update" the environment and build apk!
# ******************************************************************************

import os
import sys
import time
import random

# Check command format

def scandir_hunt_file_and_trigger( fish, do_on_fish="ant release;ant debug"): 

  tmp = os.popen('find . | grep -e \"'+fish+'$\"').readlines()
  
  if len(tmp) == 0:
    print "File not found in curdir!"
    print "error"
    exit()

  currentdir = os.getcwd()
  abs_curdir = os.path.abspath(currentdir)
  tmp_counter = 0
  print "curdir=("+abs_curdir+")"


  for item in tmp:
    fileName = item.strip()
    ii       = fileName.rfind('/') + 1;
    path     = fileName[:ii]
    tmp_counter += 1

    abs_fn = os.path.abspath( fileName )
    abs_path = os.path.abspath( path )
    message = "item #["+str(tmp_counter)+"]:found  (" + abs_fn + ")!  android property-file updating in path=("+abs_path+")" 
    print message

    os.chdir(abs_path)
    os.system( do_on_fish )


    print "be careful to pick up the signed apk only to run under jelly bean below:"
    os.system("find | grep -v \"debug-unaligned\" | grep -e \"\.apk$\"")
    os.chdir(abs_curdir )    



#    print "result=(";result;")"
       
  print str(tmp_counter)+ "AndroidManifest.xml files processed!"
  print "be careful to pick up the signed apk only to run under jelly bean below!!!"
  print "total apk:"

  os.system("find | grep -v \"debug-unaligned\" | grep -e \"\.apk$\"")



def scandir_android_update_project( android_id, fish, do_on_fish = "android.bat update project --path . --subprojects  --target "):

  tmp = os.popen('find . | grep -e \"AndroidManifest\.xml$\" | grep -ve \"bin/AndroidManifest\.xml$\" ').readlines()
  
  if len(tmp) == 0:
    print "File not found in curdir!"
    print "error"
    exit()

  currentdir = os.getcwd()
  abs_curdir = os.path.abspath(currentdir)
  tmp_counter = 0

  for item in tmp:
    fileName = item.strip()
    ii       = fileName.rfind('/') + 1;
    path     = fileName[:ii]
    tmp_counter += 1

    abs_fn = os.path.abspath( fileName )
    abs_path = os.path.abspath( path )
    message = "item #["+str(tmp_counter)+"]:found  (" + abs_fn + ")!  android property-file updating in path=("+abs_path+")" 

    print message
    os.chdir(abs_path)
    os.system("android.bat update project --path . --target "+ android_id + " --subprojects")
#    os.system("ant debug")
#    os.system("ant release")
#    print "be careful to pick up the signed apk only to run under jelly bean below:"
#    os.system("find | grep -v \"debug-unaligned\" | grep -e \"\.apk$\"")
    os.chdir( abs_curdir )    
#    print "result=(";result;")"
       
#  print str(tmp_counter)+ "AndroidManifest.xml files processed!"
#  print "be careful to pick up the signed apk only to run under jelly bean below!!!"
#  print "total apk:"

#  os.system("find | grep -v \"debug-unaligned\" | grep -e \"\.apk$\"")
#

if __name__=="__main__":

  if len(sys.argv) < 2: 
    #    print "Format: ./filter.py read_dir testcase_dir dest_testcase_dir [report_dir dest_report_dir]"
    print "Format: "+sys.argv[0]+ " <android_id> <cp_to_dir> <list_of_filter_out_grep_arguments>"
    print "e.g.: 	"+sys.argv[0]+ " android-17 "
    sys.exit(1)

  android_id = sys.argv[1]
  
  scandir_android_update_project( android_id, "AndroidManifest\.xml")
  scandir_hunt_file_and_trigger( "build\.xml", "ant release;ant debug")

