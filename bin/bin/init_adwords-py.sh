#wget http://google-api-adwords-python-lib.googlecode.com/files/adwords_api_python_13.1.0.tar.gz
#wget http://downloads.sourceforge.net/project/pywebsvcs/ZSI/ZSI-2.1_a1/ZSI-2.1-a1.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fpywebsvcs%2Ffiles%2F&ts=1289850057&use_mirror=cdnetworks-us-2
#tar -zxvf adwords_api_python_13.1.0.tar.gz
#tar -zxvf ZSI-2.1-a1.tar.gz
easy_install pyxml
cd ZSI-2.1-a1
python setup.py build install
cd ..
cd adwords_api_python_13.1.0
python setup.py build install

