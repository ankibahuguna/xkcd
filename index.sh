#!/bin/bash
PID=$(pgrep gnome-session)
$pid

for p in $(pgrep gnome-session) 
do
	pid=$p
done

export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$pid/environ|cut -d= -f2-);/home/ankitbahuguna/.nvm/versions/node/v9.2.0/bin/node /home/ankitbahuguna/projects/xkcd/index.js