#!/usr/bin/env python
import os

def append_lines_to_file( filename, headers):
  headers = ['type 1', 'type 2', 'insert more types']
  filename = 'your/file/here'
  tmp = open('TMP', 'w')
  orig = open(filename, 'r')
  tmp.write('\t'.join(headers) + '\n')
  for line in orig.readlines():
    tmp.write(line)

  orig.close()
  tmp.close()
  os.remove(filename)
  os.rename('TMP', filename)

def find_all_subdir_fileext_filename_and_modify( fileext, headers ):
  kk=os.popen('find .. | grep -e "\."+ fileext +"\"' + '|grep -e "\.pro$" ' ).readlines()
  print "len(kk)=(";len(kk);")"
  for f in kk:
    print "line=("+f+")"
    f = f.rstrip()
    append_lines_to_file( f, headers )

  kk.close()

if __name__=="__main__":
	argv=sys.argv
	usage = """\
Usage: "+argv[0]" file_ext appended_head_lines 
e.g.: +argv[0]" pro "/usr/local/python2.7"
"""
  
	if len(argv) < 3:
		print(usage)
		sys.exit(1)

  file_ext = argv[1]
	headers = argv[2]
  find_all_subdir_fileext_filename_and_modify( fileext, headers )
  
  
