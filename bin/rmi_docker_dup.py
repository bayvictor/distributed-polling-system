#!/usr/bin/env python
import os,sys

def maketag():
  inlines0 = os.popen( 'docker images -a   ' ).readlines()
  inlines = [ ss.strip() for ss in inlines0 ]

  
  pre = inlines[0][3:8]
  for ii in range(len( inlines )):
    line = inlines[ii]
    words = line.split()
    if len(words) < 8:
      continue
    outstr = ""
    for jj in range(3,8):
      outstr += words[jj]+"+"
    if line[3:8] == pre:
      print "docker rmi -f  " + words[2] + "; # birth_tag["+str(ii)+"]=("+outstr+")  "
    else : 
      print "#we are going removing image following this line=("+line+"): with birth_tag["+str(ii)+"]=("+outstr+")  "
    pre = line[3:8]

if __name__=="__main__":
  argv=sys.argv
  maketag()


