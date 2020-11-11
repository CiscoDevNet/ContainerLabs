#!/usr/bin/env bash

#Do not add any echo statements or other commands that might output any data

########################################################################
#### Using NC: This will not work in docker 1.8.2 onwards          #####
########################################################################
#echo -e "GET $1 HTTP/1.0\r\n" | sudo nc -U /var/run/docker.sock

# This can be used only in Debian. Will work for all versions of Docker
#echo -e "GET $1 HTTP/1.0\r\n" | sudo nc -U -q 5 /var/run/docker.sock

########################################################################
##### Using CURL: Needs CURL v7.40+                            #########
##### This will not work with earlier versions of CURL         #########
########################################################################
curl -s -S -i --unix-socket /var/run/docker.sock  http://localhost$1

