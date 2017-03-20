source bin/activate
sudo apt-get -y install python-dev
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
pip install -U setuptools
pip install cloudify==3.1
echo "
Next bring up the manager locally:
"
sudo apt-get install -y git
git clone -b 3.1-build https://github.com/cloudify-cosmo/cloudify-manager-blueprints.git
cfy init
cfy local install-plugins -p cloudify-manager-blueprints/simple/simple.yaml
cp  cloudify-manager-blueprints/simple/inputs.json.template inputs.json
echo "inputs.json so it looks like this (with your particulars filled in):

{
public_ip: 
private_ip: 
ssh_user: 
ssh_key_filename: 

agents_user: 
resources_prefix: 
}

ip a.  The public ip is the one that was uncommented in the Vagrantfile.
"
vi inputs.json
cfy bootstrap -p cloudify-manager-blueprints/simple/simple.yaml  -i inputs.json.

echo "After awhile (depending on your network), you can verify that the manager is running by pointing a browser at the public ip (e.g.http://192.168.33.10).  You should see the manager UI.

Install and Start a Blueprint from the CLI

From this point forward you can experiment with installing/uninstalling and blueprints.  The nodecellar blueprint is the canonical example.
"
git clone -b 3.1-build https://github.com/cloudify-cosmo/cloudify-nodecellar-example.git
cp cloudify-nodecellar-example/inputs/singlehost.json.template ncinputs.json
vi ncinputs.json

echo "ncinputs.json so it looks like this:

{
host_ip: 
agent_user: 
agent_private_key_path: 
 }

As before, change IPs as needed if you diverged from the steps above.
"
cfy blueprints upload -b nc -p cloudify-nodecellar-example/singlehost-blueprint.yaml
cfy deployments create -b nc -d ncd -i ncinputs.json
cfy executions start -w install -d ncd

echo "Install and Start a Blueprint from the UI

To install and start the blueprint from the UI, perform steps 1-3 above, and then:

cp ~/cp -r cloudify-nodecellar-example/ /vagrant)
singlehost-blueprint.yaml to 
COPYFILE_DISABLE=true tar czf nc.tar.gz cloudify-nodecellar-example/
Blueprints tab on the UI, select 
nc.
save on the dialog.
Create Deployment button.
ncd, and fill in the parameter values like so:

agent_private_key_path: /vagrant/insecure_private_key
agent_user: vagrant
host_ip: 192.168.33.10
12. The deployment will be created and you will be placed in the deployments view/tab.  Expect a small delay as the manager side services are spun up for the deployment.
select workflow option box, select 

For a detailed exploration of the Nodecellar blueprint, please refer to the guide.
"


