echo "
Download and install separately PyYAML and Jinja2 separately, as they're not available via Cygwin's installer:

Open Cygwin
Download PyYAML:
"
mkdir ~/src/ansible
cd  ~/src/ansible

wget --no-certificate-check  https://pypi.python.org/packages/source/P/PyYAML/PyYAML-3.10.tar.gz
wget --no-certificate-check  https://pypi.python.org/packages/source/J/Jinja2/Jinja2-2.6.tar.gz


#curl -O https://pypi.python.org/packages/source/P/PyYAML/PyYAML-3.10.tar.gz
echo "Download Jinja2:"
#curl -O https://pypi.python.org/packages/source/J/Jinja2/Jinja2-2.6.tar.gz
echo "Untar both downloads:
"
tar -xvf PyYAML-3.10.tar.gz && tar -xvf Jinja2-2.6.tar.gz
echo "
Change directory into each of the expanded folders and run python setup.py install to install each package.
Generate an SSH key for use later: ssh-keygen, then hit enter to skip adding a password until you get back 
to the command prompt.
Clone ansible from its repository on GitHub:
"
git clone https://github.com/ansible/ansible /opt/ansible

echo "
If you'd like to work from a particular Ansible version (like 1.4.4, current as of this writing), 
change directory into /opt/ansible and checkout the correct tag: git checkout v1.4.4.
Add the following lines into your Cygwin .bash_profile (like you did the proxy settings—if you're 
behind one—in step 2):
"

echo "
# Ansible settings
ANSIBLE=/opt/ansible
export PATH=$PATH:$ANSIBLE/bin
export PYTHONPATH=$ANSIBLE/lib
export ANSIBLE_LIBRARY=$ANSIBLE/library
">>~/bin/set_ansible_env.sh

chmod +x ~/bin -R

source ~/bin/set_ansible_env.sh


echo "
At this point, you should be able to run ansible commands via Cygwin (once you restart, or enter 
source ~/.bash_profile to pick up the settings you just added). Try ansible --version to display 
Ansible's version.
"
echo "
If you would like to use Ansible as a provisioner for Vagrant, you can try, but after a day's 
worth of frustration (to the point of trying to add custom .bat files, changing Windows' and 
Linux' %PATH%/$PATH multiple times, and doing a hundred other things besides), I would recommend 
using Linux or a Mac to use Vagrant + Ansible together, or you could also use something like my 
JJG-Ansible-Windows shell provisioning script to run Ansible from within the VM itself.
"
echo "
I will be exploring how to use Ansible, whether you use Windows, Linux, or Mac OS X, in 
much greater detail, 
"