find|grep -e "debug\.apk$"|sed 's|/bin/.*\-debug\.apk$||g;s|[^a-zA-Z0-9]|_|g;s|^__android_||g;s|master$||g;s|_unzip_|_|g;s|_*$||g'

