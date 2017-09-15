sudo apt-get install -y ant
export JOYDIR=/home/vhuang/src/py/joycrawler

export CLASSPATH=$JAVA_HOME/bin/lib/rt.jar:${JOYDIR}/jdk1.6.0_17/lib/tools.jar:${JOYDIR}/jdk1.6.0_17/db/lib/derbytools.jar:${JOYDIR}/jdk1.6.0_17/lib/visualvm/visualvm/modules/com-sun-tools-visualvm-tools.jar:/mnt/hbase/hbase-0.20.4.jar:/mnt/hbase/hbase-0.20.4-test.jar
ant 

export HADOOP_CLASSPATH=/mnt/hbase/hbase-0.20.4.jar:/mnt/hbase/hbase-0.20.4-test.jar:/conf


