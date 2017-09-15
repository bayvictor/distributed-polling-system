#!/usr/bin/env python

import  psutil , os , time,sys 

def pid_living_timestamp( p ):
  p  = psutil.Process (os .getpid ())
  p .create_time ()
  #1293678383 .0799999 
  tt = time .strftime ("%Y -%m -%d  %H :%M :%S ", time .localtime (p .create_time ()))
  return (tt)

def kill_by_psname_lifespan( str, dead_age_in_minutes, long_live_id ):
  ## (1) filter out long_live_id, in the oppsite,  (2) catch str!!
  processes0 = os.popen("ps -ef |grep -ve " + long_live_id +" | grep " + str+" "+ "| sed 's/  */ /g'|cut -d' ' -f2").readlines()
  pid_list = [x.strip() for x in processes0 ]
  print "pid_list:"
  print pid_list
  for pp in pid_list:
   try:
     proc = psutil.Process( int(pp) )
     if time.time() - proc.create_time() > 60 * int(dead_age_in_minutes):
       proc.kill()
       print "proccess[pid="+pp+"] killed!"
   except psutil.NoSuchProcess:
     print('task list process {} no longer exists'.format(pp))

if __name__ == "__main__":

    if len(sys.argv) < 4:
        _error("usage: "+sys.argv[0] +"<kill_target_string> <dead_minutes> <check_cycle_minutes> <long_live_id>")
        print "e.g.: " +sys.argv[0]+" wget 15 3 mt_down_kw+prof__list" # check for every 3 minutes, kill all proc>=15 minutes, never kill proc with mt_down_kw... ID!"

    starttime=time.time()
    kill_str = sys.argv[1]
    kill_weight = sys.argv[2]
    check_interval = sys.argv[3]
    long_live_id = sys.argv[4]
    while True:
      kill_by_psname_lifespan( kill_str, kill_weight, long_live_id )

      time.sleep( int(check_interval) * 60 )  # only check to kill every check_interval minutes
      #time.sleep( int(check_interval) * 60 - ((time.time() - starttime )))
