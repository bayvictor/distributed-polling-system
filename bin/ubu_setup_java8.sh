sudo  echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
sudo  echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" > /etc/apt/sources.list.d/webupd8team-java-trusty.list
sudo  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
sudo  apt-get update && \
sudo  apt-get install -y --no-install-recommends oracle-java8-installer && \
sudo  apt-get clean all
