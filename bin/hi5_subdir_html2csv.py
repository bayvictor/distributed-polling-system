#!/usr/bin/python
# -*- coding: utf-8 -*-
#Menu system
"""
input: id.txt firefox profile.ini(path)
output: username within email in id.txt file be added to firefox profile
  cloned with firefox default!
  so later it can be called from command-line by:
firefox -no-remote -P secondprofilename

to do: wget --load-cookies + login to update cookies in real-time!  ...
"""

from collections import OrderedDict 
import sys,os
import string
import locale
import math

def print_out_dict( out_dict ):
  left_char_bra  = "`({[<^"
  right_char_bra = "`)}]>$"

def get_wishlist( text, out_dict, txt_filename = "" ):
  ids            = ["wishlist",                         "sold.pets",           "own.pets",          "logs"          ]
  left_str_bra   = ["on your Wish List",                "Recently Sold",       "My Pets",           "What\'s New"   ]  
  right_str_bra  = ["\"id-module-announcements-col2\"", " Updates</span><img", "on your Wish List", "My Pets"] 
    #where for wishlist tail is also head_bra
  for ii in range (0, len(ids)):
    out_dict[ids[ii]] = ""         ## init as empty 

  for ii in range (0, len(ids)):
#   pos_end = text.find( right_str_bra[ii] )
#   if -1 == pos_end:
#      continue 
#   pos_start = text.find( left_str_bra[ii] , pos_end + len(right_str_bra[ii]) )  ## skip blockhead 'prev
   print "processing id["+str(ii)+"]=("+ids[ii]+")"
   pos_start = text.find( left_str_bra[ii]  )  ## skip blockhead 'prev
   if -1 == pos_start:
     print "start token ("+left_str_bra[ii]+")+ not found!"
     continue
   pos_end = text.find( right_str_bra[ii]  , pos_start + len(left_str_bra[ii]))
   if -1 == pos_end:
     print "end token ("+right_str_bra[ii]+")+ not found!"
     continue 
   outtext = text[pos_start:pos_end]
   out_dict[ids[ii]] += outtext
   outf =  open( txt_filename + "_"+ ids[ii],'a+t')
   outf.write( outtext+"\n" )   
   outf.close()

def float_pair02( str1, str2 ): ## string pair of integer or float, all return tuple of float number
  if -1 == str1.find("."):
    str1 +=".0"
  if -1 == str2.find("."):
    str2 +=".0"
  num1 = string.atof(str1)
  num2 = string.atof(str2)
  return( num1, num2)

def float_pair( str01, str02 ): ## string pair of integer or float, all return tuple of float number
  str1 = num_str_cut_tail( str01 )
  str2 = num_str_cut_tail( str02 )

  if -1 == str1.find("."):
    str1 +=".0"
  if -1 == str2.find("."):
    str2 +=".0"
  num1 = string.atof(str1)
  num2 = string.atof(str2)
  return( num1, num2)

def string_oper( str1, str2, op ):
  num1,num2 = float_pair( str1, str2 )
  if '+' == op[0]:
    result = num1 + num2
  if '-' == op[0]:
    result = num1 - num2
  if '*' == op[0]:
    result = num1 * num2
  if '/' == op[0]:
    result = num1 / num2
  if '^' == op[0]:
    result = math.pow( num1 , num2)
  if 'p' == op[0]:
    result = math.pow( num1 , num2)
  if 'l' == op[0]:
    result = math.log( num1 , num2 )


  
  return( str(result) )

def string_minus( str01, str02 ):
  str1 = num_str_cut_tail( str01 )
  str2 = num_str_cut_tail( str02 )
  num1,num2 = float_pair( str1, str2 )
  result = num1 - num2
  return( str(result) )

def num_str_cut_tail( str ):
  for ii in range (0, len(str) ):
    if str[ii] > '9':
      return str[:ii]
    if str[ii] < '0':
      return str[:ii]
  return str

def comma_string_to_num( str , html = False ):
  dollar_start = str.find('$')
  if -1 == dollar_start: # no money in line
    return ""
  mid_str = str [dollar_start+1:]
  if True == html :
    dollar_end = mid_str.find('"')  # get first '$' starting str in title instead
  else :
    dollar_end = mid_str.find(' ')
    
  print "str = ("+str+")"
  print "mid_str = ("+mid_str+")"


  result =  mid_str[:dollar_end].replace(",", "") 
  result = num_str_cut_tail( result )
