echo "password?"; read yourpassword 

   
wget -retries=1 -post-data="loginUsername=admin&loginPassword=$yourpassword" http://10.0.0.1  --warc-file=backup01.html

wget -retries=1 -post-data="SaveChanges=Reboot" http://10.0.0.1  --warc-file=backup01.html


