
sudo apt-get install imagemagick -y 
sudo apt-get install pdftk -y 
for name in *.png; do convert $name `basename $name .png`.pdf; done
pdftk `ls *.pdf|tr '\t' '\n'|tr '\n' ' '` output last.pdf
echo "result in last.pdf!"

