# cat playsheet.txt|grep "\-"|cut -d"-" -f2|sed 's|^|http://www.hi5.com/apps/pets.html?ll=tag_profile_mod&uid=5926403371#/pet/|g;s/^/chromium-browser /g;s/$/ \&/g'

echo "$0 <txt_hi5id_filename> <btween_tab_sleep_seconds>"
echo "$0 idlist.txt "
echo "1/4 or a quarter second waiting is too long for analytic study"
echo "blink of eyes is 400 mili-second, too long"
echo "your olymic champion crazy click speed is 4.72 clicks per second"
echo ""  
echo "^C to break, any key to continue...."

cat $1 | sed 's|^|http://www.hi5.com/apps/pets.html?ll=tag_profile_mod&uid=5926403371#/pet/|g;s/^/chromium-browser /g;s/$/ ; sleep $((RANDOM%30+8)); \&/g'

 
 
