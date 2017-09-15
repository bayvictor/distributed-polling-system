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
    print "Format: "+sys.argv[0]+ " <read_from_dir> <cp_to_dir> <list_of_filter_out_grep_arguments>"
    print "e.g.: 	"+sys.argv[0]+ " /home/bsquare2/src "+ " /home/bsquare2/bin "+ "\"openssh-5\" "+ "\"crypto\/thread\" \"mipi\" \"new-yui\" "
    sys.exit(1)

read_dir = os.path.abspath(sys.argv[1])
to_dir = os.path.abspath(sys.argv[2])



# get all log filenames
tmp = os.popen('find ' + sys.argv[1]+'| grep -e \"\.sh$\"').readlines()
print "Path: " + sys.argv[1]
if len(tmp) == 0:
    print "File not found in dir\""+read_dir+"\""
    print "error"
    exit()

base = os.path.abspath(sys.argv[1])

# process logs, try to find those exceptions
count = 0
maximum = 100000
#random.shuffle(tmp)


tmp_counter = 0

for item in tmp:
    fileName = item.strip()
#    print "processing: "+ "\""+fileName+"\""
    
    # look for normal termination, by grep into file contents
    #   cmd = "cat " + base + "/" + fileName + " | grep 'NORMALLY TERMINATED'"
    #    result = os.popen(cmd).readlines()
    
    tmp_counter += 1
    
    count += 1
    if count > maximum:
        break
    out="false"
    for filter_ii in range( 3, len(sys.argv)):
        if -1 == fileName.find(sys.argv[filter_ii]): ## not be filtered
 #           print "not filtered out yet:"+fileName
            continue
        else:
            out="true"
            break     # met any filter
        
  
    ## at this point eighter broken from filter, or not any filter met 
    if out=="true":   # if hit any filter, skip item check loop processing
        continue

        ## not any filter hit

    objName = fileName.replace("/","_").replace("/"," ");
    objName = objName[len(read_dir)+1:]
    cmd = "cp  " + fileName + " " + to_dir + "/" + objName + " " 
    print "will do command (" + cmd +")"
    result=os.system(cmd)
#    print "result=(";result;")"
       
print tmp_counter


