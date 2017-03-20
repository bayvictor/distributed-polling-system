#!/bin/bash

## run this line in case split rar start with 00
find   -type f -name '*00.rar' -exec unrar x {} \;
## start with 01 instead of 01 in most cases!
find   -type f -name '*01.rar' -exec unrar x {} \;
