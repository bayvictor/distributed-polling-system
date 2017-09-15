 1088  2013-09-19 17:22:15 tree ../ -d -L 1 | cut -d" " -f2 >test01.txt
 1089  2013-09-19 17:22:50 cat test01.txt | sed 's/^/mkdir /g' > test012.txt
 1090  2013-09-19 17:22:55 cat test012.txt
 1091  2013-09-19 17:23:08 cat test01.txt | sed 's/^/mkdir /g;s/$/;/g' > test012.txt
 1092  2013-09-19 17:23:14 cat test012.txt
 1093  2013-09-19 17:26:50 cat test01.txt | sed 's/^/cd /g;s/$/;/g;' > test013.txt
 1094  2013-09-19 17:26:57 cat test013.txt
 1095  2013-09-19 17:29:25 cat test01.txt | sed 's|^|make distclean;../../configure   --prefix=/opt --target=arm-eabi --host=x86_64-unknown-linux-gnu --build=x86_64-unknown-linux-gnu --with-gnu-as --with-gnu-ld --enable-languages=c,c++|g;make;sudo make install' > test014.txt
 1096  2013-09-19 17:30:13 cat test01.txt | sed 's|^|make distclean;../../configure   --prefix=/opt --target=arm-eabi --host=x86_64-unknown-linux-gnu --build=x86_64-unknown-linux-gnu --with-gnu-as --with-gnu-ld --enable-languages=c,c++;make;sudo make install ;|g' > test014.txt
 1097  2013-09-19 17:30:19 cat test014.txt |head
 1098  2013-09-19 17:31:38 cat test01.txt | sed 's|^|make distclean;../../|g;s|$|configure   --prefix=/opt --target=arm-eabi --host=x86_64-unknown-linux-gnu --build=x86_64-unknown-linux-gnu --with-gnu-as --with-gnu-ld --enable-languages=c,c++;make;sudo make install ;|g' > test014.txt
 1099  2013-09-19 17:31:40 cat test014.txt |head
 1100  2013-09-19 17:32:15 cat test01.txt | sed 's|^|make distclean;../../|g;s|$|/configure   --prefix=/opt --target=arm-eabi --host=x86_64-unknown-linux-gnu --build=x86_64-unknown-linux-gnu --with-gnu-as --with-gnu-ld --enable-languages=c,c++;make;sudo make install ;|g' > test014.txt
 1101  2013-09-19 17:32:17 cat test014.txt |head
 1102  2013-09-19 17:33:46 cat test01.txt | sed 's|^|make distclean;../../|g;s|$|/configure   --prefix=/opt --target=arm-eabi --host=x86_64-unknown-linux-gnu --build=x86_64-unknown-linux-gnu --with-gnu-as --with-gnu-ld --enable-languages=c,c++;make;sudo make install ;cd ..;|g' > test014.txt
 1103  2013-09-19 17:33:48 cat test014.txt |head
 1104  2013-09-19 17:34:31 paste test012.txt test013.txt test014.txt|head
 1105  2013-09-19 17:35:16 paste test012.txt test013.txt test014.txt > optbuild_all.sh



