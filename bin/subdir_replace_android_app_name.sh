export TS=`date +%h%d_%Hh%Mm`

find | grep -e "strings.xml$" | cut -d":" -f1|  xargs sed -i 's|<string name="app_name">|<string name="app_name">EncoreSS.VIC.'${TS}'.\n|g'


