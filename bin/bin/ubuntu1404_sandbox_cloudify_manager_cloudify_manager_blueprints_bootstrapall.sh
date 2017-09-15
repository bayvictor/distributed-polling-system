cfy init -r;cfy bootstrap --install-plugins -p ./openstack-nova-net/openstack.yaml -i  ./openstack-nova-net/inputs.json.template
 
cfy init -r;cfy bootstrap --install-plugins -p ./simple/simple.yaml -i  ./simple/inputs.json
 
cfy init -r;cfy bootstrap --install-plugins -p ./cloudstack/cloudstack.yaml -i   ./cloudstack/inputs.json.template
 
cfy init -r;cfy bootstrap --install-plugins -p ./softlayer/softlayer.yaml -i  ./softlayer/inputs.json.template
 
cfy init -r;cfy bootstrap --install-plugins -p ./openstack/openstack.yaml -i  ./openstack/inputs.json.template 
