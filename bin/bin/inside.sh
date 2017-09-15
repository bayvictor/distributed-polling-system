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
    vi inputs.json
echo "
    edit inputs.json so it looks like this (with your particulars filled in):
    1 2 3 4 5 6 7 8 9 	

#    {
#    "public_ip": "192.168.33.10",
#    "private_ip": "10.0.2.15",
#    "ssh_user": "vagrant",
#    "ssh_key_filename": "/vagrant/insecure_private_key",
#     
#    "agents_user": "vagrant",
#    "resources_prefix": ""
#    }
"
echo " 
   view raw inputs.json hosted with ❤ by GitHub

    The public and private IPs should be the same if you followed the instructions exactly, otherwise you can get them from ip a.  The public IP is the one that was uncommented in the Vagrantfile.
"
    cfy bootstrap -p cloudify-manager-blueprints/simple/simple.yaml  -i inputs.json
echo "
After awhile (depending on your network), you can verify that the manager is running by pointing a browser at the public ip (e.g.http://192.168.33.10).  You should see the manager UI.

Install and Start a Blueprint from the CLI

From this point forward you can experiment with installing/uninstalling and blueprints.  The nodecellar blueprint is the canonical example.
"
    git clone -b 3.1-build https://github.com/cloudify-cosmo/cloudify-nodecellar-example.git
    cp cloudify-nodecellar-example/inputs/singlehost.json.template ncinputs.json
    vi ncinputs.json
echo " 
#    edit "ncinputs.json" so it looks like this:
#    1 2 3 4 5 	
#
#    {
#    "host_ip": "192.168.33.10",
#    "agent_user": "vagrant",
#    "agent_private_key_path": "/vagrant/insecure_private_key",
#    }

#    view raw ncinputs.json hosted with ❤ by GitHub

    As before, change IPs as needed if you diverged from the steps above.
"
    cfy blueprints upload -b nc -p cloudify-nodecellar-example/singlehost-blueprint.yaml
    cfy deployments create -b nc -d ncd -i ncinputs.json
    cfy executions start -w install -d ncd
echo "
Install and Start a Blueprint from the UI

To install and start the blueprint from the UI, perform steps 1-3 above, and then:

#    Copy the blueprint directory in your VM to the /vagrant directory (cp ~/cp -r cloudify-nodecellar-example/ /vagran\")
"
echo "
    In the /vagrant/cloudify-nodecellar-example directory, rename singlehost-blueprint.yaml to blueprint.yaml.
    In the /vagrant directory, run COPYFILE_DISABLE=true tar czf nc.tar.gz cloudify-nodecellar-example/
    From the Blueprints tab on the UI, select Upload Blueprint and select the nc.tar.gz file in the directory where you started the Vagrant box.
    Set the blueprint name to nc.
    Select save on the dialog.
    The blueprint is now uploaded.  Press the Create Deployment button.
    Name the deployment ncd, and fill in the parameter values like so:
        agent_private_key_path: /vagrant/insecure_private_key
        agent_user: vagrant
        host_ip: 192.168.33.10
    The deployment will be created and you will be placed in the deployments view/tab.  Expect a small delay as the manager side services are spun up for the deployment.
    On the select workflow option box, select Install and press the arrow to the right.  The install will begin.  It will complete in about 5 minutes, depending on your hardware.

"
