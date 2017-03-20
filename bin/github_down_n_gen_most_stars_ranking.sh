#!/bin/bash
##!/bin/bash #-x

if test -z "$4"
then
 echo "missing parameter! exit...."
 echo "usage: $0 <kw> <delay1> <delay2> <page_num>"

 echo "e.g.:
  $0  python+messaging 5 30 1
 "
exit 1
fi
mkdir $1
  /usr/bin/python  ~/bin/github_down_n_gen_most_stars_ranking.py $1 $2 $3 $4 $5 
cd $1
ls -ltr|cut -d":" -f2|cut -d" " -f2 | grep -ve "\.html$" | grep -ve "\.html\.sh$" | grep -ve "\.txt$" | sed '1d'  > rankinglist.txt
echo "cat ranking.txt"
cat rankinglist.txt
#vi   rankinglist.txt
cd .. 
# ~/bin/github_down_n_gen_most_stars_ranking.py 
