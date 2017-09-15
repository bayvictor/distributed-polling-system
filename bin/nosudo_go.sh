echo "pip and cfy don';t like sudo, never use sudo, use virtualenv instead! "

echo "^C to break, anykey to continue...";read readline
echo "
will do below: 
apt-get install -y python-pip; apt-get install -y python-dev;
pip install virtualenv
 virtualenv ~/cloudify/cfy_virt
 cd ~/cloudify/cfy_virt
 source bin/activate

) "
 
echo "^C to break, anykey to continue...";read readline


apt-get install -y python-pip; apt-get install -y python-dev;

pip install virtualenv
 virtualenv ~/cloudify/cfy_virt
 cd ~/cloudify/cfy_virt
 source bin/activate

apt-get install -y python-pip; apt-get install -y python-dev;
echo "^C to break, anykey to continue...";read readline
echo "will do below:...
 pip install https://github.com/cloudify-cosmo/cloudify-dsl-parser/archive/3.1rc1.zip
 pip install https://github.com/cloudify-cosmo/cloudify-rest-client/archive/3.1rc1.zip
 pip install https://github.com/cloudify-cosmo/cloudify-plugins-common/archive/3.1rc1.zip
 pip install https://github.com/cloudify-cosmo/cloudify-cli/archive/3.1rc1.zip


"

echo "^C to break, anykey to continue...";read readline

pip install https://github.com/cloudify-cosmo/cloudify-dsl-parser/archive/3.1rc1.zip
 pip install https://github.com/cloudify-cosmo/cloudify-rest-client/archive/3.1rc1.zip
 pip install https://github.com/cloudify-cosmo/cloudify-plugins-common/archive/3.1rc1.zip
 pip install https://github.com/cloudify-cosmo/cloudify-cli/archive/3.1rc1.zip


 cd ~/cloudify
 cfy init -r 

echo " copying rc1 manager blueprints from your github
"
git clone https://github.com/cloudify-cosmo/cloudify-manager-blueprints.git

cfy local install-plugins -p ../cloudify-manager-blueprints-3.1rc1-build/openstack/openstack.yaml

echo " (running from virtualenv console, cfy_virt folder)
"

echo "^C to break, anykey to continue...";read readline


