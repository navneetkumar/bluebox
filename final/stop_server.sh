#!/bin/bash
ps -ef | grep "python2" | awk '{print $2}' | xargs kill
ps -ef | grep "linphone" | awk '{print $2}' | xargs kill
