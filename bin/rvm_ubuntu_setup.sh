echo "sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-get update -y #e
sudo apt-get install -y  rvm
i"

echo "# Install rvm with ruby 1.9.3 and 2.0" ;\
  apt-get -q -y install libyaml-dev ;\
  curl -L https://get.rvm.io | bash ;\
  bash -c "source /etc/profile.d/rvm.sh && rvm install 1.9.3 && rvm install 2.0 && gem install bundler --no-ri --no-rdoc" ;\
  echo 'source /etc/profile.d/rvm.sh' >> ~/.bash_profile ;\
  echo 'source /etc/profile.d/rvm.sh' >> ~/.bashrc ;\
echo "2. Change your terminal window
Now, in order to always load rvm, change the Gnome Terminal to always perform a login.
"

