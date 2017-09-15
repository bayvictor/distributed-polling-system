#!/usr/bin/env python2.6
import os
import sys
import string

def get_github_page_step2(keyword,per4s="20",per1s="15", random_s="30", tarball_num="1000"):
  # -- download the github search hit link, output name to 
  down_fn = keyword+"1.html"
  for jj in range(2, 2+int(tarball_num)/10):
    cmd3="wget -U \"\" -w "+random_s + " --random-wait   \"https://github.com/search?p="+str(jj)+"&q="+keyword
    down_fn = keyword+str(jj)+".html"
    down_fn_1 = keyword+str(jj-1)+".html"
    cmd3 +="&ref=searchresults&type=Repositories\" -O \"" + down_fn + "\";sleep "+str(per1s)+";"
    if jj %4 == 0 :
      cmd3 +="sleep "+str(per4s)+";"
    parse_link(keyword,down_fn_1, "1" , "1", "3", tarball_num, 1, 1 )  # this downloading ok!
    os.system( cmd3 ) # download link_jj to filename in down_fn, buggy? not actual downloading

  parse_link(keyword,down_fn, per4s , per1s, random_s, tarball_num, 1, 1 )

"""
write_parsed_link==1: can be called to generate the parsed result
really_download==0: without actually download it
"""
def parse_link(keyword,link,per4s="1",per1s="1", random_s="5", tarball_num="1000",really_download=0, write_parsed_link=1):
  cmd4 ="  cat "+ link + "|  grep -e \"stargazers\" | cut -d'\"' -f2|grep -ve \"^stargazer\" | sed -e 's|^|https://github.com/|g;s|/stargazers$|/archive/master.zip|g'"
  p4 = os.popen( cmd4 )
  lines = p4.readlines()
  fn_out =  link+".parsed.html"
  if 0 != write_parsed_link:
    fout=open( fn_out, "w")
  for kk in range(0, len(lines) ):
    new_fn = os.popen( "norm.sh "+ lines[kk] ).readlines()[0].strip()
    if new_fn[-1] == '_':
      new_fn = new_fn[:-1]
    if 0 != write_parsed_link:
      fout.write( lines[kk] )
    cmd3="wget -U \"\"   --waitretry=120 -c  -w "+random_s +" --random-wait   \""+lines[kk].strip()+"\" -O \"" + new_fn + "\";sleep "+str(per1s)+";"
    if kk %4 == 0 :
      cmd3 +="sleep "+str(per4s)+";"
    if 1==really_download:
      os.popen( cmd3 )

  if 0 != write_parsed_link:
    fout.close()
#   write_parsed_link:

"""
Download first page, parse hit result number into tarball_num.
"""
def get_github_page0(keyword,per4s="20",per1s="15", random_s="30" ):
  # -- get page0 for keyword, 
  curdir=os.getcwd()
#  try:
#    os.mkdir( keyword+"_pages" )
#  except OSError,err:
#    if err.errno!=17:
#        raise
#  os.chdir(keyword+"_pages")

  fn0 = keyword+"1.html"
  cmd="wget -U \"\" -w 3  --random-wait   \"https://github.com/search?q="+keyword
  cmd +="&ref=searchresults&type=Repositories\" -O \"" + fn0 + "\""
  print "cmd=("+cmd+")"
  p = os.popen( cmd )
  p.close()
  cmd2 = "cat "+fn0 + " |grep -e \"We.ve found [0-9]*.*[0-9] repository results\" |sed \"s/found/@/g;s/ repository results/@/g\" |cut -d\"@\" -f2 "
  print "cmd2=("+cmd2+")"
  # -- parse pape_num from page0  
  p2 = os.popen( cmd2 )
  try:
    tarball_num = p2.readlines()[0]
  except:
    tarball_num = "1"
  tarball_num = tarball_num.replace(",","").strip()
  if int(tarball_num) > 1000:
    tarball_num="1000"  #github max allowed tarball_num
  print "parsed zipfile_num=("+tarball_num+")"
  print "parsed pagenum=("+str(1+int(tarball_num)/10)+")"
  p2.close()
  #parse_link(keyword,fn0, per4s , per1s, random_s, tarball_num, 1, 1 )

  # -- put all url page-links in one file named in fn_out
  fn_out =  keyword+"_pages_01-to-"+str(1+int(tarball_num)/10)+".html"
  fout=open( fn_out, "w")
  for jj in range(2, 2+int(tarball_num)/10):
    fout.write("<a href=\"https://github.com/search?p="+str(jj)+"&q="+keyword + "&ref=searchresults&type=Repositories\">1</a>")
  fout.close()
  if "1"== tarball_num:
    os.system("firefox "+ fn0 +" & ")
  else:
    os.system("firefox "+ fn_out + "& ")

  get_github_page_step2(keyword, per4s , per1s, random_s, tarball_num )
  os.chdir(curdir)
  
"""
given any keyword, go github downloading all available hit-pages; saved in "keyword"_pages subdir.
then download the actually link in the _pages folder.
"""
if __name__=="__main__":

  if len(sys.argv) < 5: 
    print "Format: "+sys.argv[0]+ " <keyword> <per_url_sleep_second> <per_4_urls_sleep_second> <max_random_wait_second>"
    print "e.g.: 	"+sys.argv[0]+ " linkedin 15 30 60"
    sys.exit(1)
  curdir=os.getcwd()
  keyword= sys.argv[1].replace(" ","+")
  try:
    os.mkdir( keyword )
  except OSError,err:
    if err.errno!=17:
        raise
  os.chdir(keyword)

  per4s  = sys.argv[2] 
  per1s  = sys.argv[3] 
  random_s=sys.argv[4] 
  get_github_page0(keyword, per4s, per1s, random_s )
  os.chdir(curdir)
    	

