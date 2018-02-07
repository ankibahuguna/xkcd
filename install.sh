#!/bin/bash

type node >/dev/null 2>&1 || { echo >&2 "This program requires node. Exiting"; exit 1; }

nodePath=$(which node)
CWD=$(pwd)
CronFile="script.sh"

npm install

if [ -f $CronFile ] 
then 
    echo "Shell script already exists"
    exit 0
fi

# if [ $# -eq 0 ]
#   then
#     if []
#     echo "Usage : \n sh install.sh [valid cron pattern in quotes] \n Example : sh install.sh \"*/1 * * * *"\"
#     exit 1
# fi

echo "#!/bin/bash
PID=\$(pgrep gnome-session)
export DBUS_SESSION_BUS_ADDRESS=\$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/\$PID/environ|cut -d= -f2-);$nodePath $CWD/index.js">>$CronFile

if [ -f $CronFile ] 
then
    chmod u+x $CronFile  
else
    echo "Could not generate shell script"
    exit 1
fi

shellScript=$CWD/$CronFile

cronPattern=${1:-"*/30 * * * *"}
echo "Cron pattern $cronPattern"

(crontab -l 2>/dev/null; echo "$cronPattern   $shellScript") | crontab -

if [ $? -eq 0 ]; then
    echo OK
else
    rm $shellScript
    echo fail
    exit 1
fi