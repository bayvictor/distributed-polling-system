 cat *.csv>all_cvs_words.txt 
 cat all_cvs_words.txt | wordfreq |sed 's/^\s*[0-9][0-9]* //g'|sort > all2006ow_bare0.txt.desc.uword.txt.bare.txt

 touch all_cvs_words.txt.bare_at_lineno

/home/bsquare2/bin/top_n_word_out_of_box.py


