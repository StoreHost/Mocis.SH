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
	print "Should we isntall TS3/Discord Sinusbot for you?  \n";
    print "Enter Y|N|Q: ";
    chomp(my $input = <STDIN>);
    
    if ($input =~ /^[Y]?$/i) {      # Match Yy or blank
		printf ("Please Provide us your Server's Public IP-Adress:\n");
		my $ip = <STDIN>;
		chomp $ip;
		system ("apt-get update -y \n");
		system ("apt-get install sudo screen curl x11vnc xvfb libxcursor1 ca-certificates bzip2 -y\n");
		system ("update-ca-certificates\n");
		system ("apt-get install libglib2.0-0 -y\n");
		system ("adduser sinusbot\n");
		system ("mkdir -p /opt/sinusbot\n");
		chdir  ("/opt/sinusbot") or die "cannot change to /opt/sinusbot/ $!\n";
		system ("ls");
		system ("curl -O https://www.sinusbot.com/dl/sinusbot-beta.tar.bz2\n");
		system ("tar -xjf sinusbot-beta.tar.bz2\n");
		system ("cp config.ini.dist config.ini");
		system ("sed -i -e 's/0.0.0.0/'$ip/g config.ini");
		system ("sed -i -e 's/ts3soundboard/sinusbot/g' config.ini");
		system ("chown -R sinusbot:sinusbot /opt/sinusbot");
		system ("wget http://dl.4players.de/ts/releases/3.0.18.2/TeamSpeak3-Client-linux_amd64-3.0.18.2.run");
		system ("chmod 0755 TeamSpeak3-Client-linux_amd64-3.0.18.2.run");
		printf ("you have to accept the Terms of Teamspeak\n You do this by pressing enter to scroll through the text or press q to simply go to the end.\n");
		sleep 3;
		system ("./TeamSpeak3-Client-linux_amd64-3.0.18.2.run");
		system ("cp plugin/libsoundbot_plugin.so TeamSpeak3-Client-linux_amd64/plugins/");
		system ("chmod -+x sinusbot");
		system ("chown -R sinusbot:sinusbot /opt/sinusbot\n");
		chdir ("/home/sinusbot");
		system ("wget http://bench.myvps.care/scripts/starter/sinusbot.sh\n");
		system ("chmod -+x sinusbot.sh");
		system ("chown -R sinusbot:sinusbot /home/sinusbot ");
		chdir ("/opt/sinusbot");
		printf ("Please write the Password in Yellow down, and change it immidiate after the first Login!! after that you can press CTRL+C to Quit the Bot.\n");
		sleep 10;
		system ("su sinusbot -c ./sinusbot");
		printf ("You can now login as sinusbot. 'login sinusbot -> password'\nThan start the Bot in a screen via executing the 'sinusbot.sh' file ./sinusbot.sh .\nIf no errors occured, than you can acces the bot under 'http://$ip:8087/'\n");
		sleep 10;
		
		
		
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
		chdir('/root'); 
		system ("./menu.sh");
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
