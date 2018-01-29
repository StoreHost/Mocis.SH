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

		system ("screen -dmSL workstuff apt-get update -y");
		if  ! screen -list | grep -q "workstuff"; then  
		fi