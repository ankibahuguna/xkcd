Set your ubuntu desktop's wallpaper with xkcd random comic

To use with cron :
crontab -e
(Runs every minute)
* * * * *  absolute_path_to_project_directory/xkcd/index.sh

save and exit.


Note :
This script creates a 'comics' directory in your home directory to download the xkcd comics


