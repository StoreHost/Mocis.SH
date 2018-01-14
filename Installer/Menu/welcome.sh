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
url= xmlstarlet sel -t -m '//url[1]' -v . -n </tmp/storehost/config/config.xml
dir= xmlstarlet sel -t -m '//url[1]' -v . -n </usr/share/storehost/dependencies/Config/config.xml
echo $url
sleep 5
benchmark=0
install=0
Interfaces=0
sslperl=0
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
Backup "FTP Backupscript to Remote Server" \
Exit "Exit to the shell" 2>"${INPUT}"
menuitem=$(<"${INPUT}")
[ -f $INPUT ] && rm $INPUT
# make decsion
case $menuitem in
        Benchmarking) benchmark=1;;
        Installations) install=1;;
                Interfaces) interfaces=1;;
                Backup) echo "Will be comming in the near future, stay tuned.";;
        Exit) echo "Bye"; break;;
esac
if [ $benchmark = 1 ] ; then
bash $dir/dependencies/Bash/benchmark.sh
exit
fi
if [ $install = 1 ] ; then
bash $dir/Menu/install.sh
fi
if [ $interfaces = 1 ] ; then
bash $dir/Menu/interfaces.sh
fi
if [ $sslperl = 1 ] ; then
echo "catching the encryption"
perl $dir/letsencrypt.deb.pl
echo "catching the encryption"
rm -f letsencrypt.deb.pl
fi
