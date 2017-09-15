echo "
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
"

echo '
input {
  lumberjack {
    port => 5000
    type => "logs"
    ssl_certificate => "/etc/pki/tls/certs/logstash-forwarder.crt"
    ssl_key => "/etc/pki/tls/private/logstash-forwarder.key"
  }
}
'

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
