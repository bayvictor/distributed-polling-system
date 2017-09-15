mkdir ~/src/ELK
cd ~/src/ELK

echo "How To Use Logstash and Kibana To Centralize Logs On Ubuntu 14.04
Tags: Monitoring, Logging Distribution: Ubuntu
Introduction

In this tutorial, we will go over the installation of Logstash 1.4.2 and Kibana 3, and how to configure them to gather and visualize the syslogs of our systems in a centralized location. Logstash is an open source tool for collecting, parsing, and storing logs for future use. Kibana 3 is a web interface that can be used to search and view the logs that Logstash has indexed. Both of these tools are based on Elasticsearch. Elasticsearch, Logstash, and Kibana, when used together is known as an ELK stack.

Centralized logging can be very useful when attempting to identify problems with your servers or applications, as it allows you to search through all of your logs in a single place. It is also useful because it allows you to identify issues that span multiple servers by correlating their logs during a specific time frame.

It is possible to use Logstash to gather logs of all types, but we will limit the scope of this tutorial to syslog gathering.

Note: An updated version of this guide can be found here: How To Install Elasticsearch, Logstash, and Kibana 4 on Ubuntu 14.04.
"
echo "^C to break, anykey to contiue...";read readline

echo "Our Goal
The goal of the tutorial is to set up Logstash to gather syslogs of multiple servers, and set up Kibana to visualize the gathered logs.

Our Logstash / Kibana setup has four main components:

Logstash: The server component of Logstash that processes incoming logs
Elasticsearch: Stores all of the logs
Kibana: Web interface for searching and visualizing logs
Logstash Forwarder: Installed on servers that will send their logs to Logstash, Logstash Forwarder serves as a log forwarding agent that utilizes the lumberjack networking protocol to communicate with Logstash
We will install the first three components on a single server, which we will refer to as our Logstash Server. The Logstash Forwarder will be installed on all of the servers that we want to gather logs for, which we will refer to collectively as our Servers.

Prerequisites
To complete this tutorial, you will require root access to an Ubuntu 14.04 VPS. Instructions to set that up can be found here (steps 3 and 4): Initial Server Setup with Ubuntu 14.04.

The amount of CPU, RAM, and storage that your Logstash Server will require depends on the volume of logs that you intend to gather. For this tutorial, we will be using a VPS with the following specs for our Logstash Server:

OS: Ubuntu 14.04
RAM: 4GB
CPU: 2
In addition to your Logstash Server, you will want to have a few other servers that you will gather logs from.

Let's get started on setting up our Logstash Server!
"
echo "^C to break, anykey to contiue...";read readline
echo "
Install Java 7
Elasticsearch and Logstash require Java 7, so we will install that now. We will install Oracle Java 7 because that is what Elasticsearch recommends. It should, however, work fine with OpenJDK, if you decide to go that route.

Add the Oracle Java PPA to apt:
"
sudo add-apt-repository -y ppa:webupd8team/java
echo "Update your apt package database:
"
sudo apt-get update -y --force-yes
echo "Install the latest stable version of Oracle Java 7 with this command (and accept the license agreement that pops up):
"
sudo apt-get -y install oracle-java7-installer
echo "Now that Java 7 is installed, let's install ElasticSearch.

Install Elasticsearch
Note: Logstash 1.4.2 recommends Elasticsearch 1.1.1.

Run the following command to import the Elasticsearch public GPG key into apt:
wget ...
"
echo "^C to break, anykey to contiue...";read readline

wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
echo "Create the Elasticsearch source list:
"
echo 'deb http://packages.elasticsearch.org/elasticsearch/1.1/debian stable main' | sudo tee /etc/apt/sources.list.d/elasticsearch.list
echo "Update your apt package database:
"
sudo apt-get update -y --force-yes
echo "Install Elasticsearch with this command:
"
sudo apt-get -y install elasticsearch=1.1.1
echo "Elasticsearch is now installed. Let's edit the configuration:
"
echo "Add the following line somewhere in the file, to disable dynamic scripts:
script.disable_dynamic: true
You will also want to restrict outside access to your Elasticsearch instance (port 9200), so outsiders can't read your data or shutdown your Elasticseach cluster through the HTTP API. Find the line that specifies network.host and uncomment it so it looks like this:

network.host: localhost
Save and exit elasticsearch.yml.
will do:
sudo vi /etc/elasticsearch/elasticsearch.yml

before next:Now start Elasticsearch:
"

sudo vi /etc/elasticsearch/elasticsearch.yml

sudo service elasticsearch restart
echo "
Then run the following command to start Elasticsearch on boot up:
"
sudo update-rc.d elasticsearch defaults 95 10

echo "
Now that Elasticsearch is up and running, let's install Kibana.

Install Kibana
Note: Logstash 1.4.2 recommends Kibana 3.0.1

Download Kibana to your home directory with the following command:
"

cd ~; wget https://download.elasticsearch.org/kibana/kibana/kibana-3.0.1.tar.gz
Extract Kibana archive with tar:

