echo "	

Although this is an old question, I came across this when looking for an answer to the same question. The OS and interface limits are already addressed in an earlier answer, so here is a way to set up application specific limits. Use an application called trickle. So do sudo apt-get install trickle. You can limit upload/download for a specific app by running
ugh this is an old question, I came across this when looking for an answer to the same question. The OS and interface limits are already addressed in an earlier answer, so here is a way to set up application specific limits. Use an application called trickle. So do sudo apt-get install trickle. You can limit upload/download for a specific app by running

trickle -u (upload limit in KB/s) -d (download limit in KB/s) application

This will launch the application with the specified limits. You can also specify "smoothing" time, so that trickle samples over the desired time period in case your application has bursts of bandwidth consumption and you'd like the bursts to be allowed so long as the average is within your specifications.
"
 sudo apt-get install trickle

trickle -u 555   -d 800 firefox   



