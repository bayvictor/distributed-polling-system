echo "How To Install Elasticsearch, Logstash, and Kibana 4 on Ubuntu 14.04
Tags: Logging, Nginx, Monitoring Distribution: Ubuntu
Tutorial Series
This tutorial is part 1 of 4 in the series: Centralized Logging with Logstash and Kibana On Ubuntu 14.04
Introduction
"
echo "^C to break, anykey to contiue...";read readline

echo "
In this tutorial, we will go over the installation of the Elasticsearch ELK Stack on Ubuntu 14.04—that is, Elasticsearch 1.4.4, Logstash 1.5.0, and Kibana 4. We will also show you how to configure it to gather and visualize the syslogs of your systems in a centralized location. Logstash is an open source tool for collecting, parsing, and storing logs for future use. Kibana 4 is a web interface that can be used to search and view the logs that Logstash has indexed. Both of these tools are based on Elasticsearch.

Centralized logging can be very useful when attempting to identify problems with your servers or applications, as it allows you to search through all of your logs in a single place. It is also useful because it allows you to identify issues that span multiple servers by correlating their logs during a specific time frame.

It is possible to use Logstash to gather logs of all types, but we will limit the scope of this tutorial to syslog gathering.

Our Goal
The goal of the tutorial is to set up Logstash to gather syslogs of multiple servers, and set up Kibana to visualize the gathered logs.
"

echo "^C to break, anykey to contiue...";read readline

echo "

Our Logstash / Kibana setup has four main components:

Logstash: The server component of Logstash that processes incoming logs
Elasticsearch: Stores all of the logs
Kibana: Web interface for searching and visualizing logs, which will be proxied through Nginx
Logstash Forwarder: Installed on servers that will send their logs to Logstash, Logstash Forwarder serves as a log forwarding agent that utilizes the lumberjack networking protocol to communicate with Logstash
We will install the first three components on a single server, which we will refer to as our Logstash Server. The Logstash Forwarder will be installed on all of the client servers that we want to gather logs for, which we will refer to collectively as our Client Servers.

Prerequisites
To complete this tutorial, you will require root access to an Ubuntu 14.04 VPS. Instructions to set that up can be found here (steps 3 and 4): Initial Server Setup with Ubuntu 14.04.

If you would prefer to use CentOS instead, check out this tutorial: How To Install ELK on CentOS 7.

The amount of CPU, RAM, and storage that your Logstash Server will require depends on the volume of logs that you intend to gather. For this tutorial, we will be using a VPS with the following specs for our Logstash Server:

OS: Ubuntu 14.04
RAM: 4GB
CPU: 2
In addition to your Logstash Server, you will want to have a few other servers that you will gather logs from.

Let's get started on setting up our Logstash Server!
"

echo "^C to break, anykey to contiue...";read readline

echo "

Install Java 8
Elasticsearch and Logstash require Java, so we will install that now. We will install Oracle Java 8 (update 20 or later) because that is what Elasticsearch recommends. It should, however, work fine with OpenJDK, if you decide to go that route.

Add the Oracle Java PPA to apt:
"

echo "^C to break, anykey to contiue...";read readline


sudo add-apt-repository -y ppa:webupd8team/java

echo "Update your apt package database:
"
sudo apt-get update
echo "^C to break, anykey to contiue...";read readline

echo "
Install the latest stable version of Oracle Java 8 with this command (and accept the license agreement that pops up):
"
sudo apt-get -y install oracle-java8-installer

echo "^C to break, anykey to contiue...";read readline

echo "
Now that Java 8 is installed, let's install ElasticSearch.

Install Elasticsearch
Run the following command to import the Elasticsearch public GPG key into apt:
"
wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -

echo "^C to break, anykey to contiue...";read readline

echo "

If your prompt is just hanging there, it is probably waiting for your user's password (to authorize the sudo command). If this is the case, enter your password.

Create the Elasticsearch source list:
"

echo 'deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main' | sudo tee /etc/apt/sources.list.d/elasticsearch.list


echo "
Update your apt package database:
"
sudo apt-get update
echo "Install Elasticsearch with this command:
"
sudo apt-get -y install elasticsearch=1.4.4

echo "Elasticsearch is now installed. Let's edit the configuration:
"
sudo vi /etc/elasticsearch/elasticsearch.yml

echo "
You will want to restrict outside access to your Elasticsearch instance (port 9200), so outsiders can't read your data or shutdown your Elasticsearch cluster through the HTTP API. Find the line that specifies network.host, uncomment it, and replace its value with \"localhost\" so it looks like this:

