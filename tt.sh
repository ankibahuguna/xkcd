#!/bin/bash
PID=$(pgrep gnome-session)
$pid

for p in $(pgrep gnome-session) 
do
	pid=$p
done
echo $pid
