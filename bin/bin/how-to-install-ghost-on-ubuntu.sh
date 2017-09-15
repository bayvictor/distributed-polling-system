echo "How To Install Ghost On Ubuntu
We have built a script that can automate installing Ghost on Ubuntu (or Ubuntu Server) that you can find on our One Click Ghost Install Script article. If you would like to use that, great! If not, this page will describe in great detail how to install Ghost, the blogging platform, on the Ubuntu operating system.
This article will walk you through how to install Ghost on Ubuntu. These steps will work for Ubuntu 12.04 and 13.10, both the server and desktop versions.

Update Ubuntu

The first step will be to run through the Ubuntu software updates and install a couple of extra packages that will be needed.
"
sudo apt-get update
sudo apt-get upgrade -y
sudo aptitude install -y zip vim wget


echo "Download and Install the Node.js Source Code

Install Node.js
"
curl -sL https://deb.nodesource.com/setup | sudo bash -
sudo apt-get install -y nodejs
echo "Download and Install Ghost
"
sudo mkdir -p /var/www/
cd /var/www/
sudo wget https://ghost.org/zip/ghost-latest.zip
sudo unzip -d ghost ghost-latest.zip
cd ghost/
sudo npm install --production

echo "Configure Ghost
"
sudo cp config.example.js config.js
echo "In the \"Production\" section, change the following:

host: '127.0.0.1',
to

host: '0.0.0.0',
Create Ghost User
"
echo "^C to break, anykey to continue... better open new terminal doing :
sudo vi config.js
"; read readline

sudo vi config.js
sudo adduser --shell /bin/bash --gecos 'Ghost application' ghost
sudo chown -R ghost:ghost /var/www/ghost/
echo "Now to start Ghost, you will need to log into your \"ghost\" user.
"
su - ghost
cd /var/www/ghost/
echo "
Now that you are logged in with your \"ghost\" user you can start Ghost:
"
npm start --production
echo "Browse to http://url_where_ghost_is_installed.com:2368

Proxying to Port 80 and keep Ghost running
!!!"

echo "^C to break, anykey to continue...";read readline

echo"
There you have it, Node.js is installed, Ghost files are located in /var/www/ghost, and Ghost has been started. You can keep Ghost the way it is currently setup if using for a development environment and do not mind adding :2368 to the end of your url. If you are looking for more of a production setup, we would highly recommend you check out the following two articles to help get your Ghost blog ready:
"

echo "^C to break, anykey to continue...";read readline
echo "How to Proxy Port 80 to 2368 for Ghost with Nginx

Keep Ghost Running with PM2
Next Steps:
Learn Ghost from the Ground Up
Head to \"Ghost for Beginners\" to learn everything you need to know about learning and customizing Ghost

Find the Perfect Ghost Theme
Go to \"All Ghost Themes\" to browse all of your Ghost theme options in one place.

Keep Up to Date on Ghost
Check out \"All About Ghost\" to stay up to date on everything that is Ghost.
"

echo "^C to break, anykey to continue...";read readline

