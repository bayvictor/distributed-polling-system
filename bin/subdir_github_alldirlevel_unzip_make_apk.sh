CUR=$PWD
mkdir allzips_insubdirs
cd allzips_insubdirs
find .. | grep -e "\.zip$" > ziplist01.txt
cat ziplist01.txt | sed 's|^|cp |g;s|$| . |g' > cpall.sh
chmod +x *.sh
./cpall.sh
find . | grep -e "\.zip$" | sed -e 's/^/echo \"/g;s/$/\";/g' > ziplist01.txt
find . | grep -e "\.zip$" | sed -e 's/^/unzip -o -q /g' > ziplist02.txt
paste ziplist01.txt ziplist02.txt > ./ziplist02.txt.sh
chmod +x *.sh
./ziplist02.txt.sh

mkdir zips
mv *.zip zips

mkdir unzip
mv * unzip
mv unzip/zips .
cd unzip

/home/vhuang/bin/cygwin_subdir_do__AndroidManifest.py android-17

cd $CUR
echo "current path =($CUR)"

