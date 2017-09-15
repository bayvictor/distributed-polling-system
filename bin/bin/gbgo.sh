sudo apt-get update -y;sudo apt-get upgrade -y 

sudo cp zh /var/lib/locales/supported.d/zh
sudo locale-gen

sudo apt-get install catdoc -y --force-yes 
xls2csv -l
echo "^C to break, anykey to continue...";read readline

./internalization_setup.sh
./GBKsetup02.sh 
./gedit_cn_fix.sh 
./trusty_GB_term_convmv.sh
