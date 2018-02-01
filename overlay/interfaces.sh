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
# Interfaces-Installer Menu
#
forxlore=0
phpmyadmin=0
imscp=0
easywi=0
goback=0
sinusbot=0
INPUT=save.$$
trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM
dialog --clear --backtitle "[ M.O.C.I.S ]" \
--title "[ Server Webinterfaces ]" \
--ascii-lines \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 0 0 8 \
Froxlor "Webhosting Controll Panel" \
PHPmyAdmin "MySQL Webaccess" \
IMSCP "Webhosting Controll Panel" \
Easy-Wi "Gameserver Webinterface" \
Sinusbot "Teamspeak Musicbot" \
Back "Back to the Mainmenu" \
Exit "Exit to the shell" 2>"${INPUT}"
menuitem=$(<"${INPUT}")
[ -f $INPUT ] && rm $INPUT
# make decision
case $menuitem in
        Froxlor) forxlore=1;;
        PHPmyAdmin) phpmyadmin=1;;
        IMSCP) imscp=1;;
		    Easy-Wi) easywi=1;;
        Back) goback=1;;
        Sinusbot) sinusbot=1;;
        Exit) echo "Bye"; break;;
esac
if [ $forxlore = 1 ] ; then
        dialog --yesno "This can damage your system !! Do you want to continue?" 0 0
                response=$?
                case $response in
                0) echo "Starting";;
                1) echo exit;;
                255) echo "[ESC] key pressed.";;
                esac
                        if [ $response = 0 ]
                        then
                                if cat /etc/issue.net | grep 9; then
                                        dialog --backtitle "[ M.O.C.I.S ]" --title "Error" --msgbox 'Froxlor is not supported for Debian 9 "Stretch"' 0 0
                                        exit
                                else
                                        touch /etc/apt/sources.list.d/froxlor.list
                                        echo 'deb http://debian.froxlor.org jessie main' > /etc/apt/sources.list.d/froxlor.list &>/dev/null
                                        apt-key adv --keyserver pool.sks-keyservers.net --recv-key FD88018B6F2D5390D051343FF6B4A8704F9E9BBC &>/dev/null
                                        apt-get update && apt-get upgrade -y
                                        apt-get install php-curl
                                        apt-get install froxlor phpmyadmin -y
                                        sed -i 's/html/froxlor/g' /etc/apache2/sites-enabled/000-default.conf
                                        service apache2 restart
                                        echo "Please enter your domain or IP address in the browser"
                                        echo "Froxlor can now be set up"
                                        clear
                                fi
                        fi
fi
if [ $phpmyadmin = 1 ] ; then
	apt-get install phpmyadmin -y
fi
if [ $imscp = 1 ] ; then
                dialog --yesno "This can damage your system !! Do you want to continue?" 0 0
                response=$?
                case $response in
                0) echo "Starting";;
                1) echo exit;;
                255) echo "[ESC] key pressed.";;
                esac
                        if [ $response = 0 ]
                        then
                                if cat /etc/issue.net | grep 9; then
                                  dialog --backtitle "[ M.O.C.I.S ]" --title "Error" --msgbox 'I-MSCP is not supported for Debian 9 "Stretch"' 0 0
                                  exit
                                else
                                    apt-get update -y && apt-get upgrade -y
                                    apt-get install ca-certificates perl wget whiptail
                                    wget https://github.com/i-MSCP/imscp/archive/1.6.x.tar.gz -P /usr/share/mocis/
                                    cd /usr/share/mocis/
                                    tar -xzf 1.6.x.tar.gz
                                    perl imscp-1.6.x/imscp-installer
                                fi
                        fi
fi
if [ $easywi = 1 ] ; then
				dialog --yesno "This can damage your system !! Do you want to continue?" 0 0
                response=$?
                case $response in
                0) echo "Starting";;
                1) echo exit;;
                255) echo "[ESC] key pressed.";;
                esac
                        if [ $response = 0 ]
                        then
							echo "Easy web interface is prepared."
							wget https://raw.githubusercontent.com/easy-wi/installer/master/easy-wi_install.sh /usr/share/mocis/repo/apt/
							bash /usr/share/mocis/repo/apt/easy-wi_install.sh
						fi
fi
if [ $goback = 1 ] ; then
	bash /usr/share/mocis/overlay/welcome.sh
fi
if [ $sinusbot = 1 ] ; then
	perl /usr/share/mocis/repo/apt/sinusbot.pl
	exit
fi
exit
