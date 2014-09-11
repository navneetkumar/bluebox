#!/usr/bin/env python
# coding: utf-8

import pyjsonrpc

serverAddress="0.0.0.0"
serverPort=9090

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
def serverStart():
    print("Starting HTTP server ...")
    try:
        http_server = pyjsonrpc.ThreadingHttpServer(server_address = (serverAddress, serverPort),RequestHandlerClass = RequestHandler)
    except Exception:
        print("Exception")
    print("URL: http://"),serverAddress,(":"),serverPort
    try:
        http_server.serve_forever()
    except KeyboardInterrupt:
        http_server.shutdown()

if __name__=='__main__':
	serverStart()

