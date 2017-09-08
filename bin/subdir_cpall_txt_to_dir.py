#!/usr/bin/python
# ******************************************************************************
#
# Filter: filter any testcases that cause a "ComponentNotFound" or
#         "ComponentDisabled" Exception.
# ******************************************************************************

import os
import sys
import time
import random

# Check command format


if len(sys.argv) < 4: 
#    print "Format: ./filter.py read_dir testcase_dir dest_testcase_dir [report_dir dest_report_dir]"
    print "Format: "+sys.argv[0]+ " <read_from_dir> <cp_to_dir> <filename_ext>"
    print "e.g.: 	"+sys.argv[0]+ " ~/Documents/201703-jobs/debug_downed_resume  " + " ../pdf2txt "+ "txt "
    sys.exit(1)

read_dir = os.path.abspath(sys.argv[1])
to_dir = os.path.abspath(sys.argv[2])



# get all log filenames
cmd = 'find ' + sys.argv[1] + '| grep -e \"\.' + sys.argv[3] + '$\"'
print ( "cmd=(" + cmd +")" )
tmp = os.popen( cmd ).readlines()
print "Path: " + sys.argv[1]
if len(tmp) == 0:
    print "File not found in dir\""+read_dir+"\""
    print "error"
    exit(1)

base = os.path.abspath(sys.argv[1])

# process logs, try to find those exceptions
count = 0
maximum = 10000000
#random.shuffle(tmp)


tmp_counter = 0
print ("%s lines read." % len(tmp) )

for item in tmp:
    fileName = item.strip()
   
    tmp_counter += 1
    
    count += 1
    #if count > maximum:
    #    break
    objName = fileName.replace("/","_").replace("/"," ");
    objName = objName[len(read_dir)+1:]
    cmd = "cp  " + fileName + " " + to_dir + "/" + objName + " " 
    print "will do command (" + cmd +")"
    result=os.system(cmd)
#    print "result=(";result;")"
       
print (" go over %d items" % tmp_counter )


