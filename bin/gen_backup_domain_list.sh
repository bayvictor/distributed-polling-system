
 ls -lt|cut -d":" -f2|cut -d" " -f2  |tr '\t' '\n' > test01.txt
cat test01.txt |sed 's/^/echo \"/g;s/$/\";/g' > test02.txt
chmod +x *.sh

cat test01.txt |sed 's/^/backup_domain.sh \"/g;s/$/\"/g' > test03.txt
paste test02.txt test03.txt > backup_domain_all02.sh
chmod +x *.sh
ls -lt|head
gedit ./backup_domain_all02.sh

