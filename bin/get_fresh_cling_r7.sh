cd /home/vhuang/src/glen


svn co http://svn.teleal.org/repos/cling/tags/release-1.0-beta7
mvn eclipse:eclipse
mvn install

tar -zcvf release-1.0-beta7-`timestamp`.tgz release-1.0-beta7


