echo " 7
down vote
accepted
	

So here are the steps:

    first you download the driver here: https://github.com/mozilla/geckodriver/releases In my case:
"
mkdir ~/apps
cd ~/apps
wget https://github.com/mozilla/geckodriver/releases/download/v0.13.0/geckodriver-v0.13.0-linux64.tar.gz
echo "
    then you extract the file: 
"
tar -xvzf geckodriver*
echo "
    now we make the driver executable: 
"
chmod +x geckodriver
cp geckodriver ~/bin
echo "
    In order for tools to use the driver you will need to add the driver to your path: export PATH=$PATH:/path-to-extracted-file/geckodriver

There are many ways to do this that will work in my case on Ubuntu 16.10 64 this works.
"