#  if -1 == dollar_end:
#    return result
  if -1 != mid_str.find(" Q "):
    result = result[:-6] ## cut 6 digits, "1S defult to 1M Q"  if -1 != mid_str.find(" Q "):

  if -1 != mid_str.find(" N "):
    result = result+"0000000" ## append 6 zeros "1S defult to 1M Q"  if -1 != mid_str.find(" Q "):

#  if True == html:
#    result = result[:-9]   ## convert into S, for title is N <<Q in this case
  #print "result=("+ result + ")"
  return  result   ## e.g. input: "1,000,000"; output:  1000000

## the 'exposive' type of parser.... no parsing from head, tail any more  
def hi5_txt_to_csv_with_dic( copy_paste_txt_filename, delim =",", dic=OrderedDict(sorted({}.items(), key=lambda t: t[0])) ): # key as order
  found = False

  lines0 = os.popen( "cat "+ copy_paste_txt_filename ).readlines()
  #print "len=("+str(len(lines0)) +") lines read."
  outf =  open( copy_paste_txt_filename+".csv",'wt')

  ## strip out the last '\n' at the end of the lines in both lists,
  ## by using list comprehension
  lines = [ ss.strip() for ss in lines0 ]

  for ii in range( 0, len(lines)):
    line =  lines[ii]

    ## only consider when both Assets and '$' present    
    if -1 == line.find("Assets:"):
      continue
    if -1 == line.find("$"):
      continue
    ## now we find line Assets
    dic["name"]=  lines [ ii-3 ]
    dic["value"]= comma_string_to_num( lines [ ii-2 ] )
    dic["cash"]= comma_string_to_num( lines [ ii-1 ] )
    dic["asset"]= comma_string_to_num( lines [ ii ] )
    dic["fix_asset"]= string_minus( dic["asset"], dic["cash"]  )
    dic["fix_asset.cash"]= string_oper( dic["fix_asset"], dic["cash"], "*"  )
    dic["buy.inc.times"] = string_oper( dic["fix_asset.cash"], dic["cash"], "+"  )
#    dic["c_o_v"]= string_minus( dic["cash"],  dic["value"] )
#    dic["a_o_v"]= string_minus( dic["asset"], dic["value"] )
#    dic["f_o_v"]= string_minus( dic["fix_asset"], dic["value"] )
#    dic["last_active"]= lines [ ii+1 ]
#    dic["last_buy"]= lines [ ii+2 ]
    dic["tail"]= lines [ii+3]
#    outstr=dic["name"] + delim
    outstr=""
    for key in dic.keys():
      outstr += dic[key]+delim
    outstr += "\n"
    #outstr = name+delim+ value + delim + cash + delim  + asset + delim + fix_asset 
    #outstr += last_active+delim +last_buy+delim + tail+delim+"\n"
    outf.write( outstr ) ## Asset value

  outf.close()



## the 'exposive' type of parser.... no parsing from head, tail any more  
def hi5_html_merge_to_csv_with_dic( copy_paste_txt_filename, delim =",", dic=OrderedDict(sorted({}.items(), key=lambda t: t[0])) ): # key as order


  found = False

  lines0 = os.popen( "cat "+ copy_paste_txt_filename +"|sed 's|>    next &gt;</a></div>|@|g' |sed 's|>Buy now!</button></div> |@|g' |sed 's|<li> <label>|@|g'|tr '@' '\n' " ).readlines()
  #print "len=("+str(len(lines0)) +") lines read."
  outf =  open( copy_paste_txt_filename+".csv",'wt')

  ## strip out the last '\n' at the end of the lines in both lists,
  ## by using list comprehension
  lines = [ ss.strip() for ss in lines0 ]


  for ii in range( 0, len(lines)):
    line =  lines[ii]

    ## only consider when both Assets and '$' present    
    if -1 == line.find("Assets:"):
      continue
    if -1 == line.find("$"):
      continue
    ## now we find line Assets
    ## now we find line Assets
    url  =  lines [ ii-3 ]
    dic["hi5id"]    =  get_url_attribute( url, "data-event" )
    dic["name"]  =  get_url_attribute( url, "alt" )
#    dic["value"]= comma_string_to_num( lines [ ii-2 ] )
#    dic["cash"]= comma_string_to_num( lines [ ii-1 ] )
    longest_val = comma_string_to_num(  get_url_attribute( lines [ ii-2 ], "title" ), True )
    dic["value_S"]= longest_val[:-29]+" MS"
