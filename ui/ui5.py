#!/usr/bin/env python
import pyjsonrpc
import pygtk

pygtk.require('2.0')
import gtk

class HelloWorld:
 
    def hello(self, widget, data=None):
        print "Hello World"

    def delete_event(self, widget, event, data=None):
        print "delete event occurred"
        return False

    def destroy(self, widget, data=None):
        print "destroy signal occurred"
        gtk.main_quit()

    def __init__(self):
        self.window = gtk.Window(gtk.WINDOW_TOPLEVEL)
        self.window.connect("delete_event", self.delete_event)
        self.window.connect("destroy", self.destroy)
        self.window.set_border_width(10)
        self.button = gtk.Button("Hello World")
        self.button.connect("clicked", self.hello, None)
        self.window.add(self.button)
        self.button.show()
        self.window.show()

    def main(self):
	print("creating gtk")
        gtk.main()

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

# If the program is run directly or passed as an argument to the python
# interpreter then create a HelloWorld instance and show it
if __name__ == "__main__":
    print("Starting HTTP server ...")
    print("URL: http://localhost:8080")
    # http_server.serve_forever()
    hello = HelloWorld()
    hello.main()
