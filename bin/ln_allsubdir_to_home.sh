CUR=$PWD
treesubdir.sh >test01.txt
 cat test01.txt|sed 's/^/ln -s $PWD\//g;s/$/ /g'> test011.txt
 cat test01.txt|sed 's/^/~\//g'> test012.txt
paste test011.txt test012.txt 
 
