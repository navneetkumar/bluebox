#!/bin/bash

echo "Terminating the call"

# linphonecsh generic "terminate all"
# linphonecsh exit

ps -ef | grep "linphone" | awk '{print $2}' | xargs kill -9

sleep 2s

echo "Terminated"
