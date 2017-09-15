#!/usr/bin/python
# usage: python parsexml.py < infile 
"""
input: plain .csv downloaded file from adword
output:
	 fn+".kwd.txt":plain keyword;
	 fn+".grp.txt":adword group ;
	 fn+".notparsed.txt":unknown format ;
note: CPC, HIT       
"""
from decimal import Decimal  
import sys
import re
import os
import optparse
import time

TOTALSIZE = 0
CURSIZE = 0
STARTTIME = 0

"""
sort 3 types: keyword(kwd),adword_grp(grp), unknown(notparsed) 
"""
def sortfile(filename):
    words = filename.split(".")
    fn_tail=words[-2]+"."+words[-1]    
    if 'kwd.txt' == fn_tail:
	os.popen(' sort -t \",\" -k 6 -g -r '+ filename+ ' > ' + filename+".cpc_desc.txt" )
	os.popen(' sort -t \",\" -k 5 -g -r '+ filename+ ' > ' + filename+".hit_desc.txt" )
	os.popen(' sort -t \",\" -k 22 -g -r '+ filename+ ' > ' + filename+".markcap_desc.txt" )
    if 'grp.txt' == fn_tail:
	os.popen(' sort -t \",\" -k 6 -g -r '+ filename+ ' > ' + filename+".cpc_desc.txt" )
	os.popen(' sort -t \",\" -k 7 -g -r '+ filename+ ' > ' + filename+".hit_desc.txt" )
	os.popen(' sort -t \",\" -k 23 -g -r '+ filename+ ' > ' + filename+".markcap_desc.txt" )
    if 'notparsed.txt' == fn_tail:
	os.popen(' sort  -r '+ filename+ ' > ' + filename+".notparsed_desc.txt" )
    
    
    
    #filename
"""
parse and branch data into 3 out: keyword(kwd),adword_grp(grp), unknown(notparsed) 
"""
def stripfile(filepath):
    # read in file
    fin = open(filepath,'r')
    lines = fin.readlines()
    # open output file with '.parsed'
    fn_kwd = filepath+ '.kwd.txt' 
    fn_grp = filepath+".grp.txt"
    fn_err = filepath+".err.txt"
    fn_notparsed = filepath+".notparsed.txt"


    fout = open(fn_kwd, 'w')
    group_fout = open(fn_grp, 'w')
    err_fout = open(fn_err, 'w')
    notparsed_fout = open(fn_notparsed, 'w')
    docidx = 0
    for line in lines:
        line = line.strip()
	is_parsable= 0;
	is_group   = 0;
        words = line.split(",")
	if docidx %10000 == 0 :
	        print " docidx["+str(docidx)+"],line=("+line+"),len(words)="+str(len(words))
	if(len(words) < 6 ):  # not parsable by "," then try "\t"
		newwords=line.split("\t")
		if(len(newwords) < 6):     # not parsable 
			notparsed_fout.write( line+"\n" );
			docidx += 1
			continue        # next line
		else:
			words = newwords   
        if words[3] == "-" and words[6] == "-": #signature of single-kwd item 
						#     words[6] is number 7:words[5]:hits;words[4]:hits;words[5]:CPC; 
		for word in words:fout.write( word+"," );
		market_cap = 0.0
		try:
			market_cap = Decimal(float(words[4]))*Decimal(float(words[5])*float(words[5]))
		except ValueError:
		        print "Value Error! In Single-keyword process! docidx["+str(docidx)+"],line=("+line+"),len(words)="+str(len(words))
			err_fout.write( line+"\n" );
		fout.write(str(market_cap)+",");
        	fout.write("\n");
        else:
		market_cap = 0.0
		if( words[5]=='-' or  words[6]=='-' ): market_cap = 1.0
		else: 	
		        if words[3] == "-" and words[6] == "-": #signature of single-kwd ; 
				for word in words:fout.write(word+",");
				try:
					market_cap = Decimal(float(words[4]))*Decimal(float(words[5])*float(words[5]))
				except ValueError:
				        print "Value Error! In Single-keyword process! docidx["+str(docidx)+"],line=("+line+"),len(words)="+str(len(words))
					err_fout.write( line+"\n" );
				fout.write(str(market_cap)+",");

		        else:
				for word in words:group_fout.write(word+",");
				try:
					market_cap = Decimal(float(words[5]))*Decimal(float(words[6])*float(words[6]))
				except ValueError:
				        print "Value Error! In Single-keyword process! docidx["+str(docidx)+"],line=("+line+"),len(words)="+str(len(words))
					err_fout.write( line+"\n" );
				group_fout.write(str(market_cap)+",");

        	group_fout.write("\n");
        docidx += 1
    fout.close()
    group_fout.close()
    err_fout.close()
    notparsed_fout.close();
    sortfile(fn_kwd)
    sortfile(fn_grp)
    sortfile(fn_notparsed)

    return filepath

#####################################
if __name__ == '__main__':
    usage = "usage: %prog filename"
    p = optparse.OptionParser(usage=usage)
    p.add_option("-s", "--striponly", action="store_true", default=False, help="Only strip parsed files, no need to parse xml")
    
    (opts, args) = p.parse_args()
    if not len(args) == 1:
        print usage
        p.error('Please specify a filename to parse.')
    STARTTIME = time.time()
    if opts.striponly:
        stripfile(args[0])
    else:
        print "input syntax error! "
#####################################

