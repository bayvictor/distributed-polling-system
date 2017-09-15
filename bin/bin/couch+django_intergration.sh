echo "
An Introduction to Using CouchDB with Django
08/18/2008
django(73)couchdb(6)

Welcome to the final installment of this series, which has looked at the advantages of Django's loose binding philosophy. At first, we looked at replacing Django's templating system with Jinja2. Next, we looked at using SQLAlchemy instead of Django's ORM, and in this third segment we are going to look at using CouchDB instead of a traditional object relational database for data storage.

CouchDB is one of the more exciting projects--measured in number of semi-plausible day dreams it has inspired--I've run into in the past year. It is an ideological rival to relational databases, and instead of being focused on highly detailed schemas (long ints, varchars of length 25, and blobs of binary data, oh my) it deals in documents. These documents may be comprised of identical fields, but may also contain dissimilar fields, allowing the same flexibility as Google's BigTable. Beyond that, CouchDB brings some other unexpected goodies to the table like document versioning1.

Before we get started you'll need to install CouchDB, which won't be covered in this tutorial (install on OS X, install on Windows, install on Ubuntu).
Our Project

In this tutorial we're going to use CouchDB to store the data for a simple Django webapp which will allow us to post and edit simple text documents online. Before we get started we have a bit of setup to do.

    First we need to have Django installed. We'll be using the SVN version, which can be installed like this (note that you'll bee to replace SITE-PACKAGES-DIR with your Python's site-packages directory):
will do:
    svn co http://code.djangoproject.com/svn/django/trunk/ django-trunk
    ln -s `pwd`/django-trunk/django SITE-PACKAGES-DIR/django

"
echo "^C to break, anykey to continue.....";read readline

    svn co http://code.djangoproject.com/svn/django/trunk/ django-trunk
    ln -s `pwd`/django-trunk/django SITE-PACKAGES-DIR/django

echo "    Next, we need to install the Python library, couchdb-python, which interfaces with CouchDB.
will do:
    easy_install couchdb

"
echo "^C to break, anykey to continue.....";read readline

    easy_install couchdb

echo "    Third, we need to create a Django project (for those who don't want to go through all the steps themselves, you can download a zip file containing the code created in this tutorial).
will do:
    django-admin.py startproject comfy_django_example

    You may not have django-admin.py in your system path, in which case you'll need to run it from inside your local checkout of Django. For me that looks like:

    ~/svn/django-trunk/django/bin/django-admin.py startproject comfy_django_example

    Now, we need to create a Django application inside of our comfy_django_example project.
"
    django-admin.py startproject comfy_django_example
    ~/svn/django-trunk/django/bin/django-admin.py startproject comfy_django_example

echo "^C to break, anykey to continue.....";read readline

    cd comfy_django_example
    python manage.py startapp couch_docs

echo "
    We\'re almost done getting setup, just need to configure a few settings. Go ahead and open up the settings.py file in the comfy_django_example folder. We\'ll make this change:

    INSTALLED_APPS = (
        'comfy_django_example.couch_docs',
    )

    We'll also edit the comfy_django_example/urls.py file to look like this:

    urlpatterns = patterns('comfy_django_example',
        (r'^', include('couch_docs.urls')),
    )
"

echo "Getting to Know CouchDB

Before we go on and start fleshing out the webapp, lets spend a few minutes playing with CouchDB at the Python command line.

First, we need to start running CouchDB. If you have symlinks properly setup, it should be as simple as:

some-computer:~ user$ couchdb
Apache CouchDB 0.8.0-incubating (LogLevel=info)
Apache CouchDB is starting.
Apache CouchDB has started. Time to relax.

Now fire up a Python interpreter.
"
echo "^C to break, anykey to continue.....";read readline

echo "

python

First you need to create an instance of Server which represents the local CouchDB server running on your computer.

>>> from couchdb import *
>>> s = Server('http://127.0.0.1:5984/')
>>> s
<Server 'http://127.0.0.1:5984/'>
>>> len(s)
0

Now lets create a couple of databases, iterate through all the databases, and delete the database.

