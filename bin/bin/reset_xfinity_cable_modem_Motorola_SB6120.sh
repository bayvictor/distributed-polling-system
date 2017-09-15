@ECHO OFF

REM This script checks for an active Internet connection by trying to access
REM five different web sites.  If all five checks fail, it will reset the cable
REM modem.

wget --tries=1 --timeout=10 -O - "http://www.google.com/"
IF %ERRORLEVEL%==0 GOTO done
echo Google failed.

wget --tries=1 --timeout=10 -O - "http://www.bing.com/"
IF %ERRORLEVEL%==0 GOTO done
echo Bing failed.

wget --tries=1 --timeout=10 -O - "http://www.yahoo.com/"
IF %ERRORLEVEL%==0 GOTO done
echo Yahoo! failed.

wget --tries=1 --timeout=10 -O - "http://www.facebook.com/"
IF %ERRORLEVEL%==0 GOTO done
echo Facebook failed.

wget --tries=1 --timeout=10 -O - "http://www.twitter.com/"
IF %ERRORLEVEL%==0 GOTO done
echo Twitter failed.

REM If we got here...  The Internet appears to be broken.
echo Restarting cable modem...
wget --tries=1 -O - "http://192.168.100.1/reset.htm?reset_modem=Restart+Cable+Modem"
echo Restarting cable modem. >> C:\Users\Aaron\log\internet-check.log
date /T >> C:\Users\Aaron\log\internet-check.log
time /T >> C:\Users\Aaron\log\internet-check.log
echo . >> C:\Users\Aaron\log\internet-check.log

exit 1

:done
echo The Internet appears to be working.
exit 0

