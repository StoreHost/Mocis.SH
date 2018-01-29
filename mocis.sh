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
# Installation von "dialog
version=$(sed -n '1{p;q}' /usr/share/storehost/Installer/dependencies/Config/version.txt)
if [ -d "/etc/apt" ]; then
	pmgr=apt
fi
if [ -d "/etc/yum" ]; then
	pmgr=yum
fi

if [ $pmgr == "apt" ]; then
	 apt-get upgrade -y &>/dev/null
	apt-get install dialog git bc -y &>/dev/null
fi
if [ $pmgr == "yum" ]; then
	dialog --title "[ M.O.C.I.S ]" --msgbox 'This script is only supported by Debian Systems for now.' 0 0
		clear
		exit
fi
if
[ $UID -ne 0 ]; then
		dialog --ascii-lines \
		--title "Store-Host Installer" --msgbox 'This script must be started as "root"!!"' 0 0
		clear
		exit
fi
############################################################
# Erklaerung Datenverlust
#
dialog --title "Agreement" \
--backtitle "Mocis.sh" \
--ascii-lines \
--yesno "This script is still in development and therefore not yet stable. \n Please only use on your OWN risk!!! \n We can not be held responsible for any damage or damage that may be caused \n Please check our website www.mocis.sh for more info and updates.\n\n Would you like to proceed?  " 0 0
response=$?
        case $response in
        0) echo "starting";;
        1) clear exit;;
        255) clear echo "[ESC] key pressed.";;
		esac
			if [ $response = 0 ]
			then
				if [ $version = 0.0.0.1 ]; then
 					bash /usr/share/storehost/Installer/Menu/welcome.sh
				else
					echo "Removing old files..."
					rm -R /usr/share/storehost/
					echo "Installing some nessesary binarys..."
					apt-get install aptitude xmlstarlet git -y &>/dev/null
					echo "Cloning newest version...."
					git clone https://github.com/StoreHost/Mocis.SH.git /usr/share/storehost/
					sleep 5
					echo "porting to the main Menu..."
					bash /usr/share/storehost/Installer/dependencies/Bash/reporter.sh &>/dev/null
					sleep 3
					bash /usr/share/storehost/Installer/Menu/welcome.sh
				fi
			fi