elasticsearch.yml excerpt (updated)
network.host: localhost
Save and exit elasticsearch.yml.

Now start Elasticsearch: "
echo "^C to break, anykey to contiue...";read readline

echo "
"
sudo service elasticsearch restart
echo "Then run the following command to start Elasticsearch on boot up:
"
sudo update-rc.d elasticsearch defaults 95 10
echo "Now that Elasticsearch is up and running, let's install Kibana.

Install Kibana
Download Kibana 4 to your home directory with the following command:
"
cd ~; wget https://download.elasticsearch.org/kibana/kibana/kibana-4.0.1-linux-x64.tar.gz
echo "Extract Kibana archive with tar:
"
tar xvf kibana-*.tar.gz
echo "Open the Kibana configuration file for editing:
"
echo "In the Kibana configuration file, find the line that specifies host, and replace the IP address (\"0.0.0.0\" by default) with \"localhost\":

kibana.yml excerpt (updated)
host: \"localhost\"
Save and exit. This setting makes it so Kibana will only be accessible to the localhost. This is fine because we will use an Nginx reverse proxy to allow external access.
"
vi ~/kibana-4*/config/kibana.yml

echo "Let's copy the Kibana files to a more appropriate location. Create the /opt directory with the following command:
"
sudo mkdir -p /opt/kibana
echo "Now copy the Kibana files into your newly-created directory:
"
sudo cp -R ~/kibana-4*/* /opt/kibana/

echo "Kibana can be started by running /opt/kibana/bin/kibana, but we want it to run as a service. Download a Kibana init script with this command:
"
cd /etc/init.d && sudo wget https://gist.githubusercontent.com/thisismitch/8b15ac909aed214ad04a/raw/bce61d85643c2dcdfbc2728c55a41dab444dca20/kibana4

echo "Now enable the Kibana service, and start it:
"
sudo chmod +x /etc/init.d/kibana4
sudo update-rc.d kibana4 defaults 96 9
sudo service kibana4 start

echo "Before we can use the Kibana web interface, we have to set up a reverse proxy. Let's do that now, with Nginx.

Install Nginx
Because we configured Kibana to listen on localhost, we must set up a reverse proxy to allow external access to it. We will use Nginx for this purpose.

Note: If you already have an Nginx instance that you want to use, feel free to use that instead. Just make sure to configure Kibana so it is reachable by your Nginx server (you probably want to change the host value, in /opt/kibana/config/kibana.yml, to your Kibana server's private IP address or hostname). Also, it is recommended that you enable SSL/TLS.

Use apt to install Nginx and Apache2-utils:
"

sudo apt-get install nginx apache2-utils
Use htpasswd to create an admin user, called "kibanaadmin" (you should use another name), that can access the Kibana web interface:

sudo htpasswd -c /etc/nginx/htpasswd.users kibanaadmin
Enter a password at the prompt. Remember this login, as you will need it to access the Kibana web interface.

echo "Now open the Nginx default server block in your favorite editor. We will use vi:
"
sudo vi /etc/nginx/sites-available/default
echo "Delete the file's contents, and paste the following code block into the file. Be sure to update the server_name to match your server's name:
"
/etc/nginx/sites-available/default
server {
    listen 80;

    server_name example.com;

    auth_basic "Restricted Access";
    auth_basic_user_file /etc/nginx/htpasswd.users;

    location / {
        proxy_pass http://localhost:5601;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;        
    }
}
Save and exit. This configures Nginx to direct your server's HTTP traffic to the Kibana application, which is listening on localhost:5601. Also, Nginx will use the htpasswd.users file, that we created earlier, and require basic authentication.

Now restart Nginx to put our changes into effect:

sudo service nginx restart
Kibana is now accessible via your FQDN or the public IP address of your Logstash Server i.e. http://logstash_server_public_ip/. If you go there in a web browser, after entering the "kibanaadmin" credentials, you should see a Kibana welcome page which will ask you to configure an index pattern. Let's get back to that later, after we install all of the other components.

Install Logstash
The Logstash package is available from the same repository as Elasticsearch, and we already installed that public key, so let's create the Logstash source list:

echo 'deb http://packages.elasticsearch.org/logstash/1.5/debian stable main' | sudo tee /etc/apt/sources.list.d/logstash.list
Update your apt package database:

sudo apt-get update
Install Logstash with this command:

sudo apt-get install logstash
Logstash is installed but it is not configured yet.

Generate SSL Certificates
Since we are going to use Logstash Forwarder to ship logs from our Servers to our Logstash Server, we need to create an SSL certificate and key pair. The certificate is used by the Logstash Forwarder to verify the identity of Logstash Server. Create the directories that will store the certificate and private key with the following commands:

sudo mkdir -p /etc/pki/tls/certs
sudo mkdir /etc/pki/tls/private
Now you have two options for generating your SSL certificates. If you have a DNS setup that will allow your client servers to resolve the IP address of the Logstash Server, use Option 2. Otherwise, Option 1 will allow you to use IP addresses.

Option 1: IP Address

If you don't have a DNS setup—that would allow your servers, that you will gather logs from, to resolve the IP address of your Logstash Server—you will have to add your Logstash Server's private IP address to the subjectAltName (SAN) field of the SSL certificate that we are about to generate. To do so, open the OpenSSL configuration file:

sudo vi /etc/ssl/openssl.cnf
Find the [ v3_ca ] section in the file, and add this line under it (substituting in the Logstash Server's private IP address):

openssl.cnf excerpt (updated)
subjectAltName = IP: logstash_server_private_ip
Save and exit.

Now generate the SSL certificate and private key in the appropriate locations (/etc/pki/tls/), with the following commands:

cd /etc/pki/tls
sudo openssl req -config /etc/ssl/openssl.cnf -x509 -days 3650 -batch -nodes -newkey rsa:2048 -keyout private/logstash-forwarder.key -out certs/logstash-forwarder.crt
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

01-lumberjack-input.conf
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

10-syslog.conf
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

30-syslog.conf
output {
  elasticsearch { host => localhost }
  stdout { codec => rubydebug }
}
Save and exit. This output basically configures Logstash to store the logs in Elasticsearch.

With this configuration, Logstash will also accept logs that do not match the filter, but the data will not be structured (e.g. unfiltered Nginx or Apache logs would appear as flat messages instead of categorizing messages by HTTP response codes, source IP addresses, served files, etc.).

If you want to add filters for other applications that use the Logstash Forwarder input, be sure to name the files so they sort between the input and the output configuration (i.e. between 01- and 30-).

Restart Logstash to put our configuration changes into effect:

sudo service logstash restart
Now that our Logstash Server is ready, let's move onto setting up Logstash Forwarder.

Set Up Logstash Forwarder (Add Client Servers)
Do these steps for each Ubuntu or Debian server that you want to send logs to your Logstash Server. For instructions on installing Logstash Forwarder on Red Hat-based Linux distributions (e.g. RHEL, CentOS, etc.), refer to the Build and Package Logstash Forwarder section of the CentOS variation of this tutorial.

Copy SSL Certificate and Logstash Forwarder Package

On Logstash Server, copy the SSL certificate to Client Server (substitute the client server's address, and your own login):

scp /etc/pki/tls/certs/logstash-forwarder.crt user@client_server_private_address:/tmp
After providing your login's credentials, ensure that the certificate copy was successful. It is required for communication between the client servers and the Logstash server.

Install Logstash Forwarder Package

On Client Server, create the Logstash Forwarder source list:

echo 'deb http://packages.elasticsearch.org/logstashforwarder/debian stable main' | sudo tee /etc/apt/sources.list.d/logstashforwarder.list
It also uses the same GPG key as Elasticsearch, which can be installed with this command:

wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
Then install the Logstash Forwarder package:

sudo apt-get update
sudo apt-get install logstash-forwarder
Note: If you are using a 32-bit release of Ubuntu, and are getting an "Unable to locate package logstash-forwarder" error, you will need to install Logstash Forwarder manually.

Now copy the Logstash server's SSL certificate into the appropriate location (/etc/pki/tls/certs):

sudo mkdir -p /etc/pki/tls/certs
sudo cp /tmp/logstash-forwarder.crt /etc/pki/tls/certs/
Configure Logstash Forwarder

On Client Server, create and edit Logstash Forwarder configuration file, which is in JSON format:

sudo vi /etc/logstash-forwarder.conf
Under the network section, add the following lines into the file, substituting in your Logstash Server's private address for logstash_server_private_address:

logstash-forwarder.conf excerpt 1 of 2
    "servers": [ "logstash_server_private_address:5000" ],
    "timeout": 15,
    "ssl ca": "/etc/pki/tls/certs/logstash-forwarder.crt"
Under the files section (between the square brackets), add the following lines,

logstash-forwarder.conf excerpt 2 of 2
    {
      "paths": [
        "/var/log/syslog",
        "/var/log/auth.log"
       ],
      "fields": { "type": "syslog" }
    }
Save and quit. This configures Logstash Forwarder to connect to your Logstash Server on port 5000 (the port that we specified an input for earlier), and uses the SSL certificate that we created earlier. The paths section specifies which log files to send (here we specify syslog and auth.log), and the type section specifies that these logs are of type "syslog* (which is the type that our filter is looking for).

Note that this is where you would add more files/types to configure Logstash Forwarder to other log files to Logstash on port 5000.

Now restart Logstash Forwarder to put our changes into place:

sudo service logstash-forwarder restart
Now Logstash Forwarder is sending syslog and auth.log to your Logstash Server! Repeat this section for all of the other servers that you wish to gather logs for.

Connect to Kibana
When you are finished setting up Logstash Forwarder on all of the servers that you want to gather logs for, let's look at Kibana, the web interface that we installed earlier.

In a web browser, go to the FQDN or public IP address of your Logstash Server. After entering the "kibanaadmin" credentials, you should see a page prompting you to configure an index pattern:

Create index

Go ahead and select @timestamp from the dropdown menu, then click the Create button to create the first index.

Now click the Discover link in the top navigation bar. By default, this will show you all of the log data over the last 15 minutes. You should see a histogram with log events, with log messages below:

Discover page

Right now, there won't be much in there because you are only gathering syslogs from your client servers. Here, you can search and browse through your logs. You can also customize your dashboard.

Try the following things:

Search for "root" to see if anyone is trying to log into your servers as root
Search for a particular hostname (search for host: "hostname")
Change the time frame by selecting an area on the histogram or from the menu above
Click on messages below the histogram to see how the data is being filtered
Kibana has many other features, such as graphing and filtering, so feel free to poke around!

Conclusion
Now that your syslogs are centralized via Elasticsearch and Logstash, and you are able to visualize them with Kibana 4, you should be off to a good start with centralizing all of your important logs. Remember that you can send pretty much any type of log to Logstash, but the data becomes even more useful if it is parsed and structured with grok.

To improve your new ELK stack, you should look into gathering and filtering your other logs with Logstash, and creating Kibana dashboards. These topics are covered in the second and third tutorials in this series.

Scroll down for links to learn more about using your ELK stack!


Heart
74
Subscribe
 Share
manicas
 
Author:
Mitchell Anicas
Tutorial Series
Centralized Logging with Logstash and Kibana On Ubuntu 14.04
Centralized logging can be very useful when attempting to identify problems with your servers or applications, as it allows you to search through all of your logs in a single place. It is also useful because it allows you to identify issues that span multiple servers by correlating their logs during a specific time frame. This series will teach you how to install Logstash and Kibana on Ubuntu, then how to add more filters to structure your log data. Then it will teach you how to use Kibana.
How To Install Elasticsearch, Logstash, and Kibana 4 on Ubuntu 14.04 March 9, 2015
 74   189  By Mitchell Anicas
Adding Logstash Filters To Improve Centralized Logging July 3, 2014
 12   42  By Mitchell Anicas
How To Use Kibana Dashboards and Visualizations March 11, 2015
 15   31  By Mitchell Anicas
How To Map User Location with GeoIP and ELK (Elasticsearch, Logstash, and Kibana) March 30, 2015
 12   3  By Mitchell Anicas
Spin up an SSD cloud server in under a minute.
Simple setup. Full root access. Straightforward pricing.
DEPLOY SERVER
Related Tutorials
How To Use Kibana Dashboards and Visualizations
How To Install and Use Logwatch Log Analyzer and Reporter on a VPS
Writing Custom System Audit Rules on CentOS 7
Understanding the Linux Auditing System on CentOS 7
How to Detect Anomalies with Skyline on CentOS 7
179 Comments
BIULOLLinkCodeHighlightTable

Log In to Comment
timppanius
timppanius March 11, 2015
Use htpasswd to create an admin user, called "kibanaadmin" (you should use another name), that can access the Nagios web interface:

Suddenly wild Nagios appears?-)
1
manicas
manicas March 11, 2015
Haha. Yeah, I was writing a Nagios tutorial at the same time. Fixed!
2
jplamoureux
jplamoureux March 11, 2015
I did this tutorial, every commands are working fine, excepting that at the end of server(client) part, when i execute the "sudo service logstash-forwarder restart" it tells me that the service is started but when i look at "service logstash-forwarder status" it tells me that logstash-forwarder is not running. Any ideas of how to make it run. All 3 services are started on the logstash server. I can "telnet logstashserverIP 5000" from the client. I had the same problem with the last version of this tutorial. When I log in into the web interface of kibana I don't get any log into it. Because of that I can't configure the configure pattern into kibana.

manicas
manicas March 11, 2015
Run this command on the client server:

tail -f /var/log/logstash-forwarder/logstash-forwarder.err

It is likely due to your SSL certificate or a problem with the logstash forwarder configuration file.

jplamoureux
jplamoureux March 11, 2015
the result of the command " tail -f /var/log/logstash-forwarder/logstash-forwarder.err" is:

}

2015/03/11 09:47:17.212855 Failed unmarshalling json: invalid character '"' after object key:value pair
2015/03/11 09:47:17.212871 Could not load config file /etc/logstash-forwarder.conf: invalid character '"' after object key:value pair

This is effectively a problem from the config file! Thank you

jplamoureux
jplamoureux March 11, 2015
I know that is not covered by the tutorial but is it possible to send a directory of log instead of just a single file at a time? and How long the log are kept by the logstash server?

manicas
manicas March 11, 2015
You can use wildcards to ship multiple files with Logstash Forwarder, e.g. "/var/log/*.log".

By default, there is no data retention policy (i.e. everything is kept forever, until you delete it). There are a few options for dealing with this:

Elasticsearch indices are stored in separate directories by day. See /var/lib/elasticsearch/elasticsearch/nodes/0/indices. You can set up a process to rotate out (delete) the indices that you don't want anymore.
Curator
Setting TTLs on your data in Elasticsearch
1
ezudin
ezudin April 2, 2015
I had the same error as jplamoureux (.../etc/logstash-forwarder.conf: invalid character '"' after object key:value pair) and resolved it with the help of http://www.logstashbook.com/TheLogstashBook_sample.pdf#34
1
thingy
thingy March 11, 2015
Hi Mitchell,
Thanks for putting this together.
Any idea how you send the output from Logstash to a remote Elasticsearch server?
Your example just has localhost, but we've got three separate server, one with Logstash, one with Elasticsearch and another with Kibana on it.
However I can't work out how to send the output from Logstash over to the Elasticsearch setup on a different server.

Cheers!

manicas
manicas March 11, 2015
Not sure of your exact setup, but basically you will need to configure the following:

Elasticsearch (elasticsearch.yml) to listen on an address (network.host: ES_private_IP) that is accessible to Logstash and Kibana
Kibana configuration (kibana.yml) elasticsearch_url should be set to Elasticsearch's listening IP/port (elasticsearch_url: "http://ES_private_IP:9200")
Obviously, you need to update your proxy configuration to point to Kibana (unless you're running Nginx on the same server as Kibana)
Logstash needs its output configured to point to the Elasticsearch server (30-lumberjack-output.conf)

thingy
thingy March 12, 2015
Right you are, I'll have a nosey and let you know how it goes. Thanks for that!

EDIT : 
Mmmmm, still not sure.
If I explain what we've got, it might help.
We've got hundreds of physical servers all monitored by Nagios & Zenoss in a private setup, no public access at all.
The logs we're wanting to monitor/search are normal syslog outputs, so no web traffic and therefore no need for a proxy.

I'm investigating using an ELK stack, and so I've got three physical servers, each dedicated to the E, L and K (ignoring virtualisation, failover, etc for the moment as this is a prototype and we've got the spare kit).
If I change the 'localhost' entry in the logstash.conf file to be either an IP address or a DNS entry, then logstash complains and says 'did I know that --configtest was available'.
So really, the question is how I get logstash to log 'stuff' to elasicsearch that's on a totally different server.
(It's fine if I bung everything on one box and stick with localhost, but that defeats the point about separating things to different machines - which will be pertinent further down the line...)

Sorry to be a pain.

thingy
thingy March 12, 2015
[deleted]

thingy
thingy March 12, 2015
EDIT 2 : (Can't seem to reply to the bottom bit, only this reply - oh well....)

SOLVED : I just put the hostname in quotes and 'stuff' started appearing on the elasticsearch host from the syslogs perfectly fine - all good now.
1
mayuriwavhal
mayuriwavhal March 12, 2015
Nice Tutorial !!!!
Being new comer in software field, find this easy to work with. And my concept got clear.....
Thank you for proper formatting it.
The only issue i was facing is my server's and client's IP getting changed after some time interval. Can you please guide me to make it static in proper way.
Because my /etc/network/interfaces file has only following lines:
auto lo
iface lo inet loopback

manicas
manicas March 13, 2015
In the interfaces file, static IPs are defined like this (these IP addresses/masks are examples):

auto eth0
iface eth0 inet static
        address 100.200.100.50
        netmask 255.255.255.0
        gateway 100.200.100.1
        dns-nameservers 8.8.8.8 8.8.4.4

Mlewis
Mlewis March 13, 2015
I've been looking for a tutorial like this, so I was really glad to find it.

The problem I have is the forwarder can't connect. From what I understand I should find that once I've completed the steps regarding the files in /etc/logstash/conf.d I should find kibana listening for connection attempts on port 5000. This doesn't happen and the error log on the forwarder confirms this saying the connection was refused.
A netstat -aon confirms nothing listening on 5000 but I do see port 5601 which is the backend port in the kibana yml file.

Any ideas?

manicas
manicas March 13, 2015
It sounds like Logstash is misconfigured (and not running).

Check if it's running with ps -ef | grep [l]ogstash.

Also, check the logs (/var/log/logstash).

Mlewis
Mlewis March 13, 2015
Hi Thanks for the reply.

Yes logstash had stopped somewhere along the line but even once it was started I had the same problem. However after removing the init.d script and readding (i'm not sure why I even done this in the first place) it now is working as expected.

I hate it when the resolution makes no sense, feels more like luck.

manicas
manicas March 13, 2015
Maybe the init script didn't have execute permissions.

kiriklax
kiriklax March 13, 2015
Thanks for the tutorial.

Unfortunately I have a problem with Kibana. I can't create any index because the button is gray and says "Unable to fetch mapping. Do you have indices matching the pattern?".

Any idea?

manicas
manicas March 14, 2015
You Logstash Forwarder is likely misconfigured, or there is a problem with the certificate. That is, your logs are not being shipped to Logstash.

Check the Logstash Forwarder error logs: tail -f /var/log/logstash-forwarder/logstash-forwarder.err

Press Control-C to quit the tail.

kiriklax
kiriklax March 16, 2015
[deleted]

kiriklax
kiriklax March 16, 2015
Thanks to that, I was able to understand that for some reasons, logstash was not started.
But now when I try to access Kibana via my browser I get this:

Kibana: Unable to connect to Elasticsearch

Error: unknown error
at respond (http://myDomainName.com/index.js?b=5930:81568:15)
at checkRespForFailure (http://myDomainName.com/index.js?b=5930:81534:7)
at http://myDomainName.com/index.js?b=5930:80203:7
at wrappedErrback (http://myDomainName.com/index.js?b=5930:20882:78)
at wrappedErrback (http://myDomainName.com/index.js?b=5930:20882:78)
at wrappedErrback (http://myDomainName.com/index.js?b=5930:20882:78)
at http://myDomainName.com/index.js?b=5930:21015:76
at Scope.$eval (http://myDomainName.com/index.js?b=5930:22002:28)
at Scope.$digest (http://myDomainName.com/index.js?b=5930:21814:31)
at Scope.$apply (http://myDomainName.com/index.js?b=5930:22106:24)

What can I do?

Thanks

EDIT: ElasticSearch was not running either.

Thanks for the great tutorial!

manicas
manicas March 16, 2015
Did you resolve the issue then?

kiriklax
kiriklax March 16, 2015
Yes, I just launched both logstash and elasticsearch and everything works great now :)

sbuhk
sbuhk May 15, 2015
I was stuck here. Logstash was crashing due to the Java/ruby/oracle bug. if on Ubuntu and using Java/oracle instead of openJDK this is the likely fix. https://github.com/elastic/logstash/issues/3127

MacDaddy
MacDaddy June 30, 2015
I'm getting the same "Kibana: Unable to connect to Elasticsearch" after spinning up the ELK stack from the DO image... Is there anything that needs to be done with that fresh image? If so, that should be added to the MOTD at login, or covered here... Tried restarting each service, and still the same error.

manicas
manicas June 30, 2015
@MacDaddy For help with the ELK stack one-click: How To Use the DigitalOcean ELK Stack One-Click Application

pradeepprakhar
pradeepprakhar March 16, 2015
Hi,

I am getting an warning

"

Index Patterns

Warning No default index pattern. You must select or create one to continue.
"

Thanks
Pradeep

manicas
manicas March 16, 2015
There should be a default index pattern logstash-*.

egrimisu
egrimisu March 16, 2015
Hi and thanks for this guide,
In the kibana index configuration page i get "unable to fetch mapping. Do you have indices matching this pattern?" , check the screenshot http://postimg.org/image/i5fs9yiz9/

Since i find configuring logstash forwarder difficult and more difficult for windows, i was wondering if there is a more simple alternative to send the logs to the server? Thanks

manicas
manicas March 16, 2015
Hi. It looks like your Logstash server isn't receiving logs from your log shipper. If you're on Linux, and using Logstash Forwarder, you should run tail -f /var/log/logstash-forwarder/logstash-forwarder.err to find out what is going wrong. (Press Control-C to quit the tail.)

I haven't set up a Windows log shipper, but I heard that NXlog is what a lot of people use.

On the CentOS 7 version of this article, a user, @david76, was able to get his Windows logs into his ELK stack. Perhaps you can ask him how he did it.

manicas
manicas March 16, 2015
[deleted]

egrimisu
egrimisu March 17, 2015
Hi I have configured a windows box using nxlog to send its logs to elk server. The settings used of the server are writeen lower. I hava configured 2 Cisco switches to send their syslog using port 514 but i still have the same error on Kibana. I thinsk that logstash is not working properly though i have folowed exactly your guide. I start the logstash server and after a few seconds the service is stopped, how can i verify what's wrong? this is getting frustating :)

input {
  lumberjack {
    port => 5000
    type => "logs"
    ssl_certificate => "/etc/pki/tls/certs/logstash-forwarder.crt"
    ssl_key => "/etc/pki/tls/private/logstash-forwarder.key"
  }
  tcp {
    port => 514
    type => "syslog"
  }
  udp {
    port => 514
    type => "syslog"
  }
 tcp {
    port => 3515
    type => "nxlogs"
    format => 'json'
  }
}
Another question, can we find somewhere some inputs, filters,output examples that are complex and working fine for syslog,eventlog,iis,apache? wrting them from scrach it's just over my capabilities unfortunettly.

manicas
manicas March 17, 2015
[deleted]

manicas
manicas March 17, 2015
Check your Logstash logs to see if you can figure out why it is crashing. They're in /var/log/logstash.

The second tutorial in this series has examples of how to ship and filter Nginx and Apache logs.

sebastian115758
sebastian115758 May 2, 2015
Hi Mitchell ! Great article!

I am having issues with setting this up... i get the same error as "In the kibana index configuration page i get "unable to fetch mapping. Do you have indices matching this pattern?" , check the screenshot http://postimg.org/image/i5fs9yiz9/È

i was wondering if you could help.. I get this error when i look at the logs.

xserver@xlog:/etc/pki/tls$ tail -f /var/log/logstash-forwarder/logstash-forwarder.err
#"paths": [
#"/var/log/apache/httpd-*.log"
#],
#"fields": { "type": "apache" }
#}
]
}

2015/05/01 20:46:01.399993 Failed unmarshalling json: invalid character '"' after object key:value pair
2015/05/01 20:46:01.400005 Could not load config file /etc/logstash-forwarder.conf: invalid character '"' after object key:value pair

Error: Please specify a default index pattern
at http://xlog.bane.hq/index.js?b=5930:44791:23
at wrappedCallback (http://xlog.bane.hq/index.js?b=5930:20873:81)
at http://xlog.bane.hq/index.js?b=5930:20959:26
at Scope.$eval (http://xlog.bane.hq/index.js?b=5930:22002:28)
at Scope.$digest (http://xlog.bane.hq/index.js?b=5930:21814:31)
at Scope.$apply (http://xlog.bane.hq/index.js?b=5930:22106:24)
at HTMLDocument.<anonymous> (http://xlog.bane.hq/index.js?b=5930:19104:24)
at HTMLDocument.jQuery.event.dispatch (http://xlog.bane.hq/index.js?b=5930:4409:9)
at HTMLDocument.elemData.handle (http://xlog.bane.hq/index.js?_b=5930:4095:28)

David76
David76 March 17, 2015
For Windows Servers, I use eventlog-to-syslog to send the login/logouts logs to my ELK server, 5000 port.
https://code.google.com/p/eventlog-to-syslog/downloads/list

In 64 bits Windows Servers, you can get the RDP logins/logouts with:
Security Registry + 4624 Event (login) and 4634 Event (logout) + Categoy 10 (keyboard interaction)

The neccessary line in the config file is:

XPath:Security:<Select Path="Security">*[EventData[Data[@Name='LogonType']='10'] and (System[(EventID='4624')] or System[(EventID='4634')])]</Select>
During the instalation of the service, you put the IP and Port (5000) of the remote ELK server:

if exist "c:\windows\SysWOW64" (
                "c:\windows\system32\xcopy.exe" "64bits\evtsys.exe" "c:\windows\system32" /y
                "c:\windows\system32\xcopy.exe" evtsys.cfg "c:\windows\system32" /y
                c:\windows\system32\evtsys.exe -i -h 10.XXX.XXX.XXX -p 5000 -l 0 
                sc start evtsys
)
(again, sorry for my English)
1
fares
fares March 17, 2015
Hi Mitchell 
Thank you for sharing this with us, it's really helpful.

I have a question. Can i create multiple input, filter and output files in conf.d ?
I want to "parse" the same datas with different filter files, (filter-1.conf and filter-2.conf) i can't do it in the same filter config file cause it's the same datas in input. I can't differenciate them with a type field or something.
But if i create 2 filter files in conf.d, and multiple input files also, how to indicate to Logstash which filter matches with input1 or input2 etc.. ?
How can i do that please ?

Thanks. 
Fares

manicas
manicas March 17, 2015
I'm not sure of the best way to filter the same logs twice.

The input/filter/output conf files in /etc/logstash/conf.d get concatenated together, so it doesn't matter if you separate them.

One way would be to ship the same logs twice, as different types, and add another filter for the duplicate log.

fares
fares March 18, 2015
Ok thank you.

I try to 'run' multiple nodes under my elasticsearch cluster, two data nodes and one master node.
On Windows i create 3 different elasticsearch.yml files and run 3 services, it works.

I don't know how to do it on Linux, if you have some it would be so helpful.

Thanks a lot.

kiriklax
kiriklax March 17, 2015
Hello,

I'm not sure if that's the right place to ask but here is what I would like to do.
I followed your tutorial and everything works fine. I have a tomcat server running a web app, I'd like my web app to run an "instance" of logstash-forwarder and send my catalina log file to the logstash server. Is that possible? If yes, then how?

Thanks.

manicas
manicas March 17, 2015
Follow the steps in the Set Up Logstash Forwarder section, which will get your Tomcat server sending syslogs to the Logstash server. Then you can add the Tomcat log files to the Logstash Forwarder configuration (and ship them as "tomcat" type). Then, on your Logstash server, add a filter for "tomcat" type messages (you will need to write a grok filter that matches your tomcat logs).

Check out the 2nd tutorial in this series for help with adding grok filters to Logstash. It gives examples of gathering Nginx and Apache logs.

kiriklax
kiriklax March 17, 2015
Ok, but what I would like is to configure the logstash-forwarder part inside my war file. This way, I just have to copy paste and redeploy the war on other servers... Do you think that's possible?

manicas
manicas March 17, 2015
You need to include the Logstash server's SSL certificate and IP address. It can be done, but I'm not sure if that's the best approach.

mayuriwavhal
mayuriwavhal March 18, 2015
Hi Mitchell,
I am not able to spot the location where elasticsearch stores parsed logs. As per reading the only pointer i got is that we can specify it in elasticsearch.yml in path.data field, but apart from that what is the default storage location for elasticsearch data

manicas
manicas March 18, 2015
/var/lib/elasticsearch/elasticsearch/nodes/0/indices

rvz
rvz March 18, 2015
I followed the previous article which had Kibana 3. I've since upgraded Elasticsearch and Logstash, but apparently it's not so easy upgrading to Kibana 4. Where can I get instructions on how to upgrade?

manicas
manicas March 18, 2015
I think Kibana 4 is a complete rewrite, so you just have to install it and re-create any visualizations and dashboards that you may have had.

orby
orby March 19, 2015
I had to add locale => "en" to /etc/logstash/conf.d/10-syslog.conf date definition, since I have another system locale:

    date {
      locale => "en"
      match => [ "syslog_timestamp", "MMM  d HH:mm:ss", "MMM dd HH:mm:ss" ]
    }
No harm having that specified, even if you actually use "en" as your system locale, so safe to update documentation.

Baldwin
Baldwin March 20, 2015
Having some trouble configuring nginx to use with https and Kibana:

Using curl: (7) Failed to connect to 127.0.0.1 port 5601: Connection refused

Also changed in kibana.yml: elasticsearch_url: "https://localhost:9200"

server {
    listen 443 ssl spdy default_server;
    listen [::]:443 ssl spdy ipv6only=on default_server;

    root /var/www/html;
    index index.php index.html index.htm;

    server_name www.site.com;

    ssl_stuff

    location / {
        proxy_pass http://localhost:5601;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
        proxy_set_header X-Forwarded-Proto https;
        proxy_set_header X-Forwarded-Port 443;
        proxy_set_header X-Secure on; 
        auth_basic "Restricted Access";
        auth_basic_user_file /etc/nginx/htpasswd.users;
    }

manicas
manicas March 20, 2015
I haven't set up https yet, but I'll update the guide when I do. Sorry.

Load More Comments
Creative Commons License
This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
Copyright © 2015 DigitalOcean™ Inc.
Community Tutorials Questions Projects Tags RSS  
Terms, Privacy, & Copyright Security Report a Bug Get Paid to Write
SCROLL TO TOP

