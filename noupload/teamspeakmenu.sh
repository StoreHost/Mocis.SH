#!/bin/bash
#####################################################################
# Developed by Store-Host                                           #
# Version 0.0.5.0                                                   #
# Web: https://www.store-host.com                                   #
#	Store-Host is distributed in the hope that it will be useful,     #
#   but WITHOUT ANY WARRANTY; without even the implied warranty of  #
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the   #
#   GNU General Public License for more details.                    #
#####################################################################
dialog --ascii-lines --msgbox "Hello and welcome to the Installation of Teamspeak." 0 0 --and-widget --ascii-lines --msgbox "Youre running the rigt version of Linux.\n Have fun."  0 0 --and-widget --ascii-lines --clear --inputbox "which user we should use to install Teamspeak?" 0 0 --and-menu --ascii-lines --msgbox  "Please us Space to Accept the Directory.\n if you press 'Enter' it will be installed in there.\n we recommend to use '/home/user/teamspeak'.\n Please choose any directory you will find it againg." 0 0 --and-widget --ascii-lines --dselect  /home 0 0

# get data stored in $OUPUT using input redirection
name="$(<$OUTPUT)"
echo "$name"
