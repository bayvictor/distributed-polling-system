#!/usr/bin/env python
# -*- coding: utf-8 -*-
###### -*- coding: cp936 -*-
import os
import sys
import string
import re
import regex
import jieba

jieba.enable_parallel(4)

def jieba_parse_into_outf( seg0, outf ):
  words = jieba.cut_for_search( seg0 ) 
  for word in words:
    # in-depth parse into word here !!!
    fixstr = format(len(word), '06d') 
    outf.write(fixstr + ":" + word.encode('utf-8') + "\n")

def deeper_parse_into_outf( seg0, outf ):
  slen = len(seg0)
  m34 = regex.sub(r'([0-9\-][0-9\-\.]*)([\u53f7\u5ba4])', r'\1\2 ', seg0 ) #e.g., “12号(室)” append " "
  m34 = regex.sub(r'([\.\-][\-\.]*)([\.\-])', r'\.', m34 )
  m35 = regex.sub(r'([\u4e00-\u9fa5a])\p{P}+([\u4e00-\u9fa5a])', r'\1 \2', m34 )
  m36 = regex.sub(r'([0-9\-][0-9\-\.]*)([\u4e00-\u9fa5a][\u4e00-\u9fa5a][\u4e00-\u9fa5a][\u4e00-\u9fa5a]*)', r' \1 \2 ', m35 )
  words = m36.split(" ")
  for word in words:
    # in-depth parse into word here !!!
    fixstr = format(len(word), '06d') 
    outf.write(fixstr + ":" + word.encode('utf-8') + "\n")



# cnfrq filename each line format: <numeric_string>:<content> 
def parse_cnfrq_file_then_write_fixed_wordlen_n_word_to_outf( outfn_dict, filename, debugflag=True ):
  lines0 = open( filename, "rt" ).readlines()
  lines = [ x.strip().decode('utf-8', 'replace') for x in lines0 ]
  #lines = [ x.strip().decode('utf-8', 'replace') for x in lines0 ]
  for ii in range(len(lines)):
    line = lines[ii]
    words = line.split(":")   #ToCnWords( line )
    if len(words) < 2: 
      continue
    if True == debugflag and 0 == ii % 10000:
      print "len(words)="+str(len(words))+",line["+str(ii)+"]("+line.decode('utf-8','replace')+"),filename=("+filename.decode('utf-8','replace')+")"
    seg0 = words[1]
    deeper_parse_into_outf( seg0,  outfn_dict["len.word"] )
    jieba_parse_into_outf( seg0, outfn_dict["jieba"] )
  for kw in outfn_dict:
    outfn_dict[kw].flush()

def compose_lenstring_list( filename, debugflag=False ):
  lines0 = open( filename, "rt" ).readlines()
  lines = [ x.strip().decode('utf-8', 'replace') for x in lines0 ]
  #lines = [ x.strip().decode('utf-8', 'replace') for x in lines0 ]
  maxlen = 0
  max_str = ""
  for ii  in range(len(lines)):
    line = lines[ii]
    curlen = len(line)
    if curlen > maxlen:
      maxlen = curlen
    if True == debugflag and 0== ii % 5000:
      print "max_str=("+max_str+"),"+"maxlen=("+str(maxlen)+")"

def lineToCnWords(line, debugflag = False ):
  if True == debugflag:
    print "line=("+line+")"
  regex = re.compile(ur"[^\u4e00-\u9fa5a-zA-Z0-9\.\@\_\-]" )
  ret =  regex.sub(' ', line )
  if debugflag == True:
  #ret =  regex.sub(' ', line.decode('utf-8', 'replace'))
    print "ret=("
    print ret
    print ")" 
  words = ret.split(' ')
  return ( words )

def testLine():
  ss = "带走。什么当年薪，！北京,大学,古3abbzA-Z0-459,安抚？人人、争先“好”收关《学校卓越》"
  kk = lineToCnWords( ss.decode('utf-8', 'replace') )
  print "("
  for item in kk:
    print item.encode('utf-8')
  print ")"

def curdir_merge_all_cnfrq_into_all_cnfrq(outfn="all.len.cnfrq"):
  p = os.popen('find  -type f | grep -e "\.cnfrq$" ' , 'r')
  #p = os.popen('find . -type f |sed \'s/\.\/\.//g\' ' , 'r')
  files0 = p.readlines()
  files = [ x.strip() for x in files0 ]
  p.close()
  outfn_list = ['len.word', 'jieba']
  outfn_dict = {}
  for fn in outfn_list:
    outfn_dict[fn] = open( fn, "wt" )


  os.system("find . ")
  outf   = open( outfn, "wt" ) 
  #outf   = open( "all.len.cnfrq", "wt" ) 
  
  for ii  in range(len(files)):
    filename = files[ii] 
    print "merging len:word items in filename["+str(ii)+"]=("+filename+") into (" + outfn + ")"
    parse_cnfrq_file_then_write_fixed_wordlen_n_word_to_outf (outfn_dict, filename, False )

  #outf.close()
  for out_fn in outfn_list:
    outfn_dict[out_fn].close() 
    cmd =  "time sort -u -r " + mid_fn + " | uniq > " + out_fn
    print "we're going to do shell \"("+cmd+"\") sorting...might take a long time, waiting..."
    ret = os.popen( cmd )
    print ret
    print "all len:word sorted, result in file("+out_fn + ")!"



def arg_check():
  argv=sys.argv
  usage = """\
    Usage: "+argv[0]" sorted_cnfrq_txt_filename[.txt] 
    e.g.:  "+argv[0]"  ../allcnfrq.txt 
   """
  if len(argv) < 2:
                print(usage)
                sys.exit(1)
  filename = argv[1]
  compose_lenstring_list( filename, True )

 
if __name__ == '__main__':
  # testLine()
  mid_fn = "len.word"
  out_fn =  mid_fn+".desc"
  curdir_merge_all_cnfrq_into_all_cnfrq( mid_fn )

