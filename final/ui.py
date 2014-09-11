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
        self.window.set_decorated(False)
        self.window.set_default_size(500, 100)
        color = gtk.gdk.color_parse('#3BB9FF')
      	self.window.modify_bg(gtk.STATE_NORMAL, color)
	self.window.set_opacity(0.4)
	self.window.move(250,400)
	self.window.set_border_width(50)
        self.window.set_title("BlueJeans")
	default_msg = "Waiting for connection..."
        self.label = gtk.Label(default_msg)
	self.label.set_use_markup(True)
        self.label.set_markup("<span color='white' size='30000'><b>%s</b></span>" % 
default_msg)
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
    ui.main()
    
if __name__=='__main__':
    showUI()
