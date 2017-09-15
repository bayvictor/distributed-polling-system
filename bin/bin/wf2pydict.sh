echo "usage: $0 <wf_filename>"
echo "e.g.:   $0 list_of_zips-2014-01-16-23-26-14.txt.trunk"
echo "^C to break, anykey to continue...";read readline

cat $1 | wordfreq >$1.wf
 swapcolumn.sh $1.wf  > $1.wfswap

echo "" >>$1.wfswap
cat $1.wfswap  | sed -e "s|^|\"|g;s| |\",\"|g;s|$|\",|g" |sed '1 i\#!/usr/bin/python\nimport os, sys\nwf_dict = \{'| sed '$ i\ \};$d' >$1.dict.py




