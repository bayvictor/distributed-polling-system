def subdir_pdf2txt(saved_dir =  '../pdf2txt', outfn="all.len.cnfrq"):
  
  os.popen( 'mkdir '+ saved_dir )
  p = os.popen('find  -type f | grep -e "\.pdf$" ' )
  files0 = p.readlines()
  files = [ x.strip() for x in files0 ]
  p.close()

  word_dict = {}

  os.system("find . ")
  outf   = open( outfn, "wt" ) 
  #outf   = open( "all.len.cnfrq", "wt" ) 
  
  for ii  in range(len(files)):
    filename = files[ii] 
    outfn = saved_dir + "/" + 
    print "merging len:word items in filename["+str(ii)+"]=("+filename+") into (" + outfn + ")"
    parse_cnfrq_file_then_write_fixed_wordlen_n_word_to_outf (outf, filename )

  outf.close()

 )
