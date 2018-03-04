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
echo "Installing some nessesary tools"
if [ -d "/etc/apt" ]; then
	pmgr=apt
fi
if [ -d "/etc/yum" ]; then
	pmgr=yum
fi

if [ $pmgr == "apt" ]; then
	apt-get upgrade -y &>/dev/null
	apt-get install dialog curl git bc -y &>/dev/null
	rm /tmp/version.txt
	wget https://raw.githubusercontent.com/StoreHost/Mocis.SH/master/sys/version/version.txt -P /tmp/ &>/dev/null
fi
if [ $pmgr == "yum" ]; then
	dialog --title "[ M.O.C.I.S ]" --msgbox 'This script is only supported by Debian Systems for now.' 0 0
		clear
		exit
fi
if
[ $UID -ne 0 ]; then
		dialog --no-lines \
		--title "[ M.O.C.I.S ]" --msgbox 'This script must be started as "root"!!"' 0 0
		clear
		exit
fi
############################################################
# Erklaerung Datenverlust
#
LOGDIR="/root/mocis_log"
DIRECTORY="/usr/share/mocis"
version=$(sed -n '1{p;q}' /usr/share/mocis/sys/version/version.txt)
currentversion=$(sed -n '1{p;q}' /tmp/version.txt)
dialog --title "Agreement" \
--backtitle "Mocis.sh" \
--no-lines \
--yesno "This script is still in development and therefore not yet stable. \n Please only use on your OWN risk!!! \n We can not be held responsible for any damage or damage that may be caused \n Please check our website www.mocis.sh for more info and updates.\n\n Would you like to proceed?  " 0 0
response=$?
        case $response in
        0) echo "starting";;
        1) clear exit;;
        255) clear echo "[ESC] key pressed.";;
		esac
			if [ $response = 0 ]
			then
				if [[ -d $LOGDIR ]]; then
					echo ""
				else
					mkdir $LOGDIR
				fi
				if [ "$version" = "$currentversion" ]; then
 					bash /usr/share/mocis/overlay/welcome

				else

					if [ -d $DIRECTORY ]; then
				  echo "Removing old files..."
					rm -R /usr/share/mocis/
					fi
					echo "Installing some nessesary binarys..."
					apt-get install aptitude xmlstarlet git -y &>/dev/null
					echo "Cloning newest version...."
					git clone https://github.com/StoreHost/Mocis.SH.git /usr/share/mocis/
					echo "porting to the main Menu..."
					bash /usr/share/mocis/overlay/welcome
					rm /tmp/version.txt
				fi
			fi
