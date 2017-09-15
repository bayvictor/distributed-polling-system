#vhuang@vhuang-gigabyte:~/src/social_game/saved_Alexis_w_Taylor$ cat Aliyah.inner.pets.txt |grep -e "^ [A-Z]" | cut -d" " -f2|sed 's|^|firefox http://www.hi5.com/apps/pets.html?dataSource=Pets&ll=nav#/home/ -no-remote -P |g;s|$|caus \&|g'
#firefox http://www.hi5.com/apps/pets.html?dataSource=Petsll=nav#/home/ -no-remote -P Haileycaus &
#firefox http://www.hi5.com/apps/pets.html?dataSource=Petsll=nav#/home/ -no-remote -P Savannahcaus &
#...
echo "usage: $0  <txt_copy_paste_hi5_pet_filename>"
echo "e.g.: 
$0  Aliyah.inner.pets.txt
"

cat $1 |grep -e "^ [A-Z]" | cut -d" " -f2|sed 's|^|firefox http://www.hi5.com/apps/pets.html?dataSource=Pets&ll=nav#/home/ -no-remote -P |g;s|$|caus \&|g'  > $1.sh
chmod +x *.sh

echo "^C to break, any key to run above batch shell...."; read readline

./$1.sh
 
