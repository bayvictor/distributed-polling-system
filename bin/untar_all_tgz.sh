ls *.tgz|tr '\t' '\n'|sed 's/^/tar -zxf /g' > /tmp/go.sh 
#tar -zxf solr-4.10.0-src.tgz
#tar -zxf solr-4.10.0.tgz

chmod +x /tmp/*.sh
/tmp/go.sh


