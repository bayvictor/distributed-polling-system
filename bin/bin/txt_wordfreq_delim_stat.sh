  mkdir wordfreq
  mkdir delimfreq

  find > ../test01.txt
  cat  ../test01.txt|sed 's/$/\";/g;s|^|echo \"<processing:>...|g' > ../test011.txt
  cat  ../test01.txt|sed -e 's|^|wordfreq |g' > ../test012.txt
  cat  ../test01.txt|sed -e 's|^|delimfreq |g' > ../test013.txt

  cat  ../test01.txt|sed 's/$/\.wf/g;s|\./|>>wordfreq/|g' > ../test02.txt
  cat  ../test01.txt|sed 's/$/\.wf/g;s|\./|>>delimfreq/|g' > ../test03.txt
  paste ../test011.txt ../test012.txt ../test02.txt >../gen_wordfreq_all_txt.sh
  paste ../test011.txt ../test013.txt ../test022.txt > ../gen_delimfreq_all_txt.sh
   
  chmod +x ../*.sh
  ../gen_delimfreq_all_txt.sh
