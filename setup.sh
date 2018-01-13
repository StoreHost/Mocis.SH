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
# Installation von "dialog"
#
if [ -d "/etc/apt" ]; then
	pmgr=apt
fi
if [ -d "/etc/yum" ]; then
	pmgr=yum
fi

if [ $pmgr == "apt" ]; then
	apt-get install dialog &>/dev/null
fi
if [ $pmgr == "yum" ]; then
	dialog --title "Store-Host Installer" --msgbox 'This script is only supported by Debian Systems for now.' 0 0
		clear
		exit
fi
clear
############################################################
# Erklaerung Datenverlust
#
dialog --title "Agreement" \
--backtitle "Store-Host Installer Script" \
--yesno "This script is still in development and therefore not yet stable. \n Please only use if you know what you do!!! \n Please send bugs to script@myvps.care \nWe can not be held responsible for any damage or damage that may be caused \n\n Would you like to proceed?  " 0 0
response=$?
        case $response in
        0) echo "starting";;
        1) exit;;
        255) echo "[ESC] key pressed.";;
		esac
			if [ $response = 0 ] 
			then
				echo "Creating Directorys"
				apt-get install aptitude -y &>/dev/null
				mkdir /tmp/storehost
				mkdir /tmp/storehost/cpan/
				do_perlinstaller=1
			fi

##########################################
# Variabeln
do_menu=0
url="bench.myvps.care/github"
if
	[ $UID -ne 0 ]; then
		dialog --title "Store-Host Installer" --msgbox 'This script must be started as "root"!!"' 0 0
		clear
		exit
fi
response=$?
case $response in
   0) do_menu=1;;
   1) exit;;
   255) echo "aborted.";;
esac
if [ $do_menu = 1 ] ; then
echo "We need some nessesary files please stand by"
wget -O - $url/Installer/Menu/welcome.sh | bash
#echo "everything is in place and we're starting now...'"
fi