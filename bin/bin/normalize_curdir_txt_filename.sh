find | sed 's/^/\"/g;s/$/\"/g' > ../test01.txt
cat ../test01.txt|sed -e 's/[^0-9a-zA-Z\-\.-\\._=;\%\:\-\/ \(\)\&]/_/g;s|_./|"|g;s|$|"|g'> ../test02.txt
paste ../test01.txt ../test02.txt | sed 's/^/mv /g;s/$/\.txt/g'>go.sh
chmod +x go.sh
./go.sh

