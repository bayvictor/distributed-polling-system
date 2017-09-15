echo "usage: $0 <html_filename>"
echo "e.g. $0 *.html "
echo "^C to break, anykey to continue";read readine

#cat 1.html   | grep "^      .a href"|grep -v "<li>"| cut -d'"' -f2|grep -v github.com | grep -v ^#$ |sed 's|^|https://github.com/|g' |sed 's|$|/archive/master.zip|g'| sed 's|/stargazers/|/|g'| sed 's|/network/archive/|/archive/|g' |sort -u 

cat $1  | grep "^      .a href"|grep -v "<li>"| cut -d'"' -f2|grep -v github.com | grep -v ^#$ |sed 's|^|https://github.com/|g' |sed 's|$|/archive/master.zip|g'| sed 's|/stargazers/|/|g'| sed 's|/network/archive/|/archive/|g' |sort -u | sed 's|^|wget |g' > test01.txt

cat test01.txt  | sed 's|[^0-9a-zA-Z\\.]|_|g' | sed 's|wget_| -O |g' > test02.txt
paste test01.txt test02.txt > go.sh
chmod +x go.sh
gedit go.sh

./go.sh
 

#resutl sample
#wget https://github.com/Bamtau/android_packages_apps_OrcaWallpapers/archive/master.zip
#wget https://github.com/CyanMobile/android_packages_apps_VideoLiveWallpapers_cyanmobile/archive/master.zip
#wget https://github.com/kimmyw/kimmyj-gdx-lwp/archive/master.zip
#wget https://github.com/leoisright/android_packages_wallpapers_NerdField/archive/master.zip
#wget https://github.com/leoisright/android_packages_wallpapers_NerdsLive/archive/master.zip
#wget https://github.com/yolanother/svgandroid/archive/master.zip

