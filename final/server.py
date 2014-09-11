#!/usr/bin/env python2.7
# coding: utf-8

import pyjsonrpc
import subprocess
from subprocess import Popen, PIPE
import sys


def run_command(command=[]):
    process=subprocess.Popen(command, shell=True, stdout=subprocess.PIPE)
    process.wait()
    out, err = process.communicate() 
    return [process.returncode,out]

def call(meetingId):
    print("starting to call",meetingId)
    return run_command(["./start.sh -m " + meetingId])

def stop():
    print("stopping the call")
    return run_command(["./stop.sh"])

def echo(message):
    print("Server says ",message)
    return [0,message]

class RequestHandler(pyjsonrpc.HttpRequestHandler):

    # Register public JSON-RPC methods
    methods = {
        "call": call,
	"stop": stop,
        "echo": echo
    }

# Threading HTTP-Server
http_server = pyjsonrpc.ThreadingHttpServer(
    server_address = ('0.0.0.0', 8080),
    RequestHandlerClass = RequestHandler
)

print("Starting BlueBox HTTP server ...")

print("URL: http://0.0.0.0:8080")

http_server.serve_forever()
