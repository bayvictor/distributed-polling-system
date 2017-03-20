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

Option 2: FQDN (DNS)

If you have a DNS setup with your private networking, you should create an A record that contains the Logstash Server's private IP address—this domain name will be used in the next command, to generate the SSL certificate. Alternatively, you can use a record that points to the server's public IP address. Just be sure that your servers (the ones that you will be gathering logs from) will be able to resolve the domain name to your Logstash Server.

Now generate the SSL certificate and private key, in the appropriate locations (/etc/pki/tls/...), with the following command (substitute in the FQDN of the Logstash Server):

cd /etc/pki/tls; sudo openssl req -subj '/CN=logstash_server_fqdn/' -x509 -days 3650 -batch -nodes -newkey rsa:2048 -keyout private/logstash-forwarder.key -out certs/logstash-forwarder.crt
The logstash-forwarder.crt file will be copied to all of the servers that will send logs to Logstash but we will do that a little later. Let's complete our Logstash configuration.

Configure Logstash
Logstash configuration files are in the JSON-format, and reside in /etc/logstash/conf.d. The configuration consists of three sections: inputs, filters, and outputs.

Let's create a configuration file called 01-lumberjack-input.conf and set up our "lumberjack" input (the protocol that Logstash Forwarder uses):

sudo vi /etc/logstash/conf.d/01-lumberjack-input.conf
Insert the following input configuration:

input {
  lumberjack {
    port => 5000
    type => "logs"
    ssl_certificate => "/etc/pki/tls/certs/logstash-forwarder.crt"
    ssl_key => "/etc/pki/tls/private/logstash-forwarder.key"
  }
}
Save and quit. This specifies a lumberjack input that will listen on tcp port 5000, and it will use the SSL certificate and private key that we created earlier.

Now let's create a configuration file called 10-syslog.conf, where we will add a filter for syslog messages:

sudo vi /etc/logstash/conf.d/10-syslog.conf
Insert the following syslog filter configuration:

filter {
  if [type] == "syslog" {
    grok {
      match => { "message" => "%{SYSLOGTIMESTAMP:syslog_timestamp} %{SYSLOGHOST:syslog_hostname} %{DATA:syslog_program}(?:\[%{POSINT:syslog_pid}\])?: %{GREEDYDATA:syslog_message}" }
      add_field => [ "received_at", "%{@timestamp}" ]
      add_field => [ "received_from", "%{host}" ]
    }
    syslog_pri { }
    date {
      match => [ "syslog_timestamp", "MMM  d HH:mm:ss", "MMM dd HH:mm:ss" ]
    }
  }
}
Save and quit. This filter looks for logs that are labeled as "syslog" type (by a Logstash Forwarder), and it will try to use "grok" to parse incoming syslog logs to make it structured and query-able.

Lastly, we will create a configuration file called 30-lumberjack-output.conf:

sudo vi /etc/logstash/conf.d/30-lumberjack-output.conf
Insert the following output configuration:

output {
  elasticsearch { host => localhost }
  stdout { codec => rubydebug }
}
Save and exit. This output basically configures Logstash to store the logs in Elasticsearch.

With this configuration, Logstash will also accept logs that do not match the filter, but the data will not be structured (e.g. unfiltered Nginx or Apache logs would appear as flat messages instead of categorizing messages by HTTP response codes, source IP addresses, served files, etc.).

If you want to add filters for other applications that use the Logstash Forwarder input, be sure to name the files so they sort between the input and the output configuration (i.e. between 01 and 30).

Restart Logstash to put our configuration changes into effect:

sudo service logstash restart
Now that our Logstash Server is ready, let's move onto setting up Logstash Forwarder.

Set Up Logstash Forwarder
Note: Do these steps for each server that you want to send logs to your Logstash Server. For instructions on installing Logstash Forwarder on Red Hat-based Linux distributions (e.g. RHEL, CentOS, etc.), refer to the Build and Package Logstash Forwarder section of the CentOS variation of this tutorial.

