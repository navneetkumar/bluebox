#!/usr/bin/env python
import pygtk
pygtk.require('2.0')
import gtk
import time
import gio

class UI:
    
    def __init__(self):
        self.setupWindow()
        
    def setupWindow(self):
        self.window = gtk.Window(gtk.WINDOW_TOPLEVEL)
        self.window.connect("destroy", self.destroy)
        self.window.set_border_width(50)
        self.window.set_title("BlueJeans")
        self.label = gtk.Label('Hello World')
        self.window.add(self.label)
	self.label.show()
        self.monitor = gio.File("api.log").monitor()
	self.monitor.connect('changed', self.changed)
        		
    def destroy(self, widget, data=None):
        print "destroy signal occurred"
        gtk.main_quit()
        
    def main(self):
        self.window.show()
        gtk.main()
    
    def show(self,message):
        self.label.set_label(message)
 	
    def changed(self,monitor, file1, file2, evt_type):
	contents, length, etag = file1.load_contents()
	print contents
	self.show(contents)   
		
def showUI():
    ui = UI()
    ui.show("hi")
    ui.main()
    
if __name__=='__main__':
    showUI()
