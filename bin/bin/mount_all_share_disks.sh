#!/bin/bash

echo "must run \"$0\" as root! now \$USER=$USER"
echo "put list of \"$0\" first! ^c and do \"vi $0\" then rerun with enter return-key!"
read read_line

generate_list0()
{
echo " staqb15   adc7100051  adc7100052 adc7100056     "

}

generate_list ()
{

  echo "04 05 06 08 09 10 16 17 18 20 21 23 24 25 26 28 29 30 31 32 33 34 35 36"

}

generate_list_strkc ()
{

  echo "101 102 103 104 105 106 122"

}

# modify for cygwin :)
for word1 in $(generate_list0)  # Let "word" grab output of function.
do
  word=$word1
  echo "mapping $word, waiting..."
  mkdir ~/tmp
  mkdir  ~/tmp/"$word"
  mkdir  ~/tmp/"$word"/project
  mount $word":"/scratch ~/tmp/"$word"
  mount $word":"/project ~/tmp/"$word"/project
done


echo "press ^C to break, anykey to proceed \"strkc[0-xx]\"!"
read read_line


for word1 in $(generate_list_strkc)  # Let "word" grab output of function.
do
  word="strkc"$word1
  echo "mapping $word, waiting..."
  mkdir  /"$word"
  mkdir  /"$word"/project
  mount $word":"/scratch /"$word"
  mount $word":"/project /"$word"/project
done

echo "press ^C to break, anykey to proceed \"strkb[04-xx]\"!"
read read_line

for word1 in $(generate_list)  # Let "word" grab output of function.
do
  word="strkb"$word1
  echo "mapping $word, waiting..."
  mkdir  /"$word"
  mkdir  /"$word"/project
  mount $word":"/scratch /"$word"
  mount $word":"/project /"$word"/project
done




