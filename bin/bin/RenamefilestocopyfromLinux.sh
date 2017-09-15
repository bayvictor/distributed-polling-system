#!/bin/bash
find . -name "*\\*" -exec rename -n "s/\\/-/g" {} \;
find . -name "*:*" -exec rename -n "s/:/-/g" {} \;
find . -name "*\**" -exec rename -n "s/\*/-/g" {} \;
find . -name "*\?*" -exec rename -n "s/\?/-/g" {} \;
find . -name "*\"*" -exec rename -n "s/\"/-/g" {} \;
find . -name "*<*" -exec rename -n "s/</-/g" {} \;
find . -name "*>*" -exec rename -n "s/>/-/g" {} \;
find . -name "*\|*" -exec rename -n "s/\|/-/g" {} \;
find . -name "*\n*" -exec rename -n "s/\n/-/g" {} \;
find . -name "*\t*" -exec rename -n "s/\t/-/g" {} \;

