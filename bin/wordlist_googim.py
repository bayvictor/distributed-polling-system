#!/usr/bin/python

import urllib, urllib2, re, os, optparse, socket,sys

socket.setdefaulttimeout( 5 )

opts = optparse.OptionParser( usage="Usage: gimg.py [options] <search_terms>" )
opts.add_option( "-s", "--safe", dest="safesearch", default=False,
    help="Enable Google's SafeSearch", action="store_true" )
opts.add_option( "-c", "--count", dest="targetcount", default=20,
    help="Download NUM images", metavar="NUM", type="int" )
opts.add_option( "-r", "--resumecount", dest="resumecount", default=0,
    help="Resume from Downloaded RSNUM images", metavar="RSNUM", type="int" )
opts.add_option( "-v", "--verbose", dest="verbose", default=False,
    help="Make a lot of noise.", action="store_true" )
( options, args ) = opts.parse_args()

if not len( args ) :
    opts.print_help()
    quit()

# combine the search terms and URL encode them
term = urllib.quote( reduce( lambda x,y: x+' '+y, args ) )
fterm = urllib.quote( reduce( lambda x,y: x+'-'+y, args ) )
filename = ''.join((fterm,"%%0%dd" % len(str(options.targetcount)), "%s"))
print filename

useragent = 'Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 5.0)'
searchbase = "http://images.google.com/images?"
searchterm = "&q="
searchmod = "&start="

# (en/dis)able SafeSearch by CLI flag
if options.safesearch:
    searchbase += "safe=on"
else:
    searchbase += "safe=off"

# add the search terms
searchbase += searchterm + term
if options.verbose: print "SEARCHING: ", searchbase

collected = []
cataloged = 0
saved =  options.resumecount
skip_ii = 0

#while len( collected ) < options.targetcount:
while len( collected ) < options.targetcount - options.resumecount : #victor
    # create the search URL
    search = searchbase + searchmod + str(cataloged)
    
    # create a request and add a User-agent
    req = urllib2.Request( search )
    req.add_header( 'User-agent', useragent )
    
    # grab the results page
    if options.verbose:
        print "RETRIEVING: ", search
    res = urllib2.urlopen( req )
    google = res.read()
    
    # pull out the image URLs
    if options.verbose: print "PARSING...\n",
    matches = re.findall( "(?<=imgres\?imgurl\=).*?(?=&imgrefurl)", google )
    if not matches:
        print "Nothing found"
        quit()
    
    cataloged += len(matches)
    
    for match in matches:
        if skip_ii <  options.resumecount:   # skip top resumecount for downed
            skip_ii += 1
            continue
        
        collected.append( match )
        if options.verbose:
            print "\tFOUND: ", match
    if options.verbose: print "...DONE\n",
    
    while collected:
        current = collected.pop(0)
        # download the image data
        if options.verbose:
            print "FETCHING #", (saved + 1), "of", \
                options.targetcount, ": ", current
        req = urllib2.Request( current )
        req.add_header( 'User-agent', useragent )
        try:
            res = urllib2.urlopen( req )
        except urllib2.HTTPError, ex:
            print "\tFailed: HTTP error -", ex.code
            continue
        except urllib2.URLError, ex:
            print "\tFailed: URL error -", ex.reason
            continue
        
        # create the filename
        fname = ""
        if current.rfind('.') > 0:
            fname = filename % (saved, current[current.rfind('.'):])
        else:
            fname = filename % (saved, "")
        
        # write out the file
        if options.verbose: print "\tWriting...",
        
        try:
            tfile = os.open( fname, os.O_WRONLY | os.O_CREAT )
            os.write( tfile, res.read() )
        except:
            print sys.exc_info()[0]
            continue
        saved += 1
        
        if options.verbose: print "done\n",
        
        if saved >= options.targetcount - options.resumecount:
            quit()

