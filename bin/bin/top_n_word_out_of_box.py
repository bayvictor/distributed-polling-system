#!/usr/bin/python

def print_top_n_word_out_of_box( Blines0, lines, top_ii, start_ii ):
  skip_ii = 0	
  print_ii = 0
  for Bstring in Blines0:	
   Blines = re.split('\.', Bstring)
   for Bline in Blines:
	if ( skip_ii < start_ii ) :
          skip_ii += 1
          continue
	if Bline in lines:
          skip_ii += 1
          continue
	else:
          print_ii += 1 
          if ( print_ii > top_ii ) :
            return( " ", skip_ii )
#		Bline2 = Bline
#		Bline2 = Bline2.replace( '.' , ' ' )
#		if Bline2 in lines:
#			continue
#		else:
#			print Bline2
#			return Bline2
          print Bline

# below end def
  print "     "   # not found with blank line!
  return(Bline , skip_ii)

def timestamping_on_short_csv():
    cmd = "find ."
    stream = os.popen(cmd)

    lines = stream.readlines()
    for line in lines:
      line = line.rstrip('\n \t')
      fileExtension = line.split('.')[-1]
      if not fileExtension == "csv":
#        print "skipping!fileExt="+fileExtension+",len=%d"%len(fileExtension)
#        print "skipping!"+line
        continue
      fileNameTrunk =  line.split('.')[-2].rstrip('\n \t') #  
#      os.rename( line, fileNameTrunk+"."+fileExtension )
      fileNameTail =  line.split('.')[-2][-19:] # get timestamp
      has_stamp="true"
#      print "fileNameTail =(" + fileNameTail+"),len=%d"%len(fileNameTail)
#      print "fileNameTail [-3:-2]=(" + fileNameTail[-3:-2]+")),len=%d"%len(fileNameTail[-3:-2])
      if not ( fileNameTail[-3:-2] == "-" and  fileNameTail[-5:-4] == "-" and  fileNameTail[-7:-6] == "-"   and  fileNameTail[-9:-8] == "-" ) :
        has_stamp = "false"   # not a normal timestamp format


      pos = fileNameTrunk.find( "-", 0 )  
      newFileNameTrunk = fileNameTrunk[:pos]
      descWordLines = os.popen("cat \"" + line +"\" |cut -d\',\' -f1|wordfreq |sort -g -r|head -n 1|sed \'s/^  *//g\'|cut -d\' \' -f2" ).readlines()
      topFreqWord=""   
      for ii_freq in range(0, 4):
        if ii_freq >= len( descWordLines ):
          break
        topFreqWord += descWordLines[ii_freq].rstrip(' \n\r\t')+"_"
        
#      if len(freqline) > 0:
#        topFreqWord = topFreqWord.rstrip(' \n\r\t')
#      else:
#        topFreqWord =  newFileNameTrunk  #use old trunk when no topWordLines result
#      print "topFreqWord=("+topFreqWord+")"
      #// out of for fileNameTail
      if has_stamp == "true":
#        print line+"has timestamp!"
        continue  ## do nothing
      else :
#        print "no!"+line+"has not timestamp!"
        if fileExtension == 'csv':
          uu = uuid.uuid4().bytes.encode("base64")[:21].replace('/','_')
          timestamp = os.popen("timestamp").readlines()[0].rstrip(' \n\r\t')+ "__"+ uu
#          print "timestamp=("+timestamp+")"
          com="cat \"" + line +"\" | wc -l "
          line_num = os.popen(com).readlines()[0].strip()
          stream = os.popen("mv \'" + line + "\' " + "\'" + topFreqWord +"__" + line_num +"__" + timestamp +"." + fileExtension+"\' " )  # rename filename with a timestamp tail 
          
from random import Random
#import random
import uuid
import os, re
timestamping_on_short_csv()
pp = os.popen("~/bin/all_curdir_csv_to_dict.sh > all_cvs_words.txt" );
BIG_FILE = "all2006ow_bare0.txt.desc.uword.txt.bare.txt"
FILE = "all_cvs_words.txt"
f = open(FILE, 'r')
string = f.read()
f.close()
Bf = open(BIG_FILE, 'r')
Bstring = Bf.read()
Bf.close()

Bstring = Bstring.rstrip('\n')
Blines = re.split('\n', Bstring)
string = string.rstrip('\n')
lines = re.split('\n', string)

FILE2 = FILE + ".bare_at_lineno"
f2 = open(FILE2, 'r')
line = f2.read().rstrip('\n')
f2.close()
#eq_pos = 0
#eq_pos = line.find("=", 0);
#ii = 0
if ( len(line) == 0 ):
  ii = 0  # not found
else:
  ii =  int (line)
  
#Bline = "  "
#(Bline, ii) = 
ret_ii = 0

#generate random number of out_of_box!
random = Random ()
random_ii = random.randrange ( 1, 3 ) 
(Bline,ret_ii) = print_top_n_word_out_of_box(Blines, lines, random_ii, ii )

FILE2 = FILE + ".bare_at_lineno"
f2 = open(FILE2, 'w')
f2.write("%d\n"%(ret_ii) )
#f2.write(string(ii))
f2.write("\n")
f2.close()


