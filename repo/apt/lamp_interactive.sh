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
# Lamp Webserver installation
#Variables
#DIALOGRC=/usr/share/mocis/sys/config/dialog.conf
apache=0
nginx=0
mysql=0
mariadb=0
php7=0
php5=0
goback=0
INPUT=save.$$
trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM
dialog --no-lines \
--nocancel \
--backtitle "[ M.O.C.I.S ]" \
--title "Webserver Selection" \
--menu "You can choose betwen Apache and Nginx." 0 0 4 \
Apache2 "Apache Webserver"  \
Nginx "Nginx Webserver" \
Back "Back to the Menu" \
No-Webserver "Whitout any Webserver" 2>"${INPUT}"
menuitem=$(<"${INPUT}")
[ -f $INPUT ] && rm $INPUT
case $menuitem in
        Apache2) apache=1;;
        Nginx) nginx=1;;
        No-Webserver) clear;;
        Back) goback=1;;
esac
if [ $goback = 1 ] ; then
bash /usr/share/mocis/overlay/welcome.sh
exit
fi
INPUT=save.$$
trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM
dialog --no-lines \
--nocancel \
--backtitle "[ M.O.C.I.S ]" \
--title "Database Server Selection" \
--menu "You can choose betwen MySQL and MariaDB." 0 0 3 \
MySQL "Database Server"  \
MariaDB "Database Server" \
No-SQL "Whitout any SQL Server" 2>"${INPUT}"
menuitem2=$(<"${INPUT}")
[ -f $INPUT ] && rm $INPUT
case $menuitem2 in
        MySQL) mysql=1;;
        MariaDB) mariadb=1;;
        No-SQL) clear;;
esac
INPUT=save.$$
trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM
dialog --no-lines \
--nocancel \
--backtitle "[ M.O.C.I.S ]" \
--title "PHP Selection" \
--menu "You can choose betwen PHP-7 and PHP-5." 0 0 3 \
PHP7 ""  \
PHP5 "" \
No-PHP "Do not install PHP" 2>"${INPUT}"
menuitem3=$(<"${INPUT}")
[ -f $INPUT ] && rm $INPUT
case $menuitem3 in
        PHP7) php7=1;;
        PHP5) php5=1;;
		    Back) goback=1;;
        No-PHP) clear;;
esac

### Installation of PHP with Progressbar
dialog --title "Last check before installing!!!" \
--backtitle "[ M.O.C.I.S ]" \
--no-lines \
--yesno "Are you sure to install: \n\n$menuitem \n$menuitem2 \n$menuitem3 \n \nIf you press Yes, the installer will do his work. " 0 0
response=$?
        case $response in
        0) clear && echo ":D :D :D :D :D";;
        1) echo ':( :( :( :( :( ';;
        255) clear echo "[ESC] key pressed.";;
		esac
			if [ $response = 0 ]
			then
        if [ $apache = 1 ] ; then
          apt-get install apache2 -y > /dev/null
        fi
        if [ $nginx = 1 ] ; then
          apt-get install nginx -y > /dev/null
        fi
        if [ $mysql = 1 ] ; then
          apt-get install mysql-server -y > /dev/null
        fi
        if [ $mariadb = 1 ] ; then
          apt-get install mariadb-server -y >/dev/null
        fi
        if [ $php7 = 1 ] ; then
          if cat /etc/issue.net | grep 9; then
            echo percentage | dialog --backtitle "[ M.O.C.I.S ]" --title "Installing $menuitem3" --no-lines --gauge "Please stand by while your Server is installing $menuitem3" 0 0 0
            sleep 2
            aptitude install -y php7.0 php-mbstring php7.0-mysql php7.0-mbstring php-gettext > /dev/null
            php1="php7.0 php-mbstring php7.0-mysql php7.0-mbstring php-gettext"
            echo "20" | dialog --backtitle "[ M.O.C.I.S ]" --title "Installing $menuitem3" --no-lines --gauge "Please stand by while your Server is installing \n\n$php1" 0 0 0
            aptitude install -y php7.0-cli php7.0-curl php7.0-gd php7.0-geoip php7.0-intl php7.0-json > /dev/null
            php2="php7.0-cli php7.0-curl php7.0-gd php7.0-geoip php7.0-intl php7.0-json"
            echo "40" | dialog --backtitle "[ M.O.C.I.S ]" --title "Installing $menuitem3" --no-lines --gauge "Please stand by while your Server is installing \n\n$php2" 0 0 0
            aptitude install -y php7.0-mbstring php7.0-mcrypt php7.0-mysql php7.0-opcache php7.0-readline > /dev/null
            php3="php7.0-mbstring php7.0-mcrypt php7.0-mysql php7.0-opcache php7.0-readline"
            echo "60" | dialog --backtitle "[ M.O.C.I.S ]" --title "Installing $menuitem3" --no-lines --gauge "Please stand by while your Server is installing \n\n$php3" 0 0 0
            aptitude install -y php7.0-xml php7.0-xsl php7.0-zip > /dev/null
            php4="php7.0-xml php7.0-xsl php7.0-zip"
            echo "100" | dialog --backtitle "[ M.O.C.I.S ]" --title "Installing $menuitem3" --no-lines --gauge "Please stand by while your Server is installing \n\n$php4" 0 0 0
          elif cat /etc/issue.net | grep 8; then
              echo 'deb http://packages.dotdeb.org jessie all' > /etc/apt/sources.list.d/dotdeb.list
              apt-get install -y apt-transport-https > /dev/null
              curl http://www.dotdeb.org/dotdeb.gpg | apt-key add - < /dev/null
              apt-get update -y > /dev/null
              apt-get install -y php7.0  php-mbstring php7.0-mysql php7.0-mbstring php-gettext php7.0-cli php7.0-curl php7.0-gd php7.0-geoip php7.0-intl php7.0-json php7.0-mbstring php7.0-mcrypt php7.0-mysql php7.0-opcache php7.0-readline php7.0-xml php7.0-xsl php7.0-zip > /dev/null
  				else
            echo "cant identify the OS, Are you shure it is Debian?"
  				fi
        fi
        if [ $php5 = 1 ] ; then
          apt-get install php -y >/dev/null
        fi
			fi
      if [ $response = 1 ]
      then
        bash /usr/share/mocis/repo/apt/9/lamp_interactive.sh
      fi
dialog --backtitle "[ M.O.C.I.S ]" --title "Installed $menuitem1 $menuitem2 $menuitem3" --no-lines --yesno "You wanna go back to the Menu?" 0 0
response=$?
case $response in
0) echo "starting";;
1) clear exit;;
255) clear echo "[ESC] key pressed.";;
esac
if [ $response = 0 ]
then
  bash /usr/share/mocis/overlay/welcome.sh
fi
