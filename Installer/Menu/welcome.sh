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
installer=0
interfaces=0
security=0
backup=0
about=0
INPUT=save.$$
trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM
dialog --clear --backtitle "Mocis.sh" \
--ascii-lines \
--title "[ M A I N - M E N U ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 0 0 8 \
Benchmarking "Ensky Media Script" \
Installations "PHP, Mysql..." \
Interfaces "IMSCP, Froxlor, EasyWI" \
Security "Not all but atleast some" \
Backup "FTP Backupscript to Remote Server" \
About "About us" \
Exit "Exit to the shell" 2>"${INPUT}"
menuitem=$(<"${INPUT}")
[ -f $INPUT ] && rm $INPUT
case $menuitem in
        Benchmarking) benchmark=1;;
        Installations) installer=1;;
        Interfaces) interfaces=1;;
        Security) security=1;;
        Backup) backup=1;;
        About) about=1;;
        Exit) echo "Bye"; clear;
esac
if [ $benchmark = 1 ] ; then
bash /usr/share/storehost/Installer/dependencies/Bash/benchmark.sh
fi
if [ $security = 1 ] ; then
	bash /usr/share/storehost/Installer/Menu/security.sh
fi
if [ $installer = 1 ] ; then
	bash /usr/share/storehost/Installer/Menu/installation.sh
fi
if [ $interfaces = 1 ] ; then
	bash /usr/share/storehost/Installer/Menu/interfaces.sh
fi
if [ $about = 1 ] ; then
  dialog --clear --backtitle "Mocis.sh" \
  --title "[ About Mocis.sh ]" \
  --msgbox "What is Mocis.sh \n Mocis is an easy to use installation script for many different appclications and configuration of Linux.\n\n\n\n
  active Tester's:\n\n iTweek (ts3-server.ch)\n" 0 0
  bash /usr/share/storehost/Installer/Menu/welcome.sh
fi
if [ $backup = 1 ] ; then
  clear
  echo "This is not integrated by the stand now. We're working hard on it."
  sleep 3
  echo "Porting back to the menu"
  sleep 2
  bash /usr/share/storehost/Installer/Menu/welcome.sh
fi
