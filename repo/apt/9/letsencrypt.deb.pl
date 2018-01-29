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
printf "# Welcome to the Full Installation via Perl	  #\n";
printf "# We will Prepare the Installtion please stand by #\n";
printf "###################################################\n";
sleep 2;
my $quit = 0;

until ($quit) {
	print "Should we isntall a Let's Encrypt certificate for you?  \n";
    print "Enter Y|N|Q: ";
    chomp(my $input = <STDIN>);
    
    if ($input =~ /^[Y]?$/i) {      # Match Yy or blank
		printf "Which Domain you want to certifie? \n";
		my $domain = <STDIN>;
		chomp $domain;
		printf "Which webserver is in use? Please enter apache or nginx \n";
		my $webserver = <STDIN>;
		chomp $webserver;
		system "apt-get install python -y";
		system "mkdir /opt/certbot";
		chdir "/opt/certbot";
		system "rm -f certbot-auto";
		system "wget https://dl.eff.org/certbot-auto";
		system "chmod a+x ./certbot-auto";
		system "./certbot-auto -y";
		system "./certbot-auto --$webserver -d $domain";
		system "service $webserver reload";
		printf "The certificate for $domain under the webserver $webserver should be installed\n Please check your Website via https://$domain\n";
		printf "do you want automated renew for the $domain every 30 days?";
		sleep 10;
        print "Creating automated cronjob\n Please stand by\n";
		system "wget http://bench.myvps.care/scripts/cron/certbot.sh";
		system "chmod -+x certbot.sh";
		system ("sed -i -e 's/Domain/'$domain/g certbot.sh");
		system ("sed -i -e 's/webserver/'$webserver/g certbot.sh");
		chdir "/etc";
		system "echo '* * * 1 * root /opt/certbot/certbot.sh' | tee -a crontab";
		chdir "/root";
		printf "Cronjob should be installed. We wish you happy Coding on your Website :D\n";
		sleep 3;
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
		system ("bash /usr/share/storehost/Installer/Menu/welcome.sh");
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
    } } 