#!/bin/bash

echo "Terminating the call"

linphonecsh generic "terminate all"
linphonecsh exit

echo "Terminated"
