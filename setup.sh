#!/usr/bin/env bash
# -*- coding: utf-8 -*-
#title           :setup.sh
#description     :Installation of the nesseary tools
#author          :Stefan Baumgartner
#date            :15.06.2018
#version         :1.00
#usage           :bash setup.sh
#notes           :Please modify only if you know what you do
########################################################################
########################################################################
# Developed by Store-Host                                              #
# Version 0.1                                                          #
# Web: https://www.store-host.com                                      #
# 	Mocis is distributed in the hope that it will be useful,           #
#   but WITHOUT ANY WARRANTY; without even the implied warranty of     #
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the      #
#   GNU General Public License for more details.                       #
########################################################################
########################################################################
#   Variables                                                          #
########################################################################
scriptname="mocis"
scriptnamezipped="mocis.zip"
start_path="/usr/local/bin"
path="/usr/local/share/mocis"
updateurl="stable.mocis.sh/$scriptname"
installedname="mocis"
version="1.00"
giturl="stable.mocis.sh/mocis-ce.zip"
gitname="mocis-ce.zip"
########################################################################
#   Spinner                                                            #
########################################################################
spin() {
   local -a marks=( '/' '-' '\' '|' )
   while [[ 1 ]]; do
     printf '%s\r' "${marks[i++ % ${#marks[@]}]}"
     sleep 1
   done
 }
########################################################################
function _legal() {
cat <<"EOF"
Mocis is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
EOF
}
########################################################################
#   Powered by                                                         #
########################################################################
function _printPoweredBy()
{
cat <<"EOF"

 Powered By:
  __  __            _        _____ _    _
 |  \/  |          (_)      / ____| |  | |
 | \  / | ___   ___ _ ___  | (___ | |__| |
 | |\/| |/ _ \ / __| / __|  \___ \|  __  |
 | |  | | (_) | (__| \__ \_ ____) | |  | |
 |_|  |_|\___/ \___|_|___(_)_____/|_|  |_|

 >> Web: https://mocis.sh
 >> Store: https://www.store-host.com

 ################################################################
EOF
}
 ########################################################################
 #   Check OS                                                           #
 ########################################################################
if [ -d "/etc/apt" ]; then
  pmgr=apt-get
fi
if [ -d "/etc/yum" ]; then
  pmgr=yum
fi
########################################################################
#   Binary Installer                                                   #
########################################################################
function _install_binarys {
echo -ne "Install git, python, zip "  && \
 $pmgr -y install git zip python >/dev/null && \
 $pmgr -y install python-pip -y >/dev/null && \
 pip install wget >/dev/null && \
RESULT=$?
if [ $RESULT -eq 0 ]; then
  echo  " [Ok]"
else
  echo " [failed]"
fi

}
########################################################################
#   Local Installation                                                 #
########################################################################
function _installlocal() {
  _legal
  echo ">Accept< >Exit<"
  read legal
  if [[ $legal =~ ^([aA][cC][cC]|[eE]|[pP]|[tT])+$ ]]; then
  if [ -d $path ]; then
    echo "please start the service using $scriptname --start or update $scriptname --update"
  else
    _install_binarys
    #git clone -s $giturl -p $path
	mkdir -p $path
	wget -q $giturl
	mv $gitname $scriptnamezipped
	unzip mocis.zip > /dev/null
	mv mocis/* $path/
	#mv $path/mocis/* $path && rm -R $path/mocis
	mv $path/lib/mocis.sh $start_path/mocis
	chmod -+x $start_path/mocis
    cd $path/lib/
    python ini.py
    cd ~
    echo "Installation Done"
	echo ""
    echo "doing some cleaning..."
	rm -Rf /root/mocis && rm -Rf mocis.zip
	echo "You can now start whit \"$installedname\" or \"$installedname -h\" to view all commands"
  fi
  else
   exit 0
  fi
}
########################################################################
#   HELP Text                                                          #
########################################################################
function _helptxt() {
  echo "hello and welcome with the help of Mocis."
  echo "You are welcome to add the lower commands as an argument to the script,"
  echo "for example, for single functions or direct start "
}
########################################################################
# The command line help                                                #
########################################################################
_display_help() {
    echo
    echo
    echo
    echo "Usage: $0 " >&2
    _printPoweredBy
    echo
    _helptxt
    echo
    echo "   -h         --help                  shows this help"
    echo "   -i,        --install               install local to the system"
    echo "   -u         --update                Update to the latest version"
    echo "   -v,        --version               Shows the actual version"
    echo
    # echo some stuff here for the -a or --add-options
    exit 1
}

########################################################################
# Check if parameters options                                          #
# are given on the commandline                                         #
########################################################################
while :
do
    case "$1" in
      -r | --resolution)
          if [ $# -ne 0 ]; then
            resolution="$2"   # You may want to check validity of $2
          fi
          shift 2
          ;;
      -h | --help)
          _display_help  # Call your function
          exit 0
          ;;
      -i | --install)
          _installlocal
          exit 0
          ;;
      -u | --update)
          echo "getting the newest version..."
          _update
          exit 0
          ;;
      -v | --version)
          echo "Version $version is installed"
          exit 0
          ;;
      --) # End of all options
          shift
          break
          ;;
      -*)
          echo "Error: Unknown option: $1" >&2
          ## or call function display_help
          exit 1
          ;;
      *)  # No more options
          break
          ;;
    esac
done
########################################################################
#   Core !do not touch!                                                #
########################################################################
 clear
_installlocal
