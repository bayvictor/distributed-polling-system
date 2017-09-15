pip install Pinax 

pip install virtualenv

pip install distribute
echo "do:python virtualenv.py ENV
The basic usage is:

$ python virtualenv.py ENV

If you install it you can also just do virtualenv ENV.
"
read readline
echo "
This creates ENV/lib/pythonX.X/site-packages, where any libraries you install will go. It also creates ENV/bin/python, which is a Python interpreter that uses this environment. Anytime you use that interpreter (including when a script has #!/path/to/ENV/bin/python in it) the libraries in that environment will be used.

It also installs either Setuptools or distribute into the environment. To use Distribute instead of setuptools, just call virtualenv like this:
"
read readline
echo "
$ python virtualenv.py --distribute ENV

You can also set the environment variable VIRTUALENV_USE_DISTRIBUTE.

A new virtualenv also includes the pip installer, so you can use ENV/bin/pip to install additional packages into the environment."

read readline

echo "virtualenv --no-site-packages mycodenode_env
pip -E mycodenode_env install -U twisted django
pip -E mycodenode_env install -e git://github.com/codenode/codenode.git#egg=codenode
First we create a fresh virtualenv absent of all pre-installed packages that already exist in the global
site-packages. Then we get the very latest Twisted and Django and install the directly into our new
virtualenv. Lastly, we install the latest codenode directly from the it's source code repository. A lot of
goodness in 3 lines, to say the least. 
"
read readline