>>> s.create('users')
>>> s.create('docs')
>>> len(s)
2
>>> for x in s:
...     print x
... 
docs
users
>>> del s['users']
>>> del s['docs']
>>> len(s)
0

Now lets create another database, and actually store some data in it.

>>> db = s.create('docs')
>>> len(db)
0
>>> db.create({'type':'Document','title':'Document One','txt':"This is some text."})
u'fd179491f0d95268eb1761e0439cf3e2'
>>> len(db)
1

We can also create named documents as well.

>>> db['manifesto'] = {'type':'Document','title':'Personal Manifesto','txt':'I strongly believe in something. I think.'}
>>> db['manifesto']
<Document u'manifesto'@u'818144524' {u'txt': u'I strongly believe in something. I think.', u'type': u'Document', u'title': u'Personal Manifesto'}>

Retrieving and extracting data from documents is easy as well.

>>> a = db['manifesto']
>>> a['title']
u'Personal Manifesto'
>>> a['title'] = "Ehm. Lame title."
>>> a
<Document u'manifesto'@u'818144524' {u'txt': u'I strongly believe in something. I think.', u'type': u'Document', u'title': 'Ehm. Lame title.'}>

If we want to run a specific query, we write a JavaScript function for this. For example, lets say wanted to retrieve all documents with a title greater than length 4, we'd write this JavaScript:

function(d) {
    if (d.title.length > 4) emit(d.name, null);
}

Now, to run that query in Python we have to do this:

>>> func_str = "function(d) { if (d.title.length>4) emit(d.title,null); }"
>>> for row in db.query(func_str):
...     print row.key
... 
Document One
Personal Manifesto

Its a bit hard to understand whats going on in that query, so lets break it down. emit is used for returning the data you want; the first argument is the key in the result set, and the second argument is the value in the result set. The next example should help clarify things.

>>> func_str = "function(d) { if (d.title.length>4) emit(d.title,d); }"
>>> results = db.query(func_str)
>>> results
<ViewResults <TemporaryView 'function(d) { if (d.title.length>4) emit(d.title,d); }' None> {}>
>>> for row in results:
...     print row.key
...     print row.value
... 
Document One
{u'txt': u'This is some text.', u'_rev': u'709275850', u'_id': u'fd179491f0d95268eb1761e0439cf3e2', u'type': u'Document', u'title': u'Document One'}
Personal Manifesto
{u'txt': u'I strongly believe in something. I think.', u'_rev': u'818144524', u'_id': u'manifesto', u'type': u'Document', u'title': u'Personal Manifesto'}

We can also access the data using list comprehensions.

>>> [ x.key for x in results]
[u'Document One', u'Personal Manifesto']

Now for the last example we'll walk through all the steps at once.

>>> from couchdb import *
>>> s = Server('http://127.0.0.1:5984/')
>>> db = s.create('software')
>>> db['FireFox'] = {'type':'browser','title':'FireFox'}
>>> db['Safari'] = {'type':'browser','title':'Safari'}
>>> db['Aquamacs'] = {'type':'editor','title':'Aquamacs'}
>>> len(db)
3
>>> only_browsers = 'function(d) { if (d.type == "browser") emit(d.title,d); }'
>>> [ x.key for x in db.query(only_browsers) ]
[u'FireFox', u'Safari']
>>> del s['software']

With that command line experimentation under our belt, its pretty easy to imagine how to use CouchDB for most of your data storing, retrieval and manipulation needs. Now on to our coup de grace2: integrating CouchDB with Django.
Integrating CouchDB with Django

We're going to put together a very simple application. It'll have two views: the index view will display a list of all available documents and allow you to create a new document, and the detail view will allow you to edit an existing document.

First, lets create the couch_docs/urls.py file.

from django.conf.urls.defaults import *
urlpatterns = patterns('comfy_django_example.couch_docs.views',
    (r'^doc/(?P<id>\w+)/','detail'),
    (r'^$','index'),
)

Next, we need to edit the couch_docs/views.py file. We'll start with the imports and also some code to create a CouchDB database named docs if it doesn't already exist.

