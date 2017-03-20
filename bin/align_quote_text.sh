cat $1 |tr '\n' '@' | sed -e 's|@@|\^|g'|tr '\n' ' '|tr '\^' '\n' | sed 's/@//g'> $1.neat.txt 
