cat Sascha_s_Mind_Maps.html |grep http|grep -e "^<li"| sed 's/http\:/@/g'|cut -d"@" -f2|cut -d'"' -f1|cut -d"." -f2-9|sed 's/\.at\//\.at\/maps\//g;s/\.html/\.mm/g;s/^/wget www\./g'