Copy SSL Certificate and Logstash Forwarder Package

On Logstash Server, copy the SSL certificate to Server (substitute with your own login):

scp /etc/pki/tls/certs/logstash-forwarder.crt user@server_private_IP:/tmp
Install Logstash Forwarder Package

On Server, create the Logstash Forwarder source list:

echo 'deb http://packages.elasticsearch.org/logstashforwarder/debian stable main' | sudo tee /etc/apt/sources.list.d/logstashforwarder.list
It also uses the same GPG key as Elasticsearch, which can be installed with this command:

wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
Then install the Logstash Forwarder package:

sudo apt-get update
sudo apt-get install logstash-forwarder
Note: If you are using a 32-bit release of Ubuntu, and are getting an "Unable to locate package logstash-forwarder" error, you will need to install Logstash Forwarder manually:

wget https://assets.digitalocean.com/articles/logstash/logstash-forwarder_0.3.1_i386.deb
sudo dpkg -i logstash-forwarder_0.3.1_i386.deb
Next, you will want to install the Logstash Forwarder init script, so it starts on bootup:

cd /etc/init.d/; sudo wget https://raw.githubusercontent.com/elasticsearch/logstash-forwarder/a73e1cb7e43c6de97050912b5bb35910c0f8d0da/logstash-forwarder.init -O logstash-forwarder
sudo chmod +x logstash-forwarder
sudo update-rc.d logstash-forwarder defaults
Now copy the SSL certificate into the appropriate location (/etc/pki/tls/certs):

sudo mkdir -p /etc/pki/tls/certs
sudo cp /tmp/logstash-forwarder.crt /etc/pki/tls/certs/
Configure Logstash Forwarder

On Server, create and edit Logstash Forwarder configuration file, which is in JSON format:

sudo vi /etc/logstash-forwarder
Now add the following lines into the file, substituting in your Logstash Server's private IP address for logstash_server_private_IP:

{
  "network": {
    "servers": [ "logstash_server_private_IP:5000" ],
    "timeout": 15,
    "ssl ca": "/etc/pki/tls/certs/logstash-forwarder.crt"
  },
  "files": [
    {
      "paths": [
        "/var/log/syslog",
        "/var/log/auth.log"
       ],
      "fields": { "type": "syslog" }
    }
   ]
}
Save and quit. This configures Logstash Forwarder to connect to your Logstash Server on port 5000 (the port that we specified an input for earlier), and uses the SSL certificate that we created earlier. The paths section specifies which log files to send (here we specify syslog and auth.log), and the type section specifies that these logs are of type "syslog* (which is the type that our filter is looking for).

Note that this is where you would add more files/types to configure Logstash Forwarder to other log files to Logstash on port 5000.

Now restart Logstash Forwarder to put our changes into place:

sudo service logstash-forwarder restart
Now Logstash Forwarder is sending syslog and auth.log to your Logstash Server! Repeat this process for all of the other servers that you wish to gather logs for.

Connect to Kibana
When you are finished setting up Logstash Forwarder on all of the servers that you want to gather logs for, let's look at Kibana, the web interface that we installed earlier.

In a web browser, go to the FQDN or public IP address of your Logstash Server. You should see a Kibana welcome page.

