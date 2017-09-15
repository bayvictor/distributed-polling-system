 subdir.normalize.cnfilename.py 
 curdir_all_html2txt_py.sh "py"
 cd txt_py/
 rm -fr TAGS
 find | grep -e "\.py$" | xargs etags -a 
 echo "we have etags those list of files, make it searchable in emacs!"
 find | head
 echo "..."
 find |tail
 echo "^C to break, anykey to use emacs to search through py code!";read readline
 emacs &

