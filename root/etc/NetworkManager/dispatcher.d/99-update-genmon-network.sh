#!/bin/sh
 
su spike -c "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus \
  /usr/bin/xfce4-panel --plugin-event=genmon-10:refresh:bool:true --display=:0"