from django.http import Http404,HttpResponseRedirect
from django.shortcuts import render_to_response
from couchdb import Server
from couchdb.client import ResourceNotFound

SERVER = Server('http://127.0.0.1:5984')
if (len(SERVER) == 0):
    SERVER.create('docs')

If you were following best practices you'd probably want to create a COUCHDB_SERVER entry in your settings.py file and then do something like this:

from django.conf import settings
SERVER = Server(getattr(settings,'COUCHDB_SERVER','http://127.0.0.1:5984'))

But for the time being we'll stick with the simpler, albeit less flexible, solution of specifying the server in the views.py file itself. Now, lets write the views.

The index view does two things. On a GET request it displays all the existing documents in the database, and on a POST request it creates a new document and redirects to that document's detail view.

def index(request):
    docs = SERVER['docs']
    if request.method == "POST":
        title = request.POST['title'].replace(' ','')
        docs[title] = {'title':title,'text':""}
        return HttpResponseRedirect(u"/doc/%s/" % title)
    return render_to_response('couch_docs/index.html',{'rows':docs})

Notice that we're passing rows as extra context for the index.html template in the exact same way we'd pass data queried using the Django ORM.

The detail view has two functions as well. If it gets a GET request, then it will display the document (along with a form for editing it), and on POST requests it will update the document. We'll also want to throw a 404 error code if someone requests a document that doesn't exist.

def detail(request,id):
    docs = SERVER['docs']
    try:
        doc = docs[id]
    except ResourceNotFound:
        raise Http404
    if request.method =="POST":
        doc['title'] = request.POST['title'].replace(' ','')
        doc['text'] = request.POST['text']
        docs[id] = doc
    return render_to_response('couch_docs/detail.html',{'row':doc})

Please note that the docs[id] = doc line is not optional, and the entry for the document will not be updated without that line, despite update the documents keys. I'm uncertain if that is an oversight in the library or an intentional decision to cut back on http requests, but it can be a confusing gotcha.

Now we just have to write the templates. First, create the template directories in the comfy_django_example/couch_docs/ folder.

cd comfy_django_example/couch_docs/
mkdir templates
mkdir templates/couch_docs
cd templates/couch_docs/

And then create the index.html template.

<html> <head>
<title>Comfy Django</title>
</head>
<body>
<h1>CouchDB in Django</h1>
<form method="post" action=".">
<table>
  <tr>
    <td> Title for new document </td>
    <td><input type="text" name="title"></td>
    <td><input type="submit"></td>
  </tr>
</table>
</form>
<hr>
<ol>
  {% for row in rows %}
  <li><a id="title" href="/doc/{{ row }}/">{{ row }}</a></li>
  {% endfor %}
</ol>
</body> </html>

And the detail.html template as well.

<html> <head>
<title>CouchDB in Django: {{ row.title }}</title>
</head>
<body>
<h1>CouchDB in Django: {{ row.title }}</h1>
<a href="/">Return to index</a>

<table>
  <tr>
    <td> Title </td>
    <td id="title">{{ row.title }}</td>
  </tr>
  <tr>
    <td> Text </td>
    <td id="text">{{ row.text }}</td>
  </tr>
</table>
<hr>
<form method="post" action=".">
<table>
  <tr>
    <td> Title for new document </td>
    <td><input type="text" name="title" value="{{ row.title }}"></td>
  </tr>
  <tr>
    <td> Text </td>
    <td><textarea name="text">{{ row.text }}</textarea></td>
  <tr>
    <td><input type="submit"></td>
  </tr>
</table>
</form>
</body> </html>

And that sums up our new web app. Go ahead and give it a whirl.

couchdb &
cd comfy_django_example
python manage.py runserver

And then navigate to http://127.0.0.1:8000 to see it in action. Its simple, but it should be enough to get your creative juices flowing a bit about what you could do by combining Django and CouchDB. Especially as CouchDB continues to mature, I think this'll be a potent pairing.
Downloading a Copy of Tutorial

You can download the zip file containing this project here, but for the most up-to-date version it'll be easiest to check the tutorial's repository on GitHub.
Why Would We Ever Actually Do This?

