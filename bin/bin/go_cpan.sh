echo "
3
down vote
Already answered and accepted answer - but anyway:

IMHO the easiest way installing CPAN modules (on unix like systems, and have no idea about the wondows) is:
"

curl -L http://cpanmin.us | perl - --sudo App::cpanminus
echo "The above is installing the "zero configuration CPAN modules installer" called cpanm. (Can take several minutes to install - don't break the process)

and after - simply:
"

sudo apt-get install -y libimvirt-perl #- Perl module for detecting several virtualizations
    sudo apt-get install -y build-essential perl python git
sudo cp -fr ~/scratchbox/devkits/perl . 
curl -L http://cpanmin.us | perl - --sudo App::cpanminus
sudo apt-get install dh-make-perl build-essential apt-file
sudo apt-get install -y libdevel-refactor-perl #- Perl module for code refactoring
sudo apt-get install -y perlqt-dev #- Development files for PerlQt4
sudo apt-get install -y libmojomojo-perl #- wiki- and blog-inspired content management system
sudo apt-get install -y libgd-gd2-perl #- Perl module wrapper for libgd #- gd2 variant
    sudo apt-get install -y build-essential perl python git
sudo apt-get install -y  --force-yes  libapache-dbi-perl
sudo apt-get install -y  --force-yes  libapache2-mod-perl2
sudo apt-get install -y libapache2-mod-perl2-dev #- Integration of perl with the Apache2 web server #- development files


cpanm Foo
cpanm Template::Filters 
cpanm Another::Module
sudo apt-get install dh-make-perl build-essential apt-file
