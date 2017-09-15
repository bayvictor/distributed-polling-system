# cat $1|sed 's|[^a-zA-Z0-9]|\n|g'| tr '[:upper:]' '[:lower:]'|wordfreq| sed 's| *1 .*||g'|less #sort -u >$1.srt.sh  
 cat $1|sed 's|[^a-zA-Z0-9]|\n|g'| tr '[:upper:]' '[:lower:]'|wordfreq| sed 's| *1 .*||g'| sed 's| *2 .*||g'| sed 's|^ *[0-9][0-9]*||g'|uniq|less #sort -u >$1.srt.sh  
chmod +x *.sh