Click on Logstash Dashboard to go to the premade dashboard. You should see a histogram with log events, with log messages below (if you don't see any events or messages, one of your four Logstash components is not configured properly).

Here, you can search and browse through your logs. You can also customize your dashboard. This is a sample of what your Kibana instance might look like:

Kibana 3 Example Dashboard

Try the following things:

Search for "root" to see if anyone is trying to log into your servers as root
Search for a particular hostname
Change the time frame by selecting an area on the histogram or from the menu above
Click on messages below the histogram to see how the data is being filtered
Kibana has many other features, such as graphing and filtering, so feel free to poke around!

Conclusion
Now that your syslogs are centralized via Logstash, and you are able to visualize them with Kibana, you should be off to a good start with centralizing all of your important logs. Remember that you can send pretty much any type of log to Logstash, but the data becomes even more useful if it is parsed and structured with grok.

Note that your Kibana dashboard is accessible to anyone who can access your server, so you will want to secure it with something like htaccess.


Heart
46
Subscribe
 Share
manicas 
Author:
Mitchell Anicas
Spin up an SSD cloud server in under a minute.
Simple setup. Full root access. Straightforward pricing.
DEPLOY SERVER
Related Tutorials
Installing WordPress on Ajenti V
Creating a Website and an Email Account on Ajenti V
How to Install the Ajenti Control Panel and Ajenti V on Ubuntu 14.04
How To Install and Configure AppScale on Ubuntu 12.04
How to Install the Munin Monitoring Tool on Debian 8
185 Comments
BIULOLLinkCodeHighlightTable

Log In to Comment
puneetbrar
puneetbrar June 13, 2014
Great Tutorial but wanted configuration for apache2 ssl_access logs and also  error logs as well as auth log and mysql slow query and generel logs can you please add that also
 Reply
asb
asbMOD June 13, 2014
@puneetbrar: You need to add them to the files section in /etc/logstash-forwarder It would look like: 
  "files": [
    {
      "paths": [
        "/var/log/syslog",
        "/var/log/auth.log"
       ],
      "fields": { "type": "syslog" }
    },
    {
      "paths": [ "/var/log/apache2/*.log" ],
      "fields": { "type": "apache" }
    }
   ]
 Reply
puneetbrar
puneetbrar June 16, 2014
But if i have different servers how will i differentiate between the logs  on kibana
 Reply
asb
asbMOD June 16, 2014
@puneetbrar: Check out the section where we set up a filter in the tutorial. You'll want to add something along the lines of: 
 add_field => [ "received_from", "%{host}" ]
 Reply
crawfishmedia
crawfishmedia June 20, 2014
Great tutorial, until 'sudo gem install fpm' failed to install. Not sure where I went wrong.  Building native extensions. This could take a while... ERROR: Error installing fpm: ERROR: Failed to build gem native extension.  /usr/bin/ruby1.9.1 extconf.rb  Gem files will remain installed in /var/lib/gems/1.9.1/gems/json-1.8.1 for inspection.
 Reply
samuel.leach
samuel.leach June 20, 2014
Could you also advise on the corresponding /etc/logstash/conf.d/10-syslog.conf and /etc/logstash-forwarder additions to monitor the nginx web server access logs? That would be really appreciated.
 Reply
manicas
manicasMOD June 20, 2014
@crawfishmedia: Is that the entire output? Be sure to install the "ruby-dev" package (sudo apt-get install ruby-dev), not just "ruby".
 Reply
50ec1b6b1358c029d0bb40c41c6910cc4c0d7177
enrahmad February 6, 2015
I'm sorry
FYI
https://github.com/elasticsearch/logstash/issues/2292

Note: Logstash 1.4.2 recommends Elasticsearch 1.1.1.

manicas
manicasMOD June 20, 2014
@samuel.leach: To add Nginx logs to Logstash, do the following.  On your Nginx server, edit your logstash-forwarder config file and send the nginx access.log by modifying the "files" section so it looks like this:  
"files": [
    {
      "paths": [
        "/var/log/syslog",
        "/var/log/auth.log"
       ],
      "fields": { "type": "syslog" }
    },
    {
      "paths": [
        "/var/log/nginx/*access*.log",
       ],
      "fields": { "type": "nginx" }
    }
   ]
  Then restart the logstash forwarder. Then on your Logstash server, open a file called "nginx" in /opt/logstash/patterns:  
sudo vi /opt/logstash/patterns/nginx
  Then insert the following:  
NGUSERNAME [a-zA-Z\.\@\-\+_%]+
NGUSER %{NGUSERNAME}
NGINXACCESS %{IPORHOST:clientip} %{NGUSER:ident} %{NGUSER:auth} \[%{HTTPDATE:timestamp}\] "%{WORD:verb} %{URIPATHPARAM:request} HTTP/%{NUMBER:httpversion}" %{NUMBER:response} (?:%{NUMBER:bytes}|-) (?:"(?:%{URI:referrer}|-)"|%{QS:referrer}) %{QS:agent}
  Save and quit. Then change the ownership of the file to logstash:  
chown logstash: /opt/logstash/patterns/nginx
  Then edit your /etc/logstash/conf.d/10-syslog.conf file, and add the following filter under your first filter (syslog):  
filter {
  if [type] == "nginx" {
    grok {
      match => { "message" => "%{NGINXACCESS}" }
    }
  }
}
  Then restart Logstash.
 Reply
wh
wh June 20, 2014
Great write up, but unless I missed something, you should maybe add a line asking the user to change into their home directory before doing the git pull for the logstash forwarder, otherwise the contents of the repo are installed in /etc/pki/tls (not ideal)
 Reply
samuel.leach
samuel.leach June 20, 2014
@manicas Thank you!
 Reply
manicas
manicasMOD June 21, 2014
@wh: Thanks! I edited it.
 Reply
puneetbrar
puneetbrar June 21, 2014
Hi astarr  can you please let me know in the host do i need to specify the ip address something like  add_field => [ "received_from", "%{192.168.x.x}" ] 
 Reply
crawfishmedia
crawfishmedia June 21, 2014
@manicas Sorry for being a pita but I installed everything line by line as per the tutorial. I created a script with all these commands so I wouldn't miss anything. I have performed this tutorial several times on fresh ubuntu droplets and cannot finished the install.  When I run "sudo apt-get install ruby-dev" I get this: Reading package lists... Done Building dependency tree Reading state information... Done ruby is already the newest version. ruby-dev is already the newest version. 0 upgraded, 0 newly installed, 0 to remove and 3 not upgraded.
 Reply
manicas
manicasMOD June 23, 2014
@crawfishmedia: The only way I have been able to reproduce a similar error is if I do not install ruby-dev (and the error has more details than the one you posted earlier). Did you update apt?
 Reply
agentbullvi
agentbullvi June 24, 2014
golang is now in the trusty universe repo. You no longer need to add the golang ppa.
 Reply
cryo_hybrid
cryo_hybrid June 24, 2014
hello, as far as i reach the point to verify nginx+kibana is working well and try to access http://some.ip.over.there i get almost blank page with title " {{dashboard.current.title}}".

could you please point me to the right direction?
tnx!
 Reply
manicas
manicasMOD June 24, 2014
@cryo_hybrid: most likely an error in your Kibana config.js file
 Reply
jeremy.kendall
jeremy.kendall June 24, 2014
I've installed logstash-forwarder on two servers, but kibana/elasticsearch are only displaying logs from the first server I configured. I've verified the second server is shipping logs to the correct IP by tailing /var/log/syslog, and it shows "Registrar received n events". Any thoughts?
 Reply
manicas
manicasMOD June 24, 2014
@jeremy.kendall: did you install the SSL certs on the second server?
 Reply
555john
555john June 27, 2014
I can't seem to get LogStash to pick up my logs with this setup. I've changed "/etc/logstash/conf.d/10-syslog.conf" to be to be the snippit below but nothing shows up in Kibana:

input 
{ 
    file 
        {
            path => "/var/log/nginx/**"
            start_position => beginning 
        } 
    file 
        { 
            path => [ "/var/log/*.log", "/var/log/messages", "/var/log/syslog" ] 
            start_position => beginning 
        } 
} 
output 
{ 
    elasticsearch { host => localhost } 
}

However, this runs fine and picks up my logs.

sudo /opt/logstash/bin/logstash -f /etc/logstash/conf.d/10-syslog.conf
I've groked the /etc/init.d/logstash and my conf location looks good, any ideas on what could be wrong?
 Reply
Load More Comments
Creative Commons License
This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
Copyright © 2015 DigitalOcean™ Inc.
Community Tutorials Questions Projects Tags  
Terms, Privacy, & Copyright Security Get Paid to Write
SCROLL TO TOP
