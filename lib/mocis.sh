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
########################################################################                                                       #
# Web: https://www.store-host.com                                      #
# 	Mocis is distributed in the hope that it will be useful,           #
#   but WITHOUT ANY WARRANTY; without even the implied warranty of     #
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the      #
#   GNU General Public License for more details.                       #
########################################################################
path="/usr/local/share/mocis"
########################################################################
# _Powered By 														   #
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

EOF
}
########################################################################
#   HELP Text                                                          #
########################################################################
function _helptxt() {
  echo "hello and welcome with the help of Mocis."
  echo "You are welcome to add the lower commands as an argument to the script,"
  echo "for example, for single functions or direct start "
  echo "of Dialog or the Command Promt benchmark."
}
########################################################################
# The command line help                                                #
########################################################################
_display_help() {
    echo "Usage: $0 " >&2
    _printPoweredBy
	echo ""
    _helptxt
    echo
    echo "   -h,        --help                  Help"
	echo "   -s         --start                 start mocis"
    echo "   -u,        --update                Update to the newest Version"
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
      -h | --help)
          _display_help  # Call your function
          exit 0
          ;;

      -u | --update)
          echo "getting the newest version..."
          cp $path/lib/update.py /tmp/update.py
		  echo "copy the update to tmp"
		  python /tmp/update.py
		  echo "remove tmp files..."
		  echo "recreate the config file"
          cd $path/lib/
          python ini.py
		  rm /tmp/update.py
          exit 0
          ;;
      -v | --version)
          echo "Version $benchverion is installed"
          exit 0
          ;;
	  -s | --start)
	      echo "starting..."
		  python $path/menu/menu.py
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
_display_help
