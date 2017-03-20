#!/bin/bash -e
#
# Quick and dirty script which dumps all chrome cookies in specified
# SQL Lite DB to stdout in Netscape format.

#~/.config/google-chrome/Default/Cookies'
COOKIE_FILE='~/.config/chromium/Default/Cookies'  


echo -e '.mode tabs \n select host_key, httponly, path, secure, ' \
  'expires_utc/10000000, name, value from cookies;' |
  sqlite3 $COOKIE_FILE |
  sed -e 's/\t0\t/\tFALSE\t/g ' -e 's/\t1\t/\tTRUE\t/g'

echo "share|improve this answer
	
answered Jun 4 '12 at 2:20
user137906
6112

http://superuser.com/questions/214846/how-to-download-this-webpage-with-wget	
   	 
	
It worked after replacing the ~ in COOKIE_FILE by its particular value in my configuration. I suppose there's a lacking export or the like in my system. The error that I received before making this change was unable to open database file. –  naitoon Aug 11 '13 at 0:59
add comment
"

