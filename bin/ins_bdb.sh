sudo apt-get install -y libdb++-dev #- Berkeley Database Libraries for C++ [development]
sudo apt-get install -y libdb-dev #- Berkeley Database Libraries [development]
sudo apt-get install -y libdb-java-dev #- Berkeley Database Libraries for Java [development]
sudo apt-get install -y libdb-sql-dev #- Berkeley Database Libraries [SQL development]
sudo apt-get install -y libdbi-dev #- DB Independent Abstraction Layer for C  -- development files
gpg --keyserver pgp.mit.edu --recv-keys 4BD736A82B5C1B00   #F758CE318D77295D
gpg --export --armor  4BD736A82B5C1B00 | sudo apt-key add -

#sudo vi /etc/apt/sourcelist   #and add:
deb http://www.apache.org/dist/cassandra/debian 11x main
deb-src http://www.apache.org/dist/cassandra/debian 11x main

#sudo apt-get -y update && 
sudo apt-get install -y cassandra-dev
sudo apt-get -y install memcached


