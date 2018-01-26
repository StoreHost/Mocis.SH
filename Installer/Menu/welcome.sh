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
# Welcome Menu
#
benchmark=0
install=0
Interfaces=0
security=0
backup=0
INPUT=save.$$
trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM
dialog --clear --backtitle "Store-Host" \
--title "[ M A I N - M E N U ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 0 0 8 \
Benchmarking "Ensky Media Script" \
Installations "PHP, Mysql..." \
Interfaces "IMSCP, Froxlor, EasyWI" \
SSL "Let's Encrypt whit certbot" \
Tools "" \
Backup "FTP Backupscript to Remote Server" \
Exit "Exit to the shell" 2>"${INPUT}"
menuitem=$(<"${INPUT}")
[ -f $INPUT ] && rm $INPUT
case $menuitem in
        Benchmarking) benchmark=1;;
        Installations) install=1;;
        Interfaces) interfaces=1;;
        Security) security=1;;
        Backup) backup=1;;
        Exit) echo "Bye"; break;;
esac
if [ $benchmark = 1 ] ; then
bash /usr/share/storehost/Installer/dependencies/Bash/benchmark.sh
fi
if [ $security = 1 ] ; then
	bash /usr/share/storehost/Installer/Menu/security.sh
fi
if [ $install = 1 ] ; then
	bash /usr/share/storehost/Installer/Menu/installation.sh
fi
if [ $interfaces = 1 ] ; then
	bash /usr/share/storehost/Installer/Menu/interfaces.sh
fi
if [ $backup = 1 ] ; then
  clear
  echo "This is not integrated by the stand now. We're working hard on it."
  sleep 3
  echo "Porting back to the menu"
  sleep 2
  bash /usr/share/storehost/Installer/Menu/welcome.sh
fi
