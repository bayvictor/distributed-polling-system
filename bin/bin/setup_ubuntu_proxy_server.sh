
echo "Install proxy server!"

echo "A real proxy server on Ubuntu usually centers around a piece of software named Squid. Squid is an open source proxy server in wide use across the internet. Squid is easy to install and configure. Install and edit the configuration file:
press any key will do:
sudo apt-get install -y squid3
vi /etc/squid3/squid.conf 


$ "
read readline

sudo apt-get install -y squid3

echo "will do \" vi /etc/squid3/squid.conf  \" below line and please add 2 lines:


http_access allow local_net
acl local_net src 192.168.0.0/255.255.255.0
"
read readline


vi /etc/squid3/squid.conf




echo "Where 192.168.0.0 is your local network. Restart squid and you have a basic proxy server set up – you would modify your settings to use a web proxy on port 3128 and the IP address of your Ubuntu system "

read readline

