  treesubdir.sh  >test01.txt
  cat test01.txt|sed 's/^/ln -s home\/vhuang\//g;s/$/ /g' > test02.txt
  cat test01.txt|sed 's|^| /sda2/|g' > test03.txt
  paste test02.txt test03.txt > ln_home_vhuang_dirs_to_root.sh
  chmod +x ln_home_vhuang_dirs_to_root.sh 
  cat test01.txt|sed 's/^/ \/home\/vhuang\//g;s/$/ /g' > test022.txt
  cat test01.txt|sed 's|^| /sda2/|g' > test023.txt
  paste test023.txt test022.txt|sed 's/^/ln -s /g' >ln_home_to_here.sh
 chmod +x *.sh
  sudo ./ln_home_vhuang_dirs_to_root.sh 
  sudo chown vhuang /sda2/*
 ./ln_home_vhuang_dirs_to_root.sh 

