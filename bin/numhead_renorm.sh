#!/bin/bash

  cat $1  |sed 's/[^0-9a-zA-Z]/_/g' > /tmp/test01.txt 
  cat /tmp/test01.txt -n |sed 's/ /0/g;s/\t/__/g'

