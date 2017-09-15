sudo apt-get install -y postgresql
sudo apt-get install -y postgresql-client

perl -MCPAN -e 'install Bundle::Bugzilla'

su - postgres
PAN -e 'install Bundle::Bugzilla'
createuser -U postgres -dRSP bugs

