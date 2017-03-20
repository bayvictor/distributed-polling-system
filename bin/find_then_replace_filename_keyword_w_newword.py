#!/usr/bin/env python
import os,sys

import sys    
import termios
import fcntl

def MyGetch():
    fd = sys.stdin.fileno()

    oldterm = termios.tcgetattr(fd)
    newattr = termios.tcgetattr(fd)
    newattr[3] = newattr[3] & ~termios.ICANON & ~termios.ECHO
    termios.tcsetattr(fd, termios.TCSANOW, newattr)

    oldflags = fcntl.fcntl(fd, fcntl.F_GETFL)
    fcntl.fcntl(fd, fcntl.F_SETFL, oldflags | os.O_NONBLOCK)

    try:        
        while 1:            
            try:
                c = sys.stdin.read(1)
                break
            except IOError: pass
    finally:
        termios.tcsetattr(fd, termios.TCSAFLUSH, oldterm)
        fcntl.fcntl(fd, fcntl.F_SETFL, oldflags)


def find_keyword_in_last_sect_as_filename( keyword, replace_kw, debug = 1 ):
  list = []
  lines = os.popen( "find .  ").readlines()
  ii = 0
  for line in lines:
    trunk = line.split()[0]
    print "trunk=(" + trunk + ")"
    #    if ii %100 == 0 :
    #      print "trunk=(" + trunk + ")"
    ii = ii + 1
    words = trunk.split("/")
    last_word = words[-1]
    
    if last_word.find(keyword) != -1:
      new_last = last_word.replace(   keyword, replace_kw )
      new_trunk = 	'/'.join( word for word in words[:-1] ) + "/" +  new_last
      com = "mv "+ trunk+" " + new_trunk
      print "will do ("+ com + ")"
      print "^C to break;anykey to continue..."
      if 1 == debug:
        MyGetch()
      ret=os.system(com ) 	
      print "result of ret=os.system(\""+com+"\");ret=("+str(ret)+")"
      os.system("ls -lasth "+ new_trunk ) 
      if 1 == debug:
        MyGetch()
      
if __name__=='__main__':
  argv=sys.argv
  
  usage = """\
Usage: "+argv[0]" filename_keyword new_keyword"""
    
  if len(argv) < 3:
    print(usage)
    sys.exit(1)

  old_keyword = argv[1]
  new_keyword = argv[2]	
  
    
  find_keyword_in_last_sect_as_filename( old_keyword, new_keyword, 0)