tar xvf kibana-3.0.1.tar.gz
echo "
Open the Kibana configuration file for editing:
will do:
sudo vi ~/kibana-3.0.1/config.js
In the Kibana configuration file, find the line that specifies the elasticsearch, and replace the port number (9200 by default) with 80:

   elasticsearch: "http://"+window.location.hostname+":80",
This is necessary because we are planning on accessing Kibana on port 80 (i.e. http://logstash_server_public_ip/).

We will be using Nginx to serve our Kibana installation, so let's move the files into an appropriate location. Create a directory with the following command:
"
echo "^C to break, anykey to contiue...";read readline
sudo vi ~/kibana-3.0.1/config.js

sudo mkdir -p /var/www/kibana3
echo "Now copy the Kibana files into your newly-created directory:
"
sudo cp -R ~/kibana-3.0.1/* /var/www/kibana3/
echo "Before we can use the Kibana web interface, we have to install Nginx. Let's do that now.

Install Nginx
Use apt to install Nginx:
"
sudo apt-get install nginx -y --force-yes
echo "
Because of the way that Kibana interfaces the user with Elasticsearch (the user needs to be able to access Elasticsearch directly), we need to configure Nginx to proxy the port 80 requests to port 9200 (the port that Elasticsearch listens to by default). Luckily, Kibana provides a sample Nginx configuration that sets most of this up.

Download the sample Nginx configuration from Kibana's github repository to your home directory:
"
cd ~; wget https://gist.githubusercontent.com/thisismitch/2205786838a6a5d61f55/raw/f91e06198a7c455925f6e3099e3ea7c186d0b263/nginx.conf

echo " next vi nginx.conf...
Open the sample configuration file for editing:
vi nginx.conf
"
echo "
Find and change the values of the server_name to your FQDN (or localhost if you aren't using a domain name) and root to where we installed Kibana, so they look like the following entries:

  server_name FQDN;
  root /var/www/kibana3;
Save and exit. Now copy it over your Nginx default server block with the following command:
"
vi nginx.conf
sudo cp nginx.conf /etc/nginx/sites-available/default
echo "
Now we will install apache2-utils so we can use htpasswd to generate a username and password pair:
"
sudo apt-get install apache2-utils -y --fore-yes
echo " 
Then generate a login that will be used in Kibana to save and share dashboards (substitute your own username):
"
sudo htpasswd -c /etc/nginx/conf.d/kibana.myhost.org.htpasswd user

echo "
Then enter a password and verify it. The htpasswd file just created is referenced in the Nginx configuration that you recently configured.

Now restart Nginx to put our changes into effect:
"
sudo service nginx restart

echo "
Kibana is now accessible via your FQDN or the public IP address of your Logstash Server i.e. http://logstash_server_public_ip/. If you go there in a web browser, you should see a Kibana welcome page which will allow you to view dashboards but there will be no logs to view because Logstash has not been set up yet. Let's do that now.

Install Logstash
The Logstash package is available from the same repository as Elasticsearch, and we already installed that public key, so let's create the Logstash source list:
"
echo 'deb http://packages.elasticsearch.org/logstash/1.4/debian stable main' | sudo tee /etc/apt/sources.list.d/logstash.list
echo "Update your apt package database:
"
sudo apt-get update -y --force-yes
echo "Install Logstash with this command:
"
sudo apt-get install logstash=1.4.2-1-2c0f5a1
echo "
Logstash is installed but it is not configured yet.

Generate SSL Certificates
Since we are going to use Logstash Forwarder to ship logs from our Servers to our Logstash Server, we need to create an SSL certificate and key pair. The certificate is used by the Logstash Forwarder to verify the identity of Logstash Server. Create the directories that will store the certificate and private key with the following commands:
"
sudo mkdir -p /etc/pki/tls/certs
sudo mkdir /etc/pki/tls/private
echo "Now you have two options for generating your SSL certificates. If you have a DNS setup that will allow your client servers to resolve the IP address of the Logstash Server, use Option 2. Otherwise, Option 1 will allow you to use IP addresses.

Option 1: IP Address

If you don't have a DNS setup—that would allow your servers, that you will gather logs from, to resolve the IP address of your Logstash Server—you will have to add your Logstash Server's private IP address to the subjectAltName (SAN) field of the SSL certificate that we are about to generate. To do so, open the OpenSSL configuration file:
"
sudo vi /etc/ssl/openssl.cnf

echo "
Find the [ v3_ca ] section in the file, and add this line under it (substituting in the Logstash Server's private IP address):

subjectAltName = IP: logstash_server_private_ip
Save and exit.

Now generate the SSL certificate and private key in the appropriate locations (/etc/pki/tls/), with the following commands:
"
cd /etc/pki/tls
sudo openssl req -config /etc/ssl/openssl.cnf -x509 -days 3650 -batch -nodes -newkey rsa:2048 -keyout private/logstash-forwarder.key -out certs/logstash-forwarder.crt

echo "
The logstash-forwarder.crt file will be copied to all of the servers that will send logs to Logstash but we will do that a little later. Let's complete our Logstash configuration. If you went with this option, skip option 2 and move on to Configure Logstash.

