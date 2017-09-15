# cat up_payton_pets.sh.txt | grep -e "^ [A-Z]"|cut -d" " -f1 |sed 's|^| firefox http://www.hi5.com/apps/pets.html?dataSource=Petsll=nav#/home/ -no-remote -P |g; s/$/caus \& /g'

echo "usage: $0 up_payton_pets.sh.txt"
echo "where you txt file copy-pasted from hi5 browser with ^ [A-Z] as name syntax 
"
echo "^C to break, any otherkey to continue..."; read readline
cat $1 | grep -e "^ [A-Z]" | cut -d" " -f2 >test.txt
cat test.txt|sed 's/^/echo \"/g;s/$/\"; echo \"^C to break,anykey to go";read readline; /g' > test01.txt



cat test.txt|sed 's|^| firefox http://www.hi5.com/apps/pets.html?dataSource=Petsll=nav#/home/ -no-remote -P |g; s/$/caus \& /g' >test03.txt

cat test.txt|sed 's|^| firefox http://www.hi5.com/apps/pets.html?dataSource=Petsll=nav#/home/ -no-remote -P |g; s/$/svcaus \& /g' >test02.txt

paste test01.txt test03.txt > $1.sh
paste test01.txt test02.txt >> $1.sh
chmod +x *.sh
gedit $1.sh
echo "^C to break, any otherkey to continue..."; read readline

./$1.sh
 

