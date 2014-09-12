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

ps -ef | grep "linphone" | awk '{print $2}' | xargs kill -9

sleep 2s

echo "Welcome to Bluebox!" 
echo "Meeting id:" "$mid"

echo "" > linphone.log

linphonecsh init -C -l linphone.log -d 6

sleep 2s

linphonecsh generic "soundcard list"
linphonecsh generic "soundcard capture 3"
linphonecsh generic "soundcard playback 2"
linphonecsh generic "soundcard ring 2"

echo "Capture Devices:"
linphonecsh generic "soundcard show"

sleep 1s

str="call sip:"$mid"@sip.bjn.vc;transport=TLS"
echo $str

linphonecsh generic "call sip:"$mid"@sip.bjn.vc;transport=TLS"
