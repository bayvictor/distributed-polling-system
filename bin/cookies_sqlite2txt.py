#!/usr/bin/python
# -*- coding: utf-8 -*-

from collections import OrderedDict 
import sys,os
import string
import locale
import math


def make_batch_shell_for_sqlite2txt(  ):
  predir = "/home/vhuang/.mozilla/firefox/"
  outdir = "_txt_cookies" 
  modir = "/home/vhuang/.mozilla/" 

#  os.mkdir( outdir )
  os.chdir( modir )
  os.popen( "mkdir "+ outdir )
  template = "sqlite3 -separator $\'\t\' cookies.sqlite \'select CASE \"isHttpOnly\" WHEN \"0\" then \"\" else \".\" END || basedomain, CASE \"isHttpOnly\" WHEN \"0\" then \"FALSE\" else \"TRUE\" END, path, CASE \"issecure\" WHEN \"0\" then \"FALSE\" else \"TRUE\" END, expiry, name, value from moz_cookies;\' > cookies.txt "

  inlines0 = os.popen( 'find .  |grep -e "cookies.sqlite$"' ).readlines()
  inlines = [ ss.strip() for ss in inlines0 ]

  outf =  open( modir +"/batch_cookies2txt.sh",'wt')


  for ii in range(0, len(inlines)):
    print "lines["+str(ii)+ "]"
    inline = inlines[ii] 
    cmd = template.replace("cookies.sqlite",   inline )
    outline = inline.replace(".", "_").replace("/", "_" ).lstrip("__firefox").rstrip("cookies_sqlite")+"s.txt"
    outline = outline[9:]
    cmd = cmd.replace("cookies.txt",  outdir +"/" + outline )
    print "outline=("+outline+")"
    os.popen( cmd )
    outf.write( cmd +"\n")
  outf.close()

  ## out result head 10 lines
  os.popen( "cat  batch_cookies2txt.sh|head")

  os.popen( "chmod +x *.sh")


if __name__=="__main__":

  make_batch_shell_for_sqlite2txt(  )



