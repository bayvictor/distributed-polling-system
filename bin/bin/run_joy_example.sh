source /home/vhuang/bin/set_joycrawler_env.sh
echo "JAVA_HOME=$JAVA_HOME"
ls $JAVA_HOME/lib
ls $JAVA_HOME/bin
#apt-cache search openjdk|cut -d' ' -f1 | tr '\n' ' ' |sed 's/^/sudo apt-get install -y /g'

#sudo apt-get install -y cacao-source default-jdk default-jdk-doc default-jre default-jre-headless freemind openoffice.org icedtea-6-jre-cacao icedtea6-plugin openjdk-6-dbg openjdk-6-demo openjdk-6-doc openjdk-6-jdk openjdk-6-jre openjdk-6-jre-headless openjdk-6-jre-lib openjdk-6-source openjdk-6-jre-zero
sudo apt-get install -y cacao-source   freemind openoffice.org icedtea-6-jre-cacao icedtea6-plugin openjdk-6-dbg openjdk-6-demo openjdk-6-doc openjdk-6-jdk openjdk-6-jre openjdk-6-jre-headless openjdk-6-jre-lib openjdk-6-source openjdk-6-jre-zero
echo "update-alternatives..., ^C to break"
read read_line
update-alternatives --all

## --below 2 lines only run once for build with java and install it!
#cd $JOYDIR/db-4.8.26
#cd build_unix;../dist/configure --enable-java  --bindir=/usr/local/bin;make;sudo make install


cd $JOYDIR/joycrawler-0.20.0

export LD_LIBRARY_PATH=$JOYDIR/db-4.8.2/build_unix/.libs:$LD_LIBRARY_PATH
export CLASSPATH=$JOYDIR/db-4.8.2/build_unix:$CLASSPATH:/home/vhuang/src/py/joycrawler/joycrawler-0.20.0/lib
#/usr/lib
echo"	To download the webpages and index them
	$ "
ant index -Dconf=wiki -Dnative.path=$JOYDIR/db-4.8.2/build_unix/.libs -Djava.library.path=$JOYDIR/db-4.8.2/build_unix:/home/vhuang/src/py/joycrawler/joycrawler-0.20.0/lib #bdb dir
#ant index -Dconf=EXAMPLE -Dnative.path=/usr/lib #bdb dir
	
echo "	To start your search server on local machine
	$ "
ant server -Dnative.path=/usr/lib:$JOYDIR/db-4.8.2/build_unix/.libs  -Djava.library.path=$JOYDIR/db-4.8.2/build_unix:/home/vhuang/src/py/joycrawler/joycrawler-0.20.0/lib -Ddbfolder=~/bdb  #DB_FOLDER
echo "	DB_FODLER will be described in org.joy.index.DBFolder property in configration file."

#	The initialization will finish if it prompts "Listening to 1987" 
	
echo "	To start search, launch another terminal, cd to the installation directory
	$ "
ant searcher  -Djava.library.path=$JOYDIR/db-4.8.2/build_unix/.libs -Dnative.path=/usr/lib:$JOYDIR/db-4.8.2/build_unix:/home/vhuang/src/py/joycrawler/joycrawler-0.20.0/lib -Dhosts=localhost
echo"	Then you can type the search string
"
