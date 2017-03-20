#!/bin/bash
clear
echo "************* Configuring Server with Basic Packages  *************"
echo "Configuring... now is your chance to STOP: CNTRL + C"
sleep 7

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install git-core -y
sudo apt-get install wget -y
sudo apt-get install curl -y
sudo apt-get install vim -y
sudo apt-get install ruby -y
sudo apt-get install automake -y
sudo apt-get install build-essential -y
sudo apt-get install bison -y
sudo apt-get install openssl -y
sudo apt-get install libssl-dev -y
sudo apt-get install libssl0.9.8
sudo apt-get install libqt4-dev -y
sudo apt-get install libtool -y
sudo apt-get install libfcgi-dev -y
sudo apt-get install libyaml-0-2 -y
sudo apt-get install libyaml-dev -y
sudo apt-get install libreadline-dev -y
sudo apt-get install libreadline6-dev -y
sudo apt-get install libreadline6 -y
sudo apt-get install libreadline5-dev -y
sudo apt-get install libreadline5 -y 
sudo apt-get install libsqlite3-0 -y
sudo apt-get install libsqlite3-dev -y
sudo apt-get install libmysqlclient-dev -y
sudo apt-get install libcurl4-openssl-dev -y
sudo apt-get install libmagick9-dev -y
sudo apt-get install libc6-dev -y
sudo apt-get install libxml2 -y
sudo apt-get install libxml2-dev -y
sudo apt-get install libxslt1-dev -y 
sudo apt-get install libxml2-dev -y
sudo apt-get install libopenssl-ruby -y
sudo apt-get install libzlib-ruby -y
sudo apt-get install libyaml-ruby -y
sudo apt-get install libdrb-ruby -y 
sudo apt-get install liberb-ruby -y
sudo apt-get install nodejs -y
sudo apt-get install ncurses-dev -y
sudo apt-get install readline-common -y
sudo apt-get install ruby-dev -y
sudo apt-get install sqlite3 -y
sudo apt-get install zlib1g -y
sudo apt-get install zlib1g-dev -y
sudo apt-get install sox -y
sudo apt-get install bzr -y
sudo apt-get install default-jre -y
sudo apt-get install scala -y
sudo apt-get install unzip -y

apt-get install postgresql-client libpq5 libpq-dev -y

wget https://raw.github.com/amanelis/pipes/master/lib/bashrc -O ~/.bashrc
source ~/.bashrc

wget https://raw.github.com/amanelis/pipes/master/lib/gemrc -O ~/.gemrc
sudo wget https://raw.github.com/amanelis/pipes/master/lib/sudoers -O /etc/sudoers


