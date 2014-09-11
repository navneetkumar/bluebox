#!/usr/bin/env python
# coding: utf-8

import pyjsonrpc

def add(a, b):
    """Test function"""
    return a + b

def handshake(auth):
    print("sleeping ")
    print (auth)
    
class RequestHandler(pyjsonrpc.HttpRequestHandler):

    # Register public JSON-RPC methods
    methods = {
        "add": add,
        "handshake": handshake
    }

# Threading HTTP-Server
http_server = pyjsonrpc.ThreadingHttpServer(
    server_address = ('0.0.0.0', 8080),
    RequestHandlerClass = RequestHandler
)

print("Starting HTTP server ...")

print("URL: http://localhost:8080")

http_server.serve_forever()
