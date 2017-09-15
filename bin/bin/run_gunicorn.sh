cd ~/src/3d/py_nosql_frameworks
wget https://pypi.python.org/packages/source/g/gunicorn/gunicorn-0.17.4.tar.gz
tar -zxvf gunicorn-0.17.4.tar.gz
cd gunicorn-0.17.4
python setup.py install

echo "
$ "

sudo pip install virtualenv
 mkdir ~/environments/
 virtualenv ~/environments/testgunicorn/
 cd ~/environments/testgunicorn/
 ls
#  bin  include  lib
 source bin/activate
 pip install gunicorn
 mkdir myapp
 cd myapp/
 vi myapp.py
 cat myapp.py
echo "
will echo...
  def app(environ, start_response):
      data = "Hello, World!\n"
      start_response("200 OK", [
          ("Content-Type", "text/plain"),
          ("Content-Length", str(len(data)))
      ])
      return iter([data])

  (testgunicorn) $ "

../bin/gunicorn -w 4 myapp:app






