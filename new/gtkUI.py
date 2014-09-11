#!/usr/bin/env python

# example helloworld.py

import pygtk
pygtk.require('2.0')
import gtk
import time


var=0

class HelloWorld:

    # This is a callback function. The data arguments are ignored
    # in this example. More on callbacks below.
    def hello(self, widget, data=None):
        global var
        var=var+1
        print "Hello World :",var

    def delete_event(self, widget, event, data=None):
        print "Closing Window"
        return False

    def setupWindow(self):
        self.window = gtk.Window(gtk.WINDOW_TOPLEVEL)
        self.window.connect("delete_event", self.delete_event)
        self.window.connect("destroy", self.destroy)
        self.window.set_border_width(50)
        self.window.set_title("BlueJeans")
        self.window.maximize()

    def addButton(self):
        self.button = gtk.Button("Enter BlueJeans")
        self.button.connect("clicked", self.continued, None)
        self.window.add(self.button)
        self.button.show()

    def addLabel(self):
        self.label=gtk.Label()
        self.label.set_text("Welcome to BlueJeans");
        self.window.add(self.label)
        self.label.show()
        self.window.show()

    def destroy(self, widget, data=None):
        print "destroy signal occurred"
        gtk.main_quit()

    def __init__(self):        
        self.setupWindow()
        self.addButton()
        self.window.show()

    def continued(self, widget, data=None):
        self.window.remove(self.button)
        self.addLabel()


    def main(self):
        # All PyGTK applications must have a gtk.main(). Control ends here
        # and waits for an event to occur (like a key press or mouse event).
        gtk.main()

# If the program is run directly or passed as an argument to the python
# interpreter then create a HelloWorld instance and show it
def uiStart():
    hello = HelloWorld()
    hello.main()

if __name__=='__main__':
    uiStart()
