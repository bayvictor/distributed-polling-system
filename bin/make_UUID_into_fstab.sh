sudo blkid|sed 's/^/\#/g'|sed 's/UUID=/@UUID=/g'|tr '@' '\n'|sed 's/\"//g' |sed 's/$/  errors=remount-ro   2    1/g'|sed 's/TYPE=//g'

