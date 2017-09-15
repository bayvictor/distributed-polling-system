#!/usr/bin/env python
import os
import sys
import string

# we put all chars which will be replace with "_" in filename
stop_strings = " ()[]{}\"\'#<>$%!&*?/:\\@"
p = os.popen('find . -type f ' , 'r')
#p = os.popen('find . -type f |sed \'s/\.\/\.//g\' ' , 'r')
lines = p.readlines()
p.close()

def ltrim_underscore(new_line2):
  head_str = new_line2[:2]
  print ( "head_str=(" + head_str+ ")" )
  if  head_str == '.'+os.path.sep or head_str == "__":
    new_line2 = new_line2[2:]
  head_str = new_line2[:1]
  print ( "head_str=(" + head_str+ ")" )
  if  head_str == '.':
    new_line2 = new_line2[1:]
  while new_line2[-1] == '_':
    new_line2 = new_line2[:-1] 
  while new_line2[0] == '_':
    new_line2 = new_line2[1:] 
  return new_line2
  #new_line2

def subdir_replace( max_filename_len = 250, fn_ext="pdf" ):
 os.system("find . ")
 for jj in range(0, len(lines)):
  
  line0 = lines[jj].split("\n")[0]
  line_len = len(line0)
  print ("line0=("+line0+")")
  blank_ii = 0

  for blank_ii in range(0,len(line0)):
    if not line0[blank_ii] in "./":
        break
  print ("blank_ii="+str(blank_ii) )
  line=line0[blank_ii:]  
  new_line = ''.join( ch if not(ch in stop_strings) else '_' for ch in line )
  print ("victor,new_line=("+new_line+")")
  dot_words = new_line.split('.')
  double_tail_flag = True
  if len(dot_words) <2:
    double_tail_flag = False
    new_line += "."+ fn_ext 
    fn_tail = fn_ext
  elif dot_words[-1]==dot_words[-2]:
    dot_words = dot_words[:-1]
    new_line = '.'.join( dot_word for dot_word in dot_words )
    fn_tail = dot_words[-1]
  else:
    double_tail_flag = False
    new_line = '.'.join( dot_word for dot_word in dot_words )
    fn_tail = dot_words[-1]
  

  words = new_line.split("_")

  #new_line02 = '_'.join( word for word in words[:-1] ) 
  new_line02 = '_'.join( word for word in words ) 
  print ("victor,new_line02=("+new_line02+")")
   
  if double_tail_flag == True:
    new_line2 = new_line02[:max_filename_len]
  else: 
    new_line2 = new_line02[:max_filename_len]+"."+fn_tail 
 
  new_line2 = ltrim_underscore(new_line2)


  for kk in range(0, line_len):
    if -1 == new_line2.find("___"):
      break
    else:
      new_line2 = new_line2.replace("___","__")
#  os.system("mv "+ "\"" + line0+"\" "+ new_line2 + " " )
  len1 = len( line0 )
  len2 = len( new_line2 )
  print ("victor,new_fn_line2=("+new_line2+")")
  print ("len(old)="+str(len1)+",len(new_fn)=("+str(len2)+")" )
  trunk = get_path_trunk(line0)
  print ("path_trunk=("+ trunk +")" )
  if len(trunk) > 2:
    newpath = trunk + os.path.sep + new_line2[len(trunk):]
  else:
    newpath =  new_line2

  print ( "renaming ("+ line0+") to (" + newpath + ")" )
  while newpath[-1] == '_':
    newpath = newpath[:-1] 
  while newpath[0] == '_':
    newpath = newpath[1:] 
  os.rename( line0,  newpath )
  os.popen( "pdftotext -layout " + newpath +" " + newpath+".txt" )	# convert:pdf2txt

def get_path_trunk(path):
  parts1 = os.path.normpath(path)
  parts2 = parts1.lstrip(os.path.sep)
  dot_words = parts2.split(os.path.sep)

  trunk = os.path.sep.join( dot_word for dot_word in dot_words[:-1] )

  return trunk

if __name__ == '__main__':
  subdir_replace( fn_ext="pdf" )

