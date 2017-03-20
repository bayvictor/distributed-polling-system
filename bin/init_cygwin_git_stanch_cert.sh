mkdir ~/certs
curl http://curl.haxx.se/ca/cacert.pem -o ~/certs/cacert.pem
echo "Now update .gitconfig to use this for peer verification:
"
echo "
[http]
sslCAinfo = /home/v2.huang/certs/cacert.pem
">> ~/.gitconfig

