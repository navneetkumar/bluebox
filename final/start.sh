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

echo "" > linphone.log

linphonecsh init -C -l linphone.log -d 6

sleep 2s

str="call sip:"$mid"@sip.bjn.vc;transport=TLS"
echo $str

linphonecsh generic "call sip:"$mid"@sip.bjn.vc;transport=TLS"
