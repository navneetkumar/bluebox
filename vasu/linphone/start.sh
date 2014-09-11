#!/bin/bash

while getopts ":m:p:" opt; do
   case $opt in
	m) mid="$OPTARG"
   	;;
        p) pcode="$OPTARG"
	;;
	\?) echo "Invalid option -$OPTARG" >&2
	;;
   esac
done

echo "Welcome to Bluebox!" 
echo "Meeting id:" "$mid"

linphonecsh init -C

sleep 0.5s

str="call sip:"$mid"@sip.bjn.vc;transport=TLS"
echo $str

linphonecsh generic "call sip:"$mid"@sip.bjn.vc;transport=TLS"
