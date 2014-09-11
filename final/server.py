#!/usr/bin/env python
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

def call(meetingId, passCode):
    print("starting to call",meetingId,passCode)
    return run_command(["ls","-l"])

def echo(message):
    print("Server says ",message)
    return [0,message]

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
