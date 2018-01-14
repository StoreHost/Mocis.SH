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
# Interaces-Installer Menu
#
url=http://bench.myvps.care/github/%0d/Installer
forxlore=0
imscp=0
easywi=0
goback=0
INPUT=sh-installer.sh.$$
trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM
dialog --clear --backtitle "Store-Host" \
--title "[ M A I N - M E N U ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 0 0 8 \
Froxlor "Webhosting Controll Panel" \
IMSCP "Webhosting Controll Panel" \
Easy-Wi "Gameserver Webinterface" \
Back "Back to the Mainmenu" \
Exit "Exit to the shell" 2>"${INPUT}"
menuitem=$(<"${INPUT}")
# make decsion
case $menuitem in
        Froxlor) forxlore=1;;
        IMSCP) imscp=1;;
                Easy-Wi) easywi=1;;
                Back) goback=1;;
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
                                        dialog --title "Store-Host Installer" --msgbox 'Froxlor is not supported for Debian 9 "Stretch"' 0 0
                                        exit
                                else
                                        touch /etc/apt/sources.list.d/froxlor.list
                                        echo 'deb http://debian.froxlor.org jessie main' > /etc/apt/sources.list.d/froxlor.list &>/dev/null
                                        apt-key adv --keyserver pool.sks-keyservers.net --recv-key FD88018B6F2D5390D051343FF6B4A8704F9E9BBC &>/dev/null
                                        apt-get update && apt-get upgrade -y &>/dev/null
                                        apt-get install php-curl &>/dev/null
                                        apt-get install froxlor phpmyadmin -y &>/dev/null
                                        sed -i 's/html/froxlor/g' /etc/apache2/sites-enabled/000-default.conf &>/dev/null
                                        service apache2 restart
                                        echo "Please enter your domain or IP address in the browser"
                                        echo "Froxlor can now be set up"
                                        clear
                                fi
                        fi
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
									dialog --title "Store-Host Installer" --msgbox 'I-MSCP is not supported for Debian 9 "Stretch"' 0 0
                                    exit
                                else
                                    apt-get update -y && apt-get upgrade -y &>/dev/null
                                    apt-get install ca-certificates perl wget whiptail &>/dev/null
                                    cd /usr/local/src
                                    wget https://github.com/i-MSCP/imscp/archive/1.6.x.tar.gz &>/dev/null
                                    tar -xzf 1.6.x.tar.gz &>/dev/null
                                    cd imscp-1.6.x
                                    perl imscp-autoinstall -d
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
							cd /tmp/storehost/
							wget $url/Distribution/Debian/9/easy-wi_install.sh &>/dev/null
							chmod -+x easy-wi_install.sh
							./easy-wi_install.sh
						fi
fi
if [ $goback = 1 ] ; then
wget -O - $url/Menu/welcome.sh | bash
fi