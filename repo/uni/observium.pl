#!/usr/bin/perl
############################################################
# Developed by Store-Host
# Version 0.0.0.1
# Web: https://www.store-host.com
#
# Thank to all of our Testers
# Neavision.eu
# Thhunder
# iTweek ts3-server.ch My-servers.ch
#
# Debian-Installation-Script-Perl
##########################################
#use warnings;
my $os =grep 9 /etc/issue.net;
print ("Hello you will get observium installed on your System\n ")
if ( $os == "Linux 9" ) {
  print "Hello Debian 9\n";
  sleep 2;
  system ("aptitude update -y && apt-get upgrade -y");
  system ("aptitudeinstall libapache2-mod-php7.0 php7.0-cli php7.0-mysql php7.0-mysqli php7.0-gd php7.0-mcrypt php7.0-json php-pear snmp fping mariadb-server mariadb-client python-mysqldb rrdtool subversion whois mtr-tiny ipmitool graphviz imagemagick apache2");
  mkdir ("-p /opt/observium");
  system ("cd /opt/observium");
  system ("wget http://www.observium.org/observium-community-latest.tar.gz");
  system ("tar zxvf observium-community-latest.tar.gz | rm observium-community-latest.tar.gz");
  system ("cd observium");
  system ("cp config.php.default config.php ");
  print ("HeHe Copied a file you saw it?")}
  elsif ($os == "Linux 8") {
  print "Hello Debian 8 \n";}
  else {
  print "Hello unknown Distribution\n";}
