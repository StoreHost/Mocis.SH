#!/bin/bash


############################################################
# Installation von "dialog"
#

if [ -d "/etc/apt" ]; then
	pmgr=apt
fi
if [ -d "/etc/yum" ]; then
	pmgr=yum
fi

if [ $pmgr == "apt" ]; then
	apt-get install dialog -y
fi
if [ $pmgr == "yum" ]; then
	yum install dialog -y
fi


############################################################
# Variablen
#


do_informations=0
do_network=0
do_io=0
do_cpu=0
network_1=0
network_2=0
network_3=0
network_4=0
network_5=0
network_6=0
network_7=0
network_8=0
network_9=0
network_10=0
network_11=0
network_12=0
network_13=0
network_14=0
network_15=0
network_16=0
network_17=0
network_18=0
network_19=0
network_20=0
network_21=0


############################################################
# Menü
#

cmd=(dialog --separate-output --checklist "Bitte waehlen Sie Ihre gewuenschten Optionen" 22 76 16)
options=(1 "Systeminformationen" on
         2 "Netzwerk Benchmark" on
         3 "I/O Performance" on
         4 "CPU Benchmark" on)
main=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $main
do
    case $choice in
        1)
			do_informations=1
            ;;
        2)
			cmd=(dialog --separate-output --checklist "Bitte waehlen Sie Ihre gewuenschten Standorte" 22 76 16)
			options=(1  "OVH (FR)" on  
					 2  "IP-Projects (DE)" on
					 3  "combahton (DE)" on
					 4  "meerfabig (DE)" on
					 5  "myloc (DE)" off
					 6  "FSIT (CH)" on
					 7  "Leaseweb (DE)" on
					 8  "Leaseweb (US)" off
					 9  "Leaseweb (NL)" off
					 10  "Leaseweb (SG)" off
					 11  "Softlayer (NL)" off
					 12 "Softlayer (CN)" off
					 13 "Softlayer (GB)" off
					 14 "Softlayer (JP)" off
					 15 "Softlayer (US)" off
					 16 "Softlayer (CA)" off
					 17 "Softlayer (DE)" on
					 18 "EDIS (AT)" on
					 19 "Linode (DE)" on
					 20 "CacheFly (CDN)" on
					 21 "Cloudflare (CDN)" on
					)
			network=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
			clear
			for choice in $network
			do
				case $choice in
					1)
						network_1=1
						;;
					2)
						network_2=1
						;;
					3)
						network_3=1
						;;
					4)
						network_4=1
						;;
					5)
						network_5=1
						;;
					6)
						network_6=1
						;;
					7)
						network_7=1
						;;
					8)
						network_8=1
						;;
					9)
						network_9=1
						;;
					10)
						network_10=1
						;;
					11)
						network_11=1
						;;
					12)
						network_12=1
						;;
					13)
						network_13=1
						;;
					14)
						network_14=1
						;;
					15)
						network_15=1
						;;
					16)
						network_16=1
						;;
					17)
						network_17=1
						;;
					18)
						network_18=1
						;;
					19)
						network_19=1
						;;
					20)
						network_20=1
						;;
					21)
						network_21=1
						;;
				esac
			done
			do_network=1
            ;;
        3)
            do_io=1
            ;;
        4)
			dialog --yesno "Um den CPU Benchmark ausfuehren zu koennen, muss ein Programm namens 'bc' installiert werden. Soll der CPU Benchmark nach wie vor ausgefuehrt und das Programm installiert werden?" 0 0
			choice=$?
			clear
			if [ $choice = 0 ]
			then
			   do_cpu=1
			else
			   do_cpu=1
			fi
            ;;
    esac
done


############################################################
# Installation von 'bc'
#


if [ $do_cpu = 1 ]
then
	if [ $pmgr = "apt" ]
	then
		apt-get install bc -y
	fi
	
	if [ pmgr  = "yum" ]
	then
		yum install bc -y
	fi
	
	clear
fi


