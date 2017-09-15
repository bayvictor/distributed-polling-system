#!/usr/bin/env python
import re
import sys
import os
"""
it scan all files under current directory (may be sudir of subdirs of current dir), within which
 extract out proxy ip like(213.241.204.26:3128), and "sort -u" & write to ../proxylist.txt.srt!
"""
#inlines0 = os.popen( "find . -type f -print0 | while IFS= read -r -d '' filename; do echo ${filename}; done" ).readlines()

inlines0 = os.popen( "find . " ).readlines()

inlines = [ ss.strip() for ss in inlines0 ]

outf =  open( "../proxylist.txt",'wt')


for ii in range(0, len(inlines)):
  print "lines["+str(ii)+ "]"
  inline = inlines[ii] 
  data = os.popen( "cat " + inline ).read()
  ipPattern = re.compile('\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}[\:\s\s*]\d{1,5}')
  
  findIP = re.findall(ipPattern, data )
  print ("found ip=({})".format ( findIP ) )
  for match in findIP:
    outf.write(match+"\n")


outf.close()    
os.popen( "sort -u ../proxylist.txt > ../proxylist.txt.srt" )
proxy_num = os.popen( "cat  ../proxylist.txt.srt|wc -l" ).readlines()[0]
print ("total unique {} proxylist items generated in file  ../proxylist.txt.srt ".format (proxy_num) )
