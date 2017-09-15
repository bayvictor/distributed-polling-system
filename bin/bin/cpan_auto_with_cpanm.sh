sudo apt install cpanminus -y --force-yes

mkdir ~/src/cpan
cd ~/src/cpan
wget -O- http://cpanmin.us | perl - -l ~/perl5 App::cpanminus local::lib
eval `perl -I ~/perl5/lib/perl5 -Mlocal::lib`
echo 'eval `perl -I ~/perl5/lib/perl5 -Mlocal::lib`' >> ~/.bash_profile
echo 'export MANPATH=$HOME/perl5/man:$MANPATH' >> ~/.bash_profile
echo "This assumes your profile is named .bash_profile, you may need to change that to be .bash_profile, .bashrc, etc. After that you can install modules by saying

cpanm Module::Name
"