So, thats an important question. Is there a situation where using Django with CouchDB makes substantially more sense than using it with PostgreSQL or MySQL? Are we actually gaining something useful while we forsake the Django Admin (and the sessions framework, etc)?

There are a number of reasons why CouchDB is legitimately worth considering despite the inconveniences. Consider a wiki that allowed users to download a copy of its contents and modify them. If it was implemented with CouchDB, the users could then upload their contents and merge them into the database. The implementer wouldn't need to write custom code for this, its part of CouchDB's feature set. If some of the new data was bad, you could then use the versioning system to rollback to a previous revision (unless it had already gotten deleted by compacting the database... ahem).

Also, consider something like FreeBase which creates schema seemingly on the fly for different types of data. It would be extremely unpleasant to do that in a relational database, because you'd be constantly creating and modifying schema. But in CouchDB, if you wanted to add another field for a piece of data, then you'd just add the data, and it would just work. Having flexible (or, really, non-existant) schema makes it easy to implement some kinds of applications that would require a few drops of the genius elixer to solve with rigidly defined schema3.

Finally, there is the recurring thread from Damien Katz that--once they start optimizing--CouchDB may become impressively fast.
Can We Have Our Cake and Eat it Too?

Yes. Yes, you can. You could use an SQLite or PostgreSQL database to manage your sessions and users, and only use CouchDB to store the document data. In that way, you'd get to use the Django Admin for much of your data, and could still take advantage of CouchDB's document-based storage for the applicable pieces of your application.

The additional complexity from doing so wouldn't be terribly high, at least for the initial programmer. However, scaling such an application would require more thought and effort than scaling an application with only relational databases or that only used CouchDB. It would also be more difficult to efficiently deploy such a service with limited resources (like on a small VPS). These technical hurdles wouldn't be insurmountable, but probably wouldn't be a lot of fun to deal with either.
Wait, That isn't the Cake I Wanted To Eat

Oh. So you want to implement the sessions frameworks on top of CouchDB? You could certainly custom roll an authentication framework using CouchDB, and it is probably possible--although likely requiring a superhuman effort to the extent of translating SQL statements into commands for CouchDB--to create a Django backend that seamlessly used CouchDB instead of a traditional relational database.

If anyone does want to undertake that project, they should probably wait until CouchDB reaches 1.0 and the API stabilizies. But... even then I imagine the project would be something of a hellish quagmire that would make children out of men and break spirits faster than being asked to implement Perl regular expressions with a pushdown autonoma.
Ending The Loose Coupling in Django Series

As this article winds to a close, so does the series encompassing it which looked at Jinja2, SQLAlchemy and now CouchDB and how Django's philosophy of loose coupling allowed them to easily integrate with Django. For me, one of the enduring thoughts after writing these entries is that the loose coupling certainly isn't perfect, but it'll let you do whatever you want if you're willing to pay the toll in time.

And, for my time, the prices at the toll ain't half bad.

    Which in some ways makes it seem a bit similar to a versioning system. I know GitHub created a pastie-like service implemented on top of git, and I also recall an article, perhaps by Linus, suggesting that wikis could be beneficially implemented on top of git. Perhaps a Ruby on Rails backend using Git for storage or a Django backend using Mercurial for storage would be a fun project to play with. That said, its a bit different from a versioning system because it doesn't try all that hard to maintain old revisions, and will delete them in order to compact the size of the database.↩

    I'd be willing to consider to any argument that suggested I am misusing the phrase coup de grace here. I mostly just like how it sounds and have run out of connection words ('next', 'finally, 'thirdly','one hundredthly', etc) to use in this tutorial.↩

    Although I'm sure that relational database supporters will point out that removing rigidity from schema introduces some problems as well. I think thats a pretty fair statement to make, but perhaps not as important as they might suggest.↩

Will Larson

Your delightful host.
Email: lethain[at]gmail
Develop at SocialCode.
Used to Digg, and Y!.
Page Analytics

    Views: 40628
    Daily Views: 23
"

