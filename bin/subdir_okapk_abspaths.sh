find|grep -e "debug\.apk$"|sed 's|/bin/.*\-debug\.apk$||g;s|^\./|'$PWD'/|g'

