if  test -z "$1" ; then
 echo "usage:$0 <target_dir_path>"
 echo "e.g.:   $0 /sdb1/src    "
 exit 1
fi
unset  TargetDir 
export TargetDIR=$1  
#TargetDIR=$TargetDir


  ls $TargetDir -l|cut -d":" -f2|cut -d" " -f2|sed '1d' > ../test01.txt

  cat ../test01.txt |sed 's|^|ln -s $TargetDir/|g;s/$/ /g' >../test02.txt
  echo "unset TargetDir">lnall.sh
  echo "export \$TargetDir=$1">>lnall.sh

  paste ../test02.txt ../test01.txt >>lnall.sh

 vi lnall.sh 
 echo "^c to break, any otherkey to continue..."; read readline

 chmod +x *.sh
 ./lnall.sh





