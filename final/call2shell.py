#!/usr/bin/python

import subprocess
from subprocess import Popen, PIPE
import sys
shellScript = sys.argv[1]
print "Running shell script: " + shellScript 

process=subprocess.Popen('./HelloWorld.sh', shell=True, stdout=subprocess.PIPE)
subprocess.call('./HelloWorld.sh',shell=True)
process.wait()
print process.returncode

