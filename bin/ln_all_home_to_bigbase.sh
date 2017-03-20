rm -fr ~/.mozilla
ln -s /sdi/mozilla_dir ~/.mozilla


   tree /sdi -d -L 1|grep -v ">" | cut -d" " -f2 |sed '1d'|sed '1d'|sed '$d'|sed '$d'>~/test01.txt

  #  ln -s /sde/2016-26-step0 ~/last_ccraw
 cat ~/test01.txt |sed 's/^/rm -fr ~\//g' > go.sh 

chmod +x go.sh
vi go.sh
echo "contrl-c to break, anykey to contnue...";read readline

./go.sh


  tree ~  -d -L 1|grep -v ">" | cut -d" " -f2 |sed '1d'|sed '1d'|sed '$d'|sed '$d'>~/home01.txt



  cat ~/home01.txt |sed 's|^|mkdir /sdi/|g' >go.sh

chmod +x go.sh
vi go.sh
echo "contrl-c to break, anykey to contnue...";read readline

./go.sh

 cat ~/home01.txt |sed 's/^/rm -fr ~\//g' > go.sh 

chmod +x go.sh
vi go.sh
echo "contrl-c to break, anykey to contnue...";read readline

./go.sh

  tree /sdi -d -L 1 | cut -d" " -f2 |sed '$d'|sed '$d'>~/test01.txt


 cat ~/test01.txt |sed 's|^|ln -s /sdi/|g' > ~/test02.txt
 cat ~/test01.txt |sed 's/^/ ~\//g' >~/test011.txt
 paste ~/test02.txt ~/test011.txt >> go.sh 
chmod +x *.sh
 vi go.sh
echo "contrl-c to break, anykey to contnue...";read readline

./go.sh

