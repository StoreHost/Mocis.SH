#!/bin/bash
############################################################
# Developed by Store-Host
# Version 0.0.5.0
# Web: https://www.store-host.com
#	Store-Host is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
############################################################
#############
# Vars
#
. /usr/share/mocis/sys/config/setup-vars
sshport=0
sshpermit=0
autoupdate=0
nmap=0
debsums=0
etckeeper=0
rkhunter=0
logcheck=0
iptables=0
rsync=0
##############
# Dialog First Time Setup
#
dialog  --no-lines --clear --colors --no-collapse --backtitle "[ M.O.C.I.S ]" --title "First Time Setup" \
--msgbox "Hello and Welcome to the Step by Step installation of your Security Services. \nWe will guid you trouht all of the steps.\n" 0 0
##############
# Dialog SSH-Port
#
dialog  --no-lines --clear --colors --no-collapse --backtitle "[ M.O.C.I.S ]" --title "SSH-Port" \
--yesno "Would you like to change the SSH port?\n\nPort changes make's it harder to break in to your system. " 0 0
response=$?
        case $response in
        0) echo " ";;
        1) clear exit;;
        255) clear echo "[ESC] key pressed.";;
		esac
			if [ $response = 0 ]
			then
        sshport=1
			fi
##############
# Dialog permit SSH Connections
#
dialog  --no-lines --clear --colors --no-collapse --backtitle "[ M.O.C.I.S ]" --title "SSH Connections" \
--yesno "Do you like to lock the SSH connection for password authentication?\n\nNo one can than connect via root and the initial password." 0 0
response=$?
        case $response in
        0) echo " ";;
        1) clear exit;;
        255) clear echo "[ESC] key pressed.";;
		esac
			if [ $response = 0 ]
			then
        sshpermit=1
			fi
##############
# Dialog Auto-Update
#
dialog  --no-lines --clear --colors --no-collapse --backtitle "[ M.O.C.I.S ]" --title "Auto-Update" \
--yesno "There is a possibility to auto update and upgrade your system for the newest Updates and Patches.\n\nSo you dont have to ckeck it manualy and install it." 0 0
response=$?
        case $response in
        0) echo " ";;
        1) clear exit;;
        255) clear echo "[ESC] key pressed.";;
		esac
			if [ $response = 0 ]
			then
        autoupdate=1
			fi
##############
# Dialog Nmap
#
dialog  --no-lines --clear --colors --no-collapse --backtitle "[ M.O.C.I.S ]" --title "Nmap" \
--yesno "Nmap ('Network Mapper') is a free and open source (license) utility for network discovery and security auditing." 0 0
response=$?
        case $response in
        0) echo " ";;
        1) clear exit;;
        255) clear echo "[ESC] key pressed.";;
		esac
			if [ $response = 0 ]
			then
        nmap=1
			fi
##############
# Dialog Debsums
#
dialog  --no-lines --clear --colors --no-collapse --backtitle "[ M.O.C.I.S ]" --title "Debsums" \
--yesno "debsums - check the MD5 sums of installed Debian packages" 0 0
response=$?
        case $response in
        0) echo " ";;
        1) clear exit;;
        255) clear echo "[ESC] key pressed.";;
		esac
			if [ $response = 0 ]
			then
        debsums=1
			fi
##############
# Dialog etckeeper
#
dialog  --no-lines --clear --colors --no-collapse --backtitle "[ M.O.C.I.S ]" --title "etckeeper" \
--yesno "etckeeper is a collection of tools to let /etc be stored in a git, mercurial, darcs, or bzr repository. " 0 0
response=$?
        case $response in
        0) echo " ";;
        1) clear exit;;
        255) clear echo "[ESC] key pressed.";;
		esac
			if [ $response = 0 ]
			then
        etckeeper=1
			fi
##############
# Dialog rkhunter & chkrootkit
#
dialog  --no-lines --clear --colors --no-collapse --backtitle "[ M.O.C.I.S ]" --title "rkhunter & chkrootkit" \
--yesno "rkhunter (Rootkit Hunter) is a Unix-based tool that scans for rootkits, backdoors and possible local exploits. " 0 0
response=$?
        case $response in
        0) echo " ";;
        1) clear exit;;
        255) clear echo "[ESC] key pressed.";;
		esac
			if [ $response = 0 ]
			then
        rkhunter=1
			fi
##############
# Dialog logcheck
#
dialog  --no-lines --clear --colors --no-collapse --backtitle "[ M.O.C.I.S ]" --title "logcheck" \
--yesno "Logcheck is a simple utility which is designed to allow a system administrator to view the logfiles which are produced upon hosts under their control" 0 0
response=$?
        case $response in
        0) echo " ";;
        1) clear exit;;
        255) clear echo "[ESC] key pressed.";;
		esac
			if [ $response = 0 ]
			then
        logcheck=1
			fi
##############
# Dialog Iptables
#
dialog  --no-lines --clear --colors --no-collapse --backtitle "[ M.O.C.I.S ]" --title "Iptables" \
--yesno "Iptables is a firewall, installed by default on all official Ubuntu distributions " 0 0
response=$?
        case $response in
        0) echo " ";;
        1) clear exit;;
        255) clear echo "[ESC] key pressed.";;
		esac
			if [ $response = 0 ]
			then
        iptables=1
			fi
##############
# Dialog rsync
#
dialog  --no-lines --clear --colors --no-collapse --backtitle "[ M.O.C.I.S ]" --title "rsync" \
--yesno "rsync is a utility for efficiently transferring and synchronizing files across computer systems, by checking the timestamp and size of files." 0 0
response=$?
        case $response in
        0) echo " ";;
        1) clear exit;;
        255) clear echo "[ESC] key pressed.";;
		esac
			if [ $response = 0 ]
			then
        rsync=1
			fi

##############
# If-Statements
#
if [ $sshport = 1 ] ; then
  echo " Placeholder "
  OUTPUT="/tmp/input.txt"
  >$OUTPUT
  trap "rm $OUTPUT; exit" SIGHUP SIGINT SIGTERM
  dialog --title "Change SSH Port" \
  --backtitle "[ M.O.C.I.S ]" \
  --inputbox "Enter your new Port" 8 60 2>$OUTPUT
  response=$?
  sshport_new=$(<$OUTPUT)
  echo " Placeholder "
  sed -i -e 's/#Port 22 /Port $sshport_new/g' /etc/ssh/sshd_config
  echo "$sshport_new"
  echo "Port Changed Restarting Service"
  service ssh restart
fi
if [ $sshpermit = 1 ] ; then
  echo " Placeholder "
fi
if [ $autoupdate = 1 ] ; then
  echo " Placeholder "
fi
if [ $nmap = 1 ] ; then
  echo " Placeholder "
fi
if [ $debsums = 1 ] ; then
  echo " Placeholder "
fi
if [ $etckeeper = 1 ] ; then
  echo " Placeholder "
fi
if [ $rkhunter = 1 ] ; then
  echo " Placeholder "
fi
if [ $logcheck = 1 ] ; then
  echo " Placeholder "
fi
if [ $iptables = 1 ] ; then
  echo " Placeholder "
fi
echo "Finished with all."
