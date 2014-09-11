#!/usr/bin/env python
# coding: utf-8

import pyjsonrpc
import subprocess
from subprocess import Popen, PIPE
import sys

def call(meetingId, passCode):
    print("starting to call",meetingId,passCode)
    process=subprocess.Popen(["linphonec","-C"], shell=True, stdout=subprocess.PIPE)
    #process.wait()
    for line in process.stdout.readlines():
      print("in line")
      print(line)
    process.returncode
    return process.returncode

def echo(message):
    print("Server says ",message)
    return message

class RequestHandler(pyjsonrpc.HttpRequestHandler):

    # Register public JSON-RPC methods
    methods = {
        "call": call,
        "echo": echo
    }

# Threading HTTP-Server
http_server = pyjsonrpc.ThreadingHttpServer(
    server_address = ('0.0.0.0', 8090),
    RequestHandlerClass = RequestHandler
)

print("Starting BlueBox HTTP server ...")

print("URL: http://0.0.0.0:8080")

http_server.serve_forever()
