#!/bin/ksh

## this scripts for .log and .err files,  collect and "normalized" files! where:
## (1) copied with "normalized" new filename into one dir "_err_n_log" under current dir;
## (2) with new filename prefixing with absolute path mapping "/" into "__";
## (3) thus  log/err files in thousands of subdirs, being "flatten" conveniently into one dir !

find ${AUTO_WORK}/view/aime_dte*/oracle/work|grep -e "\.err$" > err_n_log.txt
find ${AUTO_WORK}/view/aime_dte*/oracle/work|grep -e "\.log$" >> err_n_log.txt
mkdir  _err_n_log/

workid=`echo "$AUTO_WORK"|sed "s|/work|@work|g"|tr "@" "\n"|tr "/" "\n"|grep "^work"`
echo "#!/bin/ksh" > all_err_n_log.${workid}.sh

cat err_n_log.txt|sed -e 's/^/export src=\"/g'|sed -e 's|$|\";export tgt=`echo $src\|sed -e \"s/\\\//__/g\"`;cp -fr $src _err_n_log/$tgt|g' >> all_err_n_log.${workid}.sh

chmod +x *.sh
./all_err_n_log.${workid}.sh

