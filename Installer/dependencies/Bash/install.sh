#!/bin/bash
############################################################
# Developed by Store-Host 
# Version 0.0.5.0
# Web: https://www.store-host.com
#	Store-Host is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
############################################################
# Installer menu
#
INPUT=sh-installer_menu.sh.$$
# trap and delete temp files
trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM
### display main menu ###
dialog --clear  --backtitle "Store-Host" \
--title "[ M A I N - M E N U ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 0 0 8 \
HTOP "Taskmanager" \
Apache "Webserver." \
LAMP-PHP5 "Apache - PHP 5 - MariaDB" \
LAMP-PHP7 "Apache - PHP 7 - MariaDB" \
PHP5 "Only PHP 5.6" \
Exit "Exit to the shell" 2>"${INPUT}"
menuitem=$(<"${INPUT}")
# make decsion
case $menuitem in
        HTOP) do_htop=1;;
        Apache2.4) do_apache=1;;
		LAMP-PHP5) do_lamp5=1;;
		LAMP-PHP7) do_lamp7=1;;
		PHP5)	do_php5=1;;
		Exit) echo "Bye"; break;;
esac
# if temp files found, delete em
#[ -f $OUTPUT ] && rm $OUTPUT
[ -f $INPUT ] && rm $INPUT
clear