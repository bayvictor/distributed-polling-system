
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com \     67265eb522bdd6b1c69e66ed7fb8bee0a1f196a8

echo deb http://ppa.launchpad.net/pidgin-developers/ppa/ubuntu \     `lsb_release --short --codename` main | \
    sudo tee /etc/apt/sources.list.d/pidgin-ppa.list

#After doing this, open Update Manager, check for updates, and then install the newly available Pidgin packages.

#Future Pidgin updates will show up in Update Manager along with the usual Ubuntu updates. The PPA will need to be re-setup only after upgrading Ubuntu.

#This PPA is maintained by one developer, so please be patient. It often lags behind the source releases a couple of days.

#Voice and video support is only built on Jaunty (9.04) and up.
#libpurple


