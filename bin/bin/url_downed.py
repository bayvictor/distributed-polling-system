"""
Tutorial - Passing variables

This tutorial shows you how to pass GET/POST variables to methods.
"""

import cherrypy


class WelcomePage(a_url, url_downed_fn="list_zips.txt"):
    new_line = ''.join( ch if ch.isalnum() else ' ' for ch in a_url )  #repl all [^0-9a-zA-Z] with ' '
    ii_start = new_line.find("https___github.com_"); slen = len("https___github.com_")
    ii_end = new_line.find("_archive_master.zip")
    trunk = new_line[ii_start+slen:ii_end]
    url_down_fn
    local_zips=[]
    try:
      fin=open( url_down_fn, "r")
    except:
      print "downloaded zip filename=("+url_down_fn+") not found!"
      sys.exit(1)
    lines = fin.readlines()
    for line in lines:	  
    local_zips.append( line.strip() )


    def index(self):
        # Ask for the user's name.
        return '''
            <form action="greetUser" method="GET">
            What is your url?
            <input type="text" name="name" />
            <input type="submit" />
            </form>'''
    index.exposed = True
    
    def greetUser(self, name = None):
        # CherryPy passes all GET and POST variables as method parameters.
        # It doesn't make a difference where the variables come from, how
        # large their contents are, and so on.
        #
        # You can define default parameter values as usual. In this
        # example, the "name" parameter defaults to None so we can check
        # if a name was actually specified.
        
        if name:
            # Greet the user!
            if trunk in local_zips:
              return "%s found!" % name
            else 
              return "%s not downloaded yet!" % name 
        else:
            if name is None:
                # No name was specified
                return 'Please enter your url <a href="./">here</a>.'
            else:
                return 'No, really, enter your url <a href="./">here</a>.'
    greetUser.exposed = True


import os.path
tutconf = os.path.join(os.path.dirname(__file__), 'tutorial.conf')

if __name__ == '__main__':
  if len(sys.argv) < 3: 
    print "Format: "+sys.argv[0]+ " <query_url> <download_fn_list>"
    print "e.g.: 	"+sys.argv[0]+ " \"https://github.com/asigottech/Development-code-of-conduct/archive/master.zip\"   \"downed_list.txt\""
    sys.exit(1)

  url  = sys.argv[1] 
  downed_fn  = sys.argv[2] 

  


    # CherryPy always starts with app.root when trying to map request URIs
    # to objects, so we need to mount a request handler root. A request
    # to '/' will be mapped to HelloWorld().index().
    cherrypy.quickstart(WelcomePage(), config=tutconf)
else:
    # This branch is for the test suite; you can ignore it.
    cherrypy.tree.mount(WelcomePage(), config=tutconf)





