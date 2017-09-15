#!/bin/bash -x 
#!/usr/bin/bash -x 
# Minimum number of arguments needed by this program
MINARGS=1  

# get the number of command-line arguments given
ARGC=$#

#how program usage
show_usage()
{
    echo
    echo "Usage:"
    echo "${0##/} <filename_ext>"
    echo "e.g.:"
    echo "$0 \"py\""
    echo "$0 \"sh\""
    exit
}

# check to make sure enough arguments were given or exit
if [[ $ARGC -lt $MINARGS ]] ; then
    echo "Too few arguments given (Minimum:$MINARGS)"
    echo
    show_usage
fi



unset fnext
export fnext="$1"  
echo "fnext=("$fnext")"
echo "^C to break, anykey to continue...";read readline
/home/vhuang/bin/curdir_normalize_filename.sh
/home/vhuang/bin/subdir_html2txt.py ".html2txt."$fnext
mkdir html;mkdir txt_${fnext};mkdir old_${fnext}
mv *.html html/
mv *.html2txt.${fnext} txt_${fnext}/
mv *.${fnext}  old_${fnext}

