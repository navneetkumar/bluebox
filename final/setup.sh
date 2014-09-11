#!/bin/bash

echo "Welcome to Bluebox!"
echo "Setting up Bluebox. Please wait...."

linphonecsh init -C

sleep 0.5s

linphonecsh soundcard capture 3
linphonecsh soundcard playback 2
linphonecsh soundcard ring 2


echo "Set up completed. Bluebox is ready!!"

