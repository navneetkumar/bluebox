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

echo "Hello, Bluebox!" 
echo "Meeting id:" "$mid"
echo "Passcode:" "$pcode"

linphonecsh init -C

sleep 0.5s

linphonecsh generic "call sip:90009000@sip.bjn.vc;transport=TLS"
