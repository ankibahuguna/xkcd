#!/bin/bash
nodePath=$(which node)
CWD=$(pwd)
CronFile="script.sh"

npm install

if [ -f $CronFile ] 
then 
    echo "Shell script already exists"
    exit 0
fi

if [ $# -eq 0 ]
  then
    echo "Usage : \n sh install.sh [valid cron pattern in quotes] \n Example : sh install.sh \"*/1 * * * *"\"
    exit 1
fi

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

echo "Cron pattern $1"

(crontab -l 2>/dev/null; echo "$1   $shellScript") | crontab -

if [ $? -eq 0 ]; then
    echo OK
else
    rm $shellScript
    echo fail
    exit 1
fi