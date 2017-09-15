#!/usr/bin/env python
import dbus
import sys
import os

try:
    # Try and set skype window to normal
    remote_bus = dbus.SessionBus()
    out_connection = remote_bus.get_object('com.Skype.API', '/com/Skype')
    out_connection.Invoke('NAME mySkypeController')
    out_connection.Invoke('PROTOCOL 5')
    #out_connection.Invoke('SET WINDOWSTATE MAXIMIZED')
    out_connection.Invoke('SET WINDOWSTATE NORMAL')
    out_connection.Invoke('FOCUS')
except:
    os.system("skype")
    sys.exit()



