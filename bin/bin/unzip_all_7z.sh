#/bin/bash
echo "unzip all *.7z files under curdir!"
echo "press ^c to break, anykey to proceed!"
read read_line

sudo apt-get install -y p7zip
find   -type f -name '*.7z' -exec p7zip -d {} \;

