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
goback=0
docker=0
compose=0
doc_portainer=0
INPUT=save.$$
trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM
dialog --clear --backtitle "[ M.O.C.I.S ]" \
--no-lines \
--title "[ Docker Templates ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 0 0 8 \
Docker "Docker Engine" \
Compose "Docker Compose" \
Portainer "Webinterface for Docker" \
Back "Go back to the Menu" \
Exit "Exit to the shell" 2>"${INPUT}"
menuitem=$(<"${INPUT}")
[ -f $INPUT ] && rm $INPUT
case $menuitem in
        Docker) docker=1;;
        Compose) compose=1;;
        Portainer) doc_portainer=1;;
        Back) goback=1;;
        Exit) echo "Bye"; break;;
esac

if [ $goback = 1 ] ; then
  bash /usr/share/mocis/overlay/welcome.sh
fi
if [ $compose = 1 ] ; then
  curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  composeversion=$(docker-compose --version)
  dialog --title "Check Compose version" --backtitle "[ M.O.C.I.S ]" --no-lines --msgbox "Actually installed \n\n$composeversion" 0 0
  bash /usr/share/mocis/overlay/welcome.sh
fi
if [ $doc_portainer = 1 ] ; then
  dialog --title "Check Compose version" --backtitle "[ M.O.C.I.S ]" --no-lines --yesno "You have to install Docker first!!!\n\nDid you do that?" 0 0
  response=$?
          case $response in
          0) echo "starting";;
          1) clear exit;;
          255) clear echo "[ESC] key pressed.";;
  		esac
  			if [ $response = 0 ]
  			then
          docker volume create portainer_data
          docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
          dialog --title "Check Compose version" --backtitle "[ M.O.C.I.S ]" --no-lines --msgbox "Portainer should be installed\n\nYou can check your webbrowser:\n\nYourIPAdress:9000" 0 0
          bash /usr/share/mocis/overlay/welcome.sh
        else
          bash /usr/share/mocis/overlay/welcome.sh
        fi
fi
if [ $docker = 1 ] ; then
  apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common > /dev/null
  curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
  apt-get update >/dev/null
  apt-get install docker-ce > /dev/null
  bash /usr/share/mocis/overlay/welcome.sh
fi