############################################################
# ENSKY Media (www.ensky-media.net)
# ENSKY.eu (www.ensky.eu)
#

echo -e "\033[31mENSKY Media Benchmark Version 7.6 - 20.04.2017 edit by SP\033[0m"
echo -e "\033[32mTeamspeak 3: public-ts.info\033[0m"
echo -e "\033[32mForum: serverboard.net\033[0m"

############################################################
# Informationen
#
if [ $do_informations = 1 ]
then
	cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
	cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
	freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
	tram=$( free -m | awk 'NR==2 {print $2}' )
	swap=$( free -m | awk 'NR==4 {print $2}' )
	up=$(uptime|awk '{ $1=$2=$(NF-6)=$(NF-5)=$(NF-4)=$(NF-3)=$(NF-2)=$(NF-1)=$NF=""; print }')
	echo ""
	echo -e "\033[35mSysteminformationen \033[0m"
	echo ""
	echo -e "\033[36mProzessor :\033[0m $cname"
	echo -e "\033[36mProzessor-Kerne :\033[0m $cores"
	echo -e "\033[36mTaktfrequenz pro Kern:\033[0m $freq MHz"
	echo -e "\033[36mArbeitsspeicher :\033[0m $tram MB"
	echo -e "\033[36mSWAP :\033[0m $swap MB"
	echo -e "\033[36mLaufzeit :\033[0m $up"
fi


############################################################
# Netzwerk Benchmark
#


