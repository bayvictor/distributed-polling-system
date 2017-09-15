cd ~/apps


wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins

echo "Upgrade

Once installed like this, you can update to the later version of Jenkins (when it comes out) by running the following commands:
"
sudo apt-get update
sudo apt-get install jenkins




