echo Before downloading Metasploit, install the supporting packages:

read read_line
sudo  apt-get install -y ruby libruby rdoc

sudo  apt-get install -y libyaml-ruby

sudo  apt-get install -y libzlib-ruby

sudo  apt-get install -y libopenssl-ruby

sudo  apt-get install -y libdl-ruby

sudo  apt-get install -y libiconv-ruby

sudo  apt-get install -y rubygems

read read_line
echo "Tho n navigate to your home directory and download Metasploit itself. The easiest way to do this is using subversion: ensure that subversion is installed on your system (if not you can get it using sudo apt-get install -y subversion) then:
"
svn co https://metasploit.com/svn/framework3/trunk/
echo "Downloading and Installing Fast-Track

To download Fast-Track, navigate again to your home directory and type:
"
svn co http://svn.thepentest.com/fasttrack/

read read_line
echo "Next, move to the newly downloaded fasttrack directory and install Fast-Track:"

python setup.py install

read read_line
echo "You'll be asked for the path to the Metasploit installation you downloaded earlier, and then with any luck Fast-Track will install with all its dependencies. If this doesn't work, the documentation states the required Python modules you might need to install manually include: PExpect, FreeTDS, PYMSSQL, ClientForms, Beautiful Soup, PyMills, and Psyco – you'll be able to download them via Ubuntu's Synaptic package manger. You'll also need Nmap and SQLite3.
"
echo Once Fast-Track is installed, run Fast-Track in menu mode:
read read_line

python fast-track.py --i

echo "Fast-Track will check all the required packages are installed, and if so, you'll see the Fast-Track main menu (below)."
