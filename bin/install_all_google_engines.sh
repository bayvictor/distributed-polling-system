#echo "run as root!"
cd /sda1/home/vhuang/src/test/googleapps_03
#vhuang@vhuang-MicroStar:/sda1/home/vhuang/src/test/googleapps_03$ find google_appengine/|grep setup.py|sed 's/^/python /g;s/$/ install /g'
sudo python google_appengine/lib/django_1_2/setup.py install 
sudo python google_appengine/lib/argparse/setup.py install 
sudo python google_appengine/lib/jinja2/setup.py install 
sudo python google_appengine/lib/webapp2/setup.py install 
sudo python google_appengine/lib/markupsafe/setup.py install 
sudo python google_appengine/lib/django_1_3/setup.py install 
sudo python google_appengine/lib/python-gflags/setup.py install 
sudo python google_appengine/lib/django_0_96/setup.py install 
sudo python google_appengine/lib/PyAMF/distribute_setup.py install 
sudo python google_appengine/lib/PyAMF/setup.py install 
sudo python google_appengine/lib/ipaddr/ipaddr/setup.py install 
sudo python google_appengine/lib/antlr3/setup.py install 
sudo python google_appengine/lib/yaml/setup.py install 
sudo python google_appengine/lib/webob_1_1_1/setup.py install 
sudo python google_appengine/lib/webob_0_9/setup.py install 
sudo python google_appengine/lib/google-api-python-client/setup.py install 

