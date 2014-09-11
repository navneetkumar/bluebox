#!/usr/bin/env python
import Queue
import threading
import urllib2
import pyjsonrpc
import gtkUI
import server
import threading
from server import serverStart
from gtkUI import uiStart

if __name__=='__main__':
    serverThread = threading.Thread(target=serverStart, args = ())
    serverThread.daemon = True
    gtkThread =  threading.Thread(target=uiStart, args = ())
    gtkThread.daemon = True
    gtkThread.start()
    serverThread.start()

    serverThread.join()    

