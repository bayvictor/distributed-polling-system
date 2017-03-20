tree ../ -d -L 1 | cut -d" " -f2 >test01.txt
echo "will do: vi test01.txt."
echo "press anykey to delete lines in test01.txt which don't want opt-build. run batch building file";read readline
vi test01.txt
cat test01.txt

cat test01.txt | sed 's/^/mkdir /g;s/$/;/g' > test012.txt
cat test01.txt | sed 's/^/cd /g;s/$/;/g;' > test013.txt
cat test01.txt | sed 's|^|make distclean;../../|g;s|$|/configure   --prefix=/opt --target=arm-eabi --host=x86_64-unknown-linux-gnu --build=x86_64-unknown-linux-gnu --with-gnu-as --with-gnu-ld --enable-languages=c,c++;make;sudo make install ;cd ..;|g' > test014.txt
paste test012.txt test013.txt test014.txt > optbuild_all.sh
chmod +x *.sh

echo "result like"
cat optbuild_all.sh | head

echo "press anykey to run batch building file(./optbuild_all.sh)";read readline

./optbuild_all.sh




