#!/usr/bin/env python
# ******************************************************************************
#   scan through all subdir AndroidManifest.xml files, cd that dir one by one
#     Then "android update" the environment and build apk!
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

    abs_fn =  currentdir +  fileName[1:] 
    abs_path = currentdir +  path[1:] 

#    abs_fn = os.path.abspath( fileName )
#    abs_path = os.path.abspath( path )

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

def cut_tail_if_endswith( line, tail ):
    real_projname = line
    if True == line.endswith( tail ):
      real_projname = line[:-len(tail)]
    return(real_projname)


def scandir_android_update_project( android_id, fish, do_on_fish = "android update project --path . --subprojects  --target "):

  tmp = os.popen('find . | grep -e \"AndroidManifest\.xml$\"').readlines()
  
  if len(tmp) == 0:
    print "File not found in curdir!"
    print "error"
    exit()

  currentdir = os.getcwd()
  abs_curdir = os.path.abspath(currentdir)
  tmp_counter = 0

  for item in tmp:
    fileName = item.strip()
    if True == fileName.endswith("/bin/AndroidManifest.xml"):  ## skip 
      continue
    ii       = fileName.rfind('/') + 1;
    path     = fileName[:ii]
    tmp_counter += 1
    abs_fn =  currentdir +  fileName[1:] 
    abs_path = currentdir +  path[1:] 

#    abs_fn = os.path.abspath( fileName )
#    abs_path = os.path.abspath( path )



    cur_dirname_as_project_name = abs_path.split("/")[-1]

    message = "item #["+str(tmp_counter)+"]:found  (" + abs_fn + ")!  android property-file updating in path=("+abs_path+")" 
    print "cur_dirname_as_project_name=(";cur_dirname_as_project_name;")"

    print message
    os.chdir(abs_path)
    if "bin" == cur_dirname_as_project_name:
        print "ignore AndroidManifest.xml file in dir \"./bin/\" "
        continue ## 
    real_projname = cut_tail_if_endswith(cur_dirname_as_project_name, "-read-only-master")
    real_projname = cut_tail_if_endswith(cur_dirname_as_project_name, "-read-only")
    real_projname = cut_tail_if_endswith(cur_dirname_as_project_name, "-master")


    debug_apk_lines = os.popen('find bin | grep -e \"\-debug.apk$\"').readlines()
    print "len(debug_apk_lines)=";len(debug_apk_lines)
    if len(debug_apk_lines) >=1 :  # debug.apk already be made
      print "debugged apk ("+real_projname+"-debug.apk) already exists! skipping..." 
      continue



    debug_apk = "bin/"+real_projname+"-debug.apk"
    if os.path.exists(debug_apk):
      print "debugged apk ("+real_projname+"-debug.apk) already exists! skipping..." 
      continue
 
    os.system("rm  -fr  proguard-project.txt local.properties project.properties build.xml")
    os.system("rm bin gen -fr")

    if 0 == len(cur_dirname_as_project_name):
      os.system("android update project --path . --target "+ android_id + " --subprojects ")
    else :
      os.system("android update project --path . --target "+ android_id + " --subprojects -n "+ real_projname)

    os.system("ant debug")
#    os.system("ant release")

    os.system("rm bin/AndroidManifest.xml -fr")
    os.system("rm bin/AndroidManifest.xml.d -fr")
    print "be careful to pick up the signed apk only to run under jelly bean below:"
#    os.system("find | grep -v \"debug-unaligned\" | grep -e \"\.apk$\" | xargs ls -lth ")
    print "\n-----\nWarning: release version of \""+ cur_dirname_as_project_name+"\" still unsigned!"
    print "TO-DO: No key.store and key.alias properties inserted from " + sys.argv[0] + " into build.properties, yet.\n------\n\n"
    time.sleep(8)

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

#  scandir_hunt_file_and_trigger( "pom.xml", "mvn install")
  scandir_android_update_project( android_id, "AndroidManifest\.xml")
  os.system("find | grep -v \"debug-unaligned\" | grep -e \"\.apk$\" | xargs ls -lth ")
  os.system("find | grep -v \"debug-unaligned\" | grep -e \"\.apk$\"")

#  scandir_hunt_file_and_trigger( "build\.xml", "ant release;ant debug")

