
bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)


# add below 2 lines at bottom of ~/.bashrc
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
# then run "rvm requirements"

#  ruby: 
sudo /usr/bin/apt-get install -y build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion

# For JRuby, install the following:
#  jruby: 
sudo /usr/bin/apt-get install  -y curl g++ openjdk-6-jre-headless
#  jruby-head: 
sudo /usr/bin/apt-get install  -y ant openjdk-6-jdk

# For IronRuby, install the following:
#  ironruby: 
sudo /usr/bin/apt-get install  -y curl mono-2.0-devel


sudo apt-get install -y rvm-tools #- Recoverable Virtual Memory (tools)

sudo apt-get install -y ruby-full #- Ruby full installation
sudo apt-get install -y rails #- MVC ruby based framework geared for web application development
sudo apt-get install -y rubygems #- package management framework for Ruby libraries/applications



rvm install 1.9.2
rvm use 1.9.2
ruby -v
gem install rails
git clone https://github.com/sstephenson/execjs.git

gem install execjs

rails new my_app
bundle install
cd my_app
rails server

echo "Then open your browser and type the following address (to see the application running) -
http://localhost:3000
"

