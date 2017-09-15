
if test -z "$1" 
then 
		echo "missing argument!"
		echo "usage:$0 <grep_filter_out_pattern> <filter02>"
		echo "e.g.: $0 \"openssh-5\""
		echo "exit...................\n"
		exit; 
fi 
mkdir ./flat
find| grep  -v "$1" | grep  -v "$2"  > list_src_sh_files.txt

cat list_src_sh_files.txt | sed 's/^/norm.sh /g' | sed -e 's/\.\///g' > test.txt.sh 
chmod +x *.sh
./test.txt.sh  |sed 's/^/.\/flat\//g' > test022.txt
paste list_src_sh_files.txt test022.txt |sed 's/^/cp /g' > /tmp/go.sh
chmod +x *.sh
echo;echo;echo;echo;
cat /tmp/go.sh
echo;echo;echo;echo;
cp /tmp/go.sh go.sh

echo "^C to edit \"/tmp/go.sh\" and manually run it, or any other key to copy all files to ~/flat"
read readline

/tmp/go.sh

#rm go.sh
rm test022.txt
rm test.txt.sh
rm list_src_sh_files.txt

