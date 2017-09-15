find | grep -e "\/bin\/.*debug\.apk$" | sed 's|/bin/.*debug\.apk$||g;s|^\./||g' >okdir.txt
cat okdir.txt | sed -e "s|^|cd "$PWD"/|g;s|$|;ant debug;|g" > go.sh
chmod +x go.sh
./go.sh


