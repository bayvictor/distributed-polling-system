 echo "usage:$0 <fishid> <act_on_hookit>"
 echo "e.g.01.: $0 \"build.xml\" \"ant debug" "
 echo "e.g.02: $0 \"AndroidManifest.xml\" \"android update project --path . --target android-18 " "
# FISH="AndroidManifest.xml"
 FISH=$1
 echo "^C to break, anykey to continue"; read readline

 find|grep -e "${FISH}e$" | xargs rm -fr 
  find|grep -e "${FISH}$" >listofbuild.txt
  cat listofbuild.txt | sed -e 's|${FISH}$||g;s|/bin/$||g;s|/$||g' |sort -u >test01.txt 
  export build_dir_num=`cat test01.txt|wc -l`
  echo "(${build_dir_num}) dirs totally processed!"
  echo "CURDIR=$PWD" > ant_debug_all_dir_has_build.xml.sh
  cat test01.txt|sed 's/^/cd /g;s|$|;$2;ant debug;cd $CURDIR|g' >> ant_debug_all_dir_has_build.xml.sh
  chmod +x *.sh
  ./ant_debug_all_dir_has_build.xml.sh


