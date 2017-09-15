cd /home/vhuang/src/3d/zoicbox34/divided  

grep "<class>" *.ui|cut -d">" -f2|cut -d"<" -f1 >> test00.txt 
 cat test00.txt |sed 's|^|    <widget class="|g;s|$|" name="|g'>text01.txt
 cat test00.txt|sed 's|$|" native="true"/>|g' > text02.txt
  paste text01.txt text02.txt|sed -e 's|name=\"\s*|name=\"|g' > copy_paste__under_stackedWidget_prop.ui.txt

cat copy_paste__under_stackedWidget_prop.ui.txt

echo "copy paste above txt under </property> of stackedWidget in frame_bottom.ui "
echo "^C to break, anykey to continue...";  read readline   
 
cp frame_bottom.ui  frame_bottom.ui.`timestamp`
gedit  frame_bottom.ui

