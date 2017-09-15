mkdir ~/src   
cd ~/src/
#mv victor victor_old
mkdir ~/src/victor
cd ~/src/victor
git clone https://github.com/bayvictor/distributed-polling-system.git
#  ./down.sh 
cd distributed-polling-system/
 diff bin ~/bin -dup >../diff.txt
cat ../diff.txt |grep -e ^Only >../test.txt
cat ../test.txt |grep home >../home.txt
 cat ../home.txt|cut -d":" -f2|sed 's|^ |cp ~/bin/|g;s/$/ bin\/ /g' >../cpall.sh
chmod +x ../*.sh
chmod +x bin -R
chmod +x ~/bin -R

  ../cpall.sh 
 cat ../home.txt|cut -d":" -f2|sed 's|^ |git add bin/|g;' >../addall.sh
    echo "git commit -m \"1st adding\"" >>../addall.sh
    echo "git pull;git push" >>../addall.sh
  bin/git_config.sh 
../addall.sh

