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
url=http://bench.myvps.care/github/%0d/Installer
benchmark=0
install=0
Interfaces=0
ssl=0
INPUT=sh-installer.sh.$$
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
SSL "Secure your Website free whit SSL" \
Backup "FTP Backupscript to Remote Server" \
Exit "Exit to the shell" 2>"${INPUT}"
menuitem=$(<"${INPUT}")
# make decsion
case $menuitem in
        Benchmarking) benchmark=1;;
        Installations) install=1;;
                Interfaces) interfaces=1;;
                Backup) echo "Will be comming in the near future, stay tuned.";;
                SSL) ssl=0;;
        Exit) echo "Bye"; break;;
esac
if [ $benchmark = 1 ] ; then
wget $url/dependencies/Bash/benchmark.sh -O - -o /dev/null|bash
exit
fi
if [ $install = 1 ] ; then
wget $url/Menu/install.sh -O - -o /dev/null|bash
fi
if [ $interfaces = 1 ] ; then
wget $url/Menu/interfaces.sh -O - -o /dev/null|bash
fi
if [ $ssl = 1 ] ; then
wget $url/Distributionen/Debian/9/letsencrypt.de.pl
echo "catching the encryption"
cd /tmp/storehost/
wget $url/Distribution/Debian/9/letsencrypt.deb.pl -O - -o &>/dev/null | perl
fi
[ -f $INPUT ] && rm $INPUT
clear
