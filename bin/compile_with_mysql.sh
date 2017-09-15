CC=/usr/bin/gcc
#CC=powerpc-linux-gcc
CP=/usr/bin/cp
CFLAGS = -g -Wall $(shell mysql_config --cflags) $(shell mysql_config --libs)

