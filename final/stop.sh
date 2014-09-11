#!/bin/bash

echo "Terminating the call"

linphonecsh generic "terminate all"
linphonecsh exit

ps -ef | grep "linphone" | awk '{print $2}' | xargs kill

echo "Terminated"
