echo "> "

sudo apt-get install git python-dev python-virtualenv libssl-dev libffi-dev

echo "
On Fedora-based distributions (e.g., Fedora/RHEL/CentOS/Scientific Linux):

> sudo yum install gcc git-core python-devel python-virtualenv openssl-devel libffi-devel which
Setup
To setup a Horizon development environment simply clone the Horizon git repository from http://github.com/openstack/horizon and execute the run_tests.sh script from the root folder (see The run_tests.sh Script):
"
mkdir ~/src/horizon
cd  ~/src/horizon

 git clone https://github.com/openstack/horizon.git
 cd horizon
 ./run_tests.sh


