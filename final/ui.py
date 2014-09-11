#!/usr/bin/env python

# example helloworld.py

import pygtk
pygtk.require('2.0')
import gtk
import time

meetingId=909090
meetingPassCode=404

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
        #self.window.set_border_width(50)
        self.window.set_title("BlueJeans")
        self.window.set_resizable(True)
        self.window.fullscreen()

    def addButton(self):
        self.button = gtk.Button("Enter BlueJeans")
        self.button.connect("clicked", self.continued, None)
        self.window.add(self.button)
        self.button.show()

    def addLabel(self):
        self.box1 = gtk.HBox(False, 0)
        self.window.add(self.box1)
        
        self.meetingIdLabel=gtk.Label()
        global meetingId
        meetingIdLabel="Meeting Id :"+ str(meetingId)
        self.meetingIdLabel.set_text(meetingIdLabel);
        self.box1.pack_start(self.meetingIdLabel, True, True, 0)
        self.meetingIdLabel.show()
        
        self.meetingPassCodeLabel=gtk.Label()
        global meetingPassCode
        meetingPasscodeLabel="Meeting Passcode :"+ str(meetingPassCode)
        self.meetingPassCodeLabel.set_text(meetingPasscodeLabel);
        self.box1.pack_start(self.meetingPassCodeLabel, True, True, 0)
        self.meetingPassCodeLabel.show()
        self.box1.show()
        self.window.set_resizable(True)
        self.window.show()
        self.window.fullscreen()

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
