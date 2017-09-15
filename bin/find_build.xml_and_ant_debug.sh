 find|grep -e "strings\.xmle$" | xargs rm -fr 
  find|grep -e "build\.xml$" >listofbuild.txt
  cat listofbuild.txt | sed -e 's|build\.xml$||g;s|/bin/$||g;s|/$||g' |sort -u >test01.txt 
  export build_dir_num=`cat test01.txt|wc -l`
  echo "(${build_dir_num}) dirs totally processed!"
  echo "CURDIR=$PWD" > ant_debug_all_dir_has_build.xml.sh
  cat test01.txt|sed 's/^/cd /g;s|$|;ant debug;cd $CURDIR|g' >> ant_debug_all_dir_has_build.xml.sh
  chmod +x *.sh
  ./ant_debug_all_dir_has_build.xml.sh


