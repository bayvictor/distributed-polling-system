cfy bootstrap --install-plugins -p cloudstack-blueprint.yaml -i  inputs/cloudstack.json
cfy bootstrap --install-plugins -p cloudstack-vpc-blueprint.yaml -i inputs/cloudstack-vpc.json
cfy bootstrap --install-plugins -p ec2-blueprint.yaml -i inputs/ec2.json
cfy bootstrap --install-plugins -p local-blueprint.yaml #-i 
cfy bootstrap --install-plugins -p openstack-blueprint.yaml -i inputs/openstack.json
cfy bootstrap --install-plugins -p openstack-nova-net-blueprint.yaml -i inputs/openstack-nova-net.json
cfy bootstrap --install-plugins -p singlehost-blueprint.yaml #-i 


#inputs/singlehost.json



