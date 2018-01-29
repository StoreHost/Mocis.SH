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
sslperl=0
INPUT=save.$$
trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM
dialog --clear --backtitle "[ M.O.C.I.S ]" \
--title "[ #Security ]" \
--ascii-lines \
--menu "Here you can Install an SSL certificate or later some tools.\n" 0 0 8 \
SSL "Let's Encrypt whit certbot" \
Back "Back to the Mainmenu" \
Exit "Exit to the shell" 2>"${INPUT}"
menuitem=$(<"${INPUT}")
[ -f $INPUT ] && rm $INPUT
case $menuitem in
        SSL) sslperl=1;;
        Back) goback=1;;
        Exit) echo "Bye"; clear;
esac
if [ $sslperl = 1 ] ; then
	perl /usr/share/mocis/repo/apt/9/letsencrypt.deb.pl
fi
if [ $goback = 1 ] ; then
	bash /usr/share/mocis/overlay/welcome.sh
fi