#    dic["value_N"]= longest_val[:-35]+" MN"
#    dic["value"]= longest_val
    dic["cash"]= comma_string_to_num(  get_url_attribute( lines [ ii-1 ], "title" ), True )[:-29]+" MS"
    dic["asset"]= comma_string_to_num(  get_url_attribute( lines [ ii ], "title" ), True )[:-29]+" MS"
#    dic["cash"]= comma_string_to_num(  get_url_attribute( lines [ ii-1 ], "title" ), True )[:-35]+" MN"
#    dic["asset"]= comma_string_to_num(  get_url_attribute( lines [ ii ], "title" ), True )[:-35]+" MN"
    dic["fix_asset"]= string_minus( dic["asset"], dic["cash"]  )
    dic["fix_asset.cash"]= string_oper( dic["fix_asset"], dic["cash"], "*"  )
    dic["buy.inc.times"] = string_oper( dic["fix_asset.cash"], dic["cash"], "+"  )
    dic["img"]  =  get_url_attribute( url, "src" )
#    dic["c_o_v"]= string_minus( dic["cash"],  dic["value"] )
#    dic["a_o_v"]= string_minus( dic["asset"], dic["value"] )
#    dic["f_o_v"]= string_minus( dic["fix_asset"], dic["value"] )
#    dic["last_active"]= lines [ ii+1 ]
#    dic["last_buy"]= lines [ ii+2 ]
    if ii+3 in range( 0, len(lines) ):
      dic["tail"]= get_html_class_attribute( lines [ii+3], "id-petCount" ) + delim + get_html_class_attribute( lines [ii+3], "id-wisherCount" )
#    outstr=dic["name"] + delim
    outstr=""
    for key in dic.keys():
      outstr += key + delim
    outstr += "\n" ## this block sets title line

    for key in dic.keys():
      outstr += dic[key]+delim
    outstr += "\n"
    outf.write( outstr ) 

  outf.close()

def get_html_class_attribute( url, attr ):
  item =  attr + "\">" 
  start = url.find( item )
  if -1 == start: 
    return ""   
  end = url.find( '<', start + len(item) )
  result = url[ start  + len(item): end ]
  return result



def get_url_attribute( url, attr ):
  item =  attr + "=\"" 
  start = url.find( item )
  if -1 == start: 
    return ""   
  end = url.find( '"', start + len(item) )
  result = url[ start  + len(item): end ]
  return result

## the 'exposive' type of parser.... no parsing from head, tail any more  
def hi5_html_merge_to_csv( copy_paste_txt_filename, delim ="," ):
  found = False

  lines0 = os.popen( "cat "+ copy_paste_txt_filename +"|sed 's|>    next &gt;</a></div>|@|g' |sed 's|<li> <label>|@|g'|tr '@' '\n' " ).readlines()
  #print "len=("+str(len(lines0)) +") lines read."
  outf =  open( copy_paste_txt_filename+".csv",'wt')

  ## strip out the last '\n' at the end of the lines in both lists,
  ## by using list comprehension
  lines = [ ss.strip() for ss in lines0 ]

  for ii in range( 0, len(lines)):
    line =  lines[ii]

    ## only consider when both Assets and '$' present    
    if -1 == line.find("Assets:"):
      continue
    if -1 == line.find("$"):
      continue
    ## now we find line Assets
    url  =  lines [ ii-3 ]
    name  =  get_url_attribute( url, "alt" )
    hi5id    =  get_url_attribute( url, "data-event" )
    img  =  get_url_attribute( url, "src" )
    value = comma_string_to_num( lines [ ii-2 ] )
    cash  = comma_string_to_num( lines [ ii-1 ] )
    asset = comma_string_to_num( lines [ ii ] )
    fix_asset = string_minus( asset, cash  )
    c_o_v     = string_minus( cash,  value )
    a_o_v     = string_minus( asset, value )
    f_o_v     = string_minus( fix_asset, value )
    last_active = lines [ ii+1 ]
    last_buy = lines [ ii+2 ]
    tail = lines [ii+3]
    outstr = name+delim+ value + delim + cash + delim  + asset + delim + fix_asset 
    outstr += last_active+delim +last_buy+delim + tail+delim+"\n"
    outf.write( outstr ) ## Asset value

  outf.close()




