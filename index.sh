#!/bin/bash
PID=$(pgrep gnome-session)
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-);/home/ankit/.nvm/versions/node/v8.9.1/bin/node /home/ankit/projects/xkcd/index.js