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
use strict;
use warnings;

system ("clear");
printf "###################################################\n";
printf "# 	Welcome to the Full Installation via Perl	#\n";
printf "# We will Prepare the Installtion please stand by #\n";
printf "###################################################\n";
sleep 2;
my $quit = 0;

until ($quit) {
	print "Should we isntall LAMP for you?  \n";
    print "Enter Y|N|Q: ";
    chomp(my $input = <STDIN>);

    if ($input =~ /^[Y]?$/i) {      # Match Yy or blank
		system ("apt-get update -y \n");
		system ("apt-get install apache2 -y \n");
		system ("apt-get install php5 -y \n");
		system ("apt-cache search php5\n");
		system ("apt-get -y install php5-mysqlnd php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-pspell php5-recode php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl -y\n");
		system ("clear");
		printf ("Restarting Apache\n");
		system ("service apache2 restart");
		system ("clear");
		sleep 2;
		printf ("Installing APCu PHP- Cache\n");
		system ("apt-get install php5-apcu -y");
		system ("service apache2 restart");
		system ("clear");
		printf ("Installing Mysql Server\n");
		sleep 2;
		system ("apt-get -y install mariadb-server mariadb-client");
		system ("clear");
		printf ("Installing PHPMyadmin\n");
		sleep 2;
		system ("apt-get -y install phpmyadmin");
		system ("clear");
		printf "Starting Mysql Secure Installation\n";
		sleep 2;
		system ("mysql_secure_installation\n");
        printf "You won a LAMP Installation!\n";
		printf "Checking if you got your Price!\n";
		printf "3\n";
		sleep 1;
		printf "2\n";
		sleep 1;
		printf "1\n";
		sleep 1;
		system ("php -v");
		printf "\n";
		printf "\n";
		system ("mysql -V");
		printf "\n";
		printf "\n";
		system ("service apache2 status");
		printf "Thank you for using the StoreHost installer.\n";
		sleep 2;
		$quit = 1;
    } elsif ($input =~ /^[N]$/i) {  # Match Nn
        printf "No Installation for you!\n";
		sleep 2;
		system ("clear");
		$quit = 1;
    } elsif ($input =~ /^[Q]$/i) {  # Match Qq
        printf "Ok, you're done.\n";
        $quit = 1;
    } else {
        printf "Sorry im Stupid...\n Can you repeat the Answer?.\n";
    }
}

my $quit4 = 0;

until ($quit4) {
	print "#################################\n";
	print "# Do you want back to the Menu? #\n";
    print "# Enter Y|N|Q:                  #\n";
    print "#################################\n";
    chomp(my $input = <STDIN>);

    if ($input =~ /^[Y]?$/i) {      # Match Yy or blank
        print "Going Back to the Menu...\nPlease Wait...!\n";
		sleep 2;
		system ("bash /usr/share/mocis/overlay/welcome.sh");
		sleep 2;
		$quit4 = 1;
    } elsif ($input =~ /^[N]$/i) {  # Match Nn
        print "Okay, no more Installations!\n";
		system ("clear");
		sleep 2;
		$quit4 = 1;
    } elsif ($input =~ /^[Q]$/i) {  # Match Qq
        printf "Ok, you're done.\n";
		system ("clear");
        $quit4 = 1;
    } else {
        printf "Sorry im Stupid...\nCan you repeat the Answer?.\n";
    }
}