if [ $do_network = 1 ]
then

	echo ""
	echo -e "\033[35mNetzwerk Benchmark \033[0m"
	echo ""
	echo -e "\033[32mInternet Service Provider:\033[0m"

	
	
	#OVH (DE)
	if [ $network_1 = 1 ]
	then
		result=$( wget -O /dev/null http://proof.ovh.net/files/100Mb.dat 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mOVH(FR) - \033[33m100MB Testfile \033[0m: $result"
	fi	
	
	#IP Projects (DE)
	if [ $network_2 = 1 ]
	then
		result=$( wget -O /dev/null http://lg.ip-projects.de/100MB.test 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mIP-Projects(DE) - \033[33m100MB Testfile \033[0m: $result"
	fi

	#combahton (DE)
	if [ $network_3 = 1 ]
	then
		result=$( wget -O /dev/null http://lg.combahton.net/100MB.test 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mcombahton(DE) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#meerfabig (DE)
	if [ $network_4 = 1 ]
	then
		result=$( wget -O /dev/null http://mirror.meerfarbig.io/testfiles/1G 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mmeerfabig(DE) - \033[33m1GB Testfile \033[0m: $result"
	fi
	
	#myloc (DE)
	if [ $network_5 = 1 ]
	then
		result=$( wget -O /dev/null http://speed.myloc.de/100MB.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mmyloc(DE) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#FSIT (CH)
	if [ $network_6 = 1 ]
	then
		result=$( wget -O /dev/null http://fsit.ch/speed/100mebibyte.dat 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mFSIT(CH) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#Leaseweb (DE)
	if [ $network_7 = 1 ]
	then
		result=$( wget -O /dev/null http://mirror.de.leaseweb.net/speedtest/100mb.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mLeaseweb(DE) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#Leaseweb (US)
	if [ $network_8 = 1 ]
	then
		result=$( wget -O /dev/null http://mirror.us.leaseweb.net/speedtest/100mb.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mLeaseweb(US) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#Leaseweb (NL)
	if [ $network_9 = 1 ]
	then
		result=$( wget -O /dev/null http://mirror.nl.leaseweb.net/speedtest/100mb.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mLeaseweb(NL) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#Leaseweb (SG)
	if [ $network_10 = 1 ]
	then
		result=$( wget -O /dev/null http://mirror.sg.leaseweb.net/speedtest/100mb.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mLeaseweb(SG) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#Softlayer (NL)
	if [ $network_11 = 1 ]
	then
		result=$( wget -O /dev/null http://speedtest.ams01.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mSoftlayer(NL) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#Softlayer (CN)
	if [ $network_12 = 1 ]
	then
		result=$( wget -O /dev/null http://speedtest.hkg02.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mSoftlayer(CN) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#Softlayer (GB)
	if [ $network_13 = 1 ]
	then
		result=$( wget -O /dev/null http://speedtest.lon02.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mSoftlayer(GB) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#Softlayer (JP)
	if [ $network_14 = 1 ]
	then
		result=$( wget -O /dev/null http://speedtest.tok02.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mSoftlayer(JP) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#Softlayer (US)
	if [ $network_15 = 1 ]
	then
		result=$( wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mSoftlayer(US) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#Softlayer (CA)
	if [ $network_16 = 1 ]
	then
		result=$( wget -O /dev/null http://speedtest.tor01.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mSoftlayer(CA) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#Softlayer (DE)
	if [ $network_17 = 1 ]
	then
		result=$( wget -O /dev/null http://speedtest.fra02.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mSoftlayer(DE) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#EDIS (AT)
	if [ $network_18 = 1 ]
	then
		result=$( wget -O /dev/null http://at.edis.at/100MB.test 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mEDIS(AT) - \033[33m100MB Testfile \033[0m: $result"
	fi

	#Linode Frankfurt (DE)
	if [ $network_19 = 1 ]
	then
		result=$( wget -O /dev/null http://speedtest.frankfurt.linode.com/100MB-frankfurt.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mLinode Frankfurt(DE) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#CacheFly CDN 
	if [ $network_20 = 1 ]
	then
		result=$( wget -O /dev/null http://cachefly.cachefly.net/100mb.test 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mCacheFly CDN - \033[33m100MB Testfile \033[0m: $result"
	fi

	#Cloudflare CDN 
	if [ $network_21 = 1 ]
	then
		result=$( wget -O /dev/null http://playground.host/mini/speedtest/funny.jpg 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mCloudflare CDN - \033[33m100MB Testfile \033[0m: $result"
	fi
fi


############################################################
# I/O Performance
#


if [ $do_io = 1 ]
then
    echo ""
    echo -e "\033[35mFestplatten Benchmark\033[0m"
    echo ""

    echo -e "\033[1mErklaerung der einzelnen Ergebnisse\033[0m"
    echo "[1]: Synchroner Test / Blockgroesse 16k / 64.000 Durchgaenge"
    echo "[2]: Asynchroner Test / Blockgroesse 16k / 64.000 Durchgaenge"
    echo "[3]: Synchroner Test / Blockgroesse 64k / 16.000 Durchgaenge"
    echo "[4]: Asynchroner Test / Blockgroesse 64k / 16.000 Durchgaenge"
    echo ""
    io=$( ( dd if=/dev/zero of=io-test bs=16k count=64k conv=fdatasync && rm -f io-test ) 2>&1 | awk -Fs, '{io=$NF} END { print io}' )
    echo -e "\033[36mI/O Performance [1]:\033[0m $io"
    io=$( ( dd if=/dev/zero of=io-test bs=16k count=64k && rm -f io-test ) 2>&1 | awk -Fs, '{io=$NF} END { print io}' )
    echo -e "\033[36mI/O Performance [2]:\033[0m $io"
    io=$( ( dd if=/dev/zero of=io-test bs=64k count=16k conv=fdatasync && rm -f io-test ) 2>&1 | awk -Fs, '{io=$NF} END { print io}' )
    echo -e "\033[36mI/O Performance [3]:\033[0m $io"
    io=$( ( dd if=/dev/zero of=io-test bs=64k count=16k && rm -f io-test ) 2>&1 | awk -Fs, '{io=$NF} END { print io}' )
    echo -e "\033[36mI/O Performance [4]:\033[0m $io"
    echo ""
fi


############################################################
# CPU Benchmark
#


if [ $do_cpu = 1 ]
then
	
	echo ""
	echo -e "\033[35mCPU Benchmark\033[0m"
	time echo "scale=4000; a(1)*4" | erg=$(bc -l)
	echo ""
	echo ""
	
fi
