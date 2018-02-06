Set your ubuntu desktop's wallpaper with xkcd random comic.

I made it just for fun. Feel free to change or modify it according to your needs.

Dependencies : 
Node JS (version 8)
npm (version 5)


Usage : 
sh install.sh "cron pattern"

eg : To change wallpaper every minute run : sh install.sh "*/1 * * * *"




Note :
This script creates a 'comics' directory in your home directory to download the xkcd comics.

The cron frequency is set when you run sh install.sh. To change you will have to edit the crontab manually by running "crontab -e"