## the 'exposive' type of parser.... no parsing from head, tail any more  
def hi5_txt_to_csv( copy_paste_txt_filename, delim ="," ):
  found = False

  lines0 = os.popen( "cat "+ copy_paste_txt_filename ).readlines()
  #print "len=("+str(len(lines0)) +") lines read."
  outf =  open( copy_paste_txt_filename+".csv",'wt')

  ## strip out the last '\n' at the end of the lines in both lists,
  ## by using list comprehension
  lines = [ ss.strip() for ss in lines0 ]

  for ii in range( 0, len(lines)):
    line =  lines[ii]

    ## only consider when both Assets and '$' present    
    if -1 == line.find("Assets:"):
      continue
    if -1 == line.find("$"):
      continue
    ## now we find line Assets
    name  =  lines [ ii-3 ]
    value = comma_string_to_num( lines [ ii-2 ] )
    cash  = comma_string_to_num( lines [ ii-1 ] )
    asset = comma_string_to_num( lines [ ii ] )
    fix_asset = string_minus( asset, cash  )
    c_o_v     = string_minus( cash,  value )
    a_o_v     = string_minus( asset, value )
    f_o_v     = string_minus( fix_asset, value )
    last_active = lines [ ii+1 ]
    last_buy = lines [ ii+2 ]
    tail = lines [ii+3]
    outstr = name+delim+ value + delim + cash + delim  + asset + delim + fix_asset 
    outstr += last_active+delim +last_buy+delim + tail+delim+"\n"
    outf.write( outstr ) ## Asset value

  outf.close()

def any_file_to_csv_with_dic( txt_filename, delim, dic, outfn_prefix ="" ):
  text = popen( copy_paste_txt_filename ).read().lower()
  ltext = text.lower() 
  myString = '<html>'
  pattern = r'<\s*'+re.escape(myString) + "\s*" + r'>'

  searchObj = re.search( pattern, ltext, re.M|re.I)
  if searchObj:
    print "search --> searchObj.group(1) : ", searchObj.group(1)
  else:
    print "<html> not  found!!"
    hi5_txt_to_csv_with_dic( txt_filename, delim, dic )
    return
  #print "len=("+str(len(lines0)) +") lines read."
  outf =  open( copy_paste_txt_filename+".csv",'wt')

  get_wishlist( text, out_dict, outfn_prefix )


def subdir_all_hi5_html_to_csv( dic ):
  lines0 = os.popen( 'tree -f -L 1|grep -e \"html$\" |cut -d\" \" -f2 ' ).readlines()
  #print "len=("+str(len(lines0)) +") lines read."

  ## strip out the last '\n' at the end of the lines in both lists,
  ## by using list comprehension
  lines = [ ss.strip() for ss in lines0 ]
  out_dict = {}

  for ii in range( 0, len(lines)):
    line =  lines[ii]  ## each line is a html filename 
    text = os.popen( "cat "+ line ).read()
    print "processing file("+ line +")....\n"
    get_wishlist( text, out_dict )       ## prefix empty


  for fn_key in out_dict.keys():
    print "last! csv generating for key=("+fn_key+")"
    cp_fn = "_"+ fn_key
    hi5_html_merge_to_csv_with_dic( cp_fn, delim, dic )
    ii = 0
    csv_filename = cp_fn + ".csv"
    for key in dic.keys():
      ii=ii+1  # start from 2nd col, because 1st fixed as "name"
      res = os.popen("cat "+ csv_filename+" |  sort -t "+delim+" -k "+str(ii)+" -g -r | uniq >" + csv_filename+"."+key+".srt" )
      print "return.os.popen.key["+key+"]=("+str(res)+"),sort.k=("+str(ii)+")"




if __name__=="__main__":
  locale.setlocale(locale.LC_ALL, 'en_US.UTF8')
  argv=sys.argv
  usage = "   hi5 wishlist parser! " + "  Usage: "+argv[0] +" outfn_prefix <delimeter> \n e.g.:  "+argv[0] +" aliyah \",\" "
   
#  copy_paste_txt_filename = "~/.mozilla/firefox/profiles.ini"
  
  if len(argv) < 3:
		print(usage)
		sys.exit(1)
    
  out_filename_prefix = argv[1]
  csv_filename = argv[1]+".csv"
  #dic = {}
  dic=OrderedDict(sorted({}.items(), key=lambda t: t[0])) ## OrderedDict remembers order, 
                                                          ## sorted by key, then when loop over dic.keys kept insert order
  #dic=OrderDict(sorted({}.items(), key=lambda t: t[1])) ## sorted by value
  #hi5_txt_to_csv( txt_filename, argv[2] )
  delim = argv[2]

  #any_file_to_csv_with_dic( txt_filename, delim, dic , out_filename_prefix )

  subdir_all_hi5_html_to_csv( dic )



