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
lamp_php7=0
docker=0
goback=0
hostname=0
INPUT=sh-installer.sh.$$
trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM
dialog --clear --backtitle "[ M.O.C.I.S ]" \
--title "[ Installation menu ]" \
--ascii-lines \
--menu "You can Install Apache, PHP, MySQL, and much more." 0 0 8 \
Lamp-PHP7 "PHP, MySQL, Apache" \
Docker "Docker engine (experimental)" \
Back "Back to the Main Menu" \
Exit "Exit to the shell" 2>"${INPUT}"
menuitem=$(<"${INPUT}")
[ -f $INPUT ] && rm $INPUT
case $menuitem in
        Lamp-PHP7) lamp_php7=1;;
        Docker) docker=1;;
		    Back) goback=1;;
        Exit) echo "Bye"; break;;
esac
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
					chmod -+x /usr/share/mocis/repo/apt/9/LAMP-PHP7.deb9.pl
					perl /usr/share/mocis/repo/apt/9/LAMP-PHP7.deb9.pl
				else
					chmod -+x /usr/share/mocis/repo/apt/8/LAMP-PHP7.deb.pl
					perl /usr/share/mocis/repo/apt/8/LAMP-PHP7.deb.pl
				fi
			fi
fi
if [ $goback = 1 ] ; then
bash /usr/share/mocis/overlay/welcome.sh
fi
if [ $docker = 1 ] ; then
  apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common > /dev/null
  curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
  apt-get update >/dev/null
  apt-get install docker-ce > /dev/null
fi
