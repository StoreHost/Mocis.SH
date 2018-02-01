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
############################################################
# Welcome Menu
#
goback=0
compose=0
INPUT=save.$$
trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM
dialog --clear --backtitle "[ M.O.C.I.S ]" \
--ascii-lines \
--title "[ Docker Templates ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 0 0 8 \
Compose "Docker Compose" \
Back "Go back to the Menu" \
Exit "Exit to the shell" 2>"${INPUT}"
menuitem=$(<"${INPUT}")
[ -f $INPUT ] && rm $INPUT
case $menuitem in
        Compose) compose=1;;
        Back) goback=1;;
        Exit) echo "Bye"; clear;
esac
if [ goback = 1 ] ; then
  bash /usr/share/mocis/overlay/welcome.sh
fi
if [ compose = 1] ; then
  curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  composeversion=$(docker-compose --version)
  dialog --title "Check Compose version" --backtitle "[ M.O.C.I.S ]" --ascii-lines --msgbox "Actually installed \n\n$composeversion" 0 0
fi
