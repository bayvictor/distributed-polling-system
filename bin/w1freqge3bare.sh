~/bin/w1freqge3.sh $1 | sed -e 's/^ *[0-9]* //g'

#cat $1 | tr ' ' '\n' | wordfreq | grep -ve " [12] [a-zA-Z]"  | sed -e 's/^ *[0-9] //g' 
 
