#!/bin/bash
############################################################
# Developed by Store-Host
# Version 0.0.5.0
# Web: https://www.store-host.com
#       Store-Host is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
############################################################
# Installer Menu
#
url=http://bench.myvps.care/github/%0d/Installer
htop=0
lamp_php7=0
goback=0
INPUT=sh-installer.sh.$$
trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM
dialog --clear --backtitle "Store-Host" \
--title "[ M A I N - M E N U ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 0 0 8 \
Htop "Taskmanager" \
Lamp-PHP7 "PHP, Mysql, Apache" \
Back "Back to the Mainmenu" \
Exit "Exit to the shell" 2>"${INPUT}"
menuitem=$(<"${INPUT}")
# make decsion
case $menuitem in
        htop) htop=1;;
        Lamp-PHP7) lamp_php7=1;;
		Back) goback=1;;
        Exit) echo "Bye"; break;;
esac
if [ $htop = 1 ] ; then

			echo "Installing Htop.../n"
			aptitude install htop -y  &>/dev/null
			echo "htop is installed successfuly"
fi
if [ $lamp_php7 = 1 ] ; then
			dialog --yesno "This can damage your system !! Do you want to continue?" 0 0
		response=$?
		case $response in
		0) echo "Starte";;
		1) echo exit;;
		255) echo "[ESC] key pressed.";;
		esac
			if [ $response = 0 ] 
			then
				if cat /etc/issue.net | grep 9; then
					chmod -+x /usr/share/storehost/Installer/Distribution/Debian/9/LAMP-PHP7.deb9.pl
					perl /usr/share/storehost/Installer/Distribution/Debian/9/LAMP-PHP7.deb9.pl
				else
					chmod -+x /usr/share/storehost/Installer/Distribution/Debian/8/LAMP-PHP7.deb.pl
					perl /usr/share/storehost/Installer/Distribution/Debian/8/LAMP-PHP7.deb.pl
				fi
			fi
fi
if [ $goback = 1 ] ; then
bash /usr/share/storehost/Installer/Menu/welcome.sh | bash
fi