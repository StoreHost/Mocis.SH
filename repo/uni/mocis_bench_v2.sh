#!/bin/bash
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
# In this file are all installation which                              #
# can be executed and installed under Debian 9 "Scretch".              #
# Please only with caution and extreme caution commands                #
# or change functions.                                                 #
########################################################################
########################################################################
#   Variables                                                          #
########################################################################
#######################
#   Core              #
#######################
overlay=0
language=0
LeckMich="False"
scriptname="mocis_bench_v2.sh"
path="/usr/local/bin"
updateurl="dev.mocis.sh/$scriptname"
installedname="mocis"
benchverion="0.010"
#######################
#   Function         #
#######################
do_network=0
do_io=0
do_cpu=0
ioFilename="/tmp/diskio.txt"
logfile="/tmp/benchmark_result.log"
ipv6=$( wget -qO- -t1 -T2 ipv6.icanhazip.com )
ipv4=$( wget -qO- -t1 -T2 ipv4.icanhazip.com )
#######################
#   Dialog            #
#######################
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
sysupdate="started"
systeminfo="preparing"
netspeed="classified"
datatest="classified"
cpubench="classified"
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
#   Local Installation                                                 #
########################################################################
function _installlocal() {
  if [ ! -f /usr/local/bin/mocis ]; then
    #_show_missing
    install $scriptname /usr/local/bin/mocis
    green "Installation Done"
  else
    _show_missing
    red "Removing old Installation"
    rm /usr/local/bin/mocis
    green "Install new Version"
    install $scriptname /usr/local/bin/mocis
    green "Installation Done"
    echo ""
    green "You can now start whit \"$installedname\" or \"$installedname -h\" to view all commands"
  fi
}
########################################################################
#   Spinner                                                            #
########################################################################
function _spin() {
  PID=$!
  i=1
  sp="/-\|"
  echo -n ' '
  while [ -d /proc/$PID ]
  do
    sleep 0.1
    printf "\b${sp:i++%${#sp}:1}"
  done
 }

########################################################################
# update                                                               #
########################################################################
function _update {
  rm $path/mocis
  wget -q $updateurl && bash $scriptname -i && mocis -v
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
#   Checks
########################################################################
if [ ! -f $ioFilename ]; then
    touch $ioFilename
else
  rm $ioFilename
fi
if [ ! -f $logfile ]; then
    touch $logfile
else
  rm $logfile
fi
if [[ -z $ipv6 ]]; then
  ipv6="not found"
fi
if [[ -z $ipv4 ]]; then
  ipv4="not found"
fi
if [[ -z $swap ]]; then
  swap="Empty"
fi
if [ ! -f /tmp/100MB.zip ]; then
  wget -q http://100mb.mocis.sh/100MB.zip -P /tmp/
else
  echo ""
fi
########################################################################
#   Binary Installer                                                   #
########################################################################
function _install_binarys {

green_ne "Install dialog: "  && $pmgr -y install dialog >/dev/null &&
RESULT=$?
if [ $RESULT -eq 0 ]; then
  yellowb  " [Ok]"
else
  redb " [failed]"
fi

green_ne "Install curl:   "  && $pmgr install curl >/dev/null &&
RESULT=$?
if [ $RESULT -eq 0 ]; then
yellowb  " [Ok]"
else
redb " [failed]"
fi

green_ne "Install wget:   "  && $pmgr -y install wget >/dev/null &&
RESULT=$?
if [ $RESULT -eq 0 ]; then
  yellowb  " [Ok]"
else
  redb " [failed]"
fi

green_ne "Install wput:   "  && $pmgr -y install wput >/dev/null &&
RESULT=$?
if [ $RESULT -eq 0 ]; then
  yellowb  " [Ok]"
else
  redb " [failed]"
fi

  green_ne "Install openssl:"  && $pmgr -y install openssl >/dev/null &&
RESULT=$?
if [ $RESULT -eq 0 ]; then
  yellowb  " [Ok]"
else
  redb " [failed]"
fi

green_ne "Install hdparm: "  && $pmgr -y install hdparm >/dev/null &&
RESULT=$?
if [ $RESULT -eq 0 ]; then
  yellowb  " [Ok]"
else
  redb " [failed]"
fi

green_ne "Install ioping: "  && $pmgr -y install ioping >/dev/null &&
RESULT=$?
if [ $RESULT -eq 0 ]; then
  yellowb  " [Ok]"
else
  redb " [failed]"
fi

green_ne "Install bc:     "  && $pmgr -y install bc >/dev/null &&
RESULT=$?
if [ $RESULT -eq 0 ]; then
  yellowb  " [Ok]"
else
  redb " [failed]"
fi
}
########################################################################
#   Next                                                               #
########################################################################
 _next() {
    printf "%-70s\n" "-" | sed 's/\s/-/g'
}
########################################################################
#   Save to File                                                       #
########################################################################
_log() {
  tee -a $logfile
}
########################################################################
#   Colors                                                            #
########################################################################
 end="\033[0m"
 black="\033[0;30m"
 blackb="\033[1;30m"
 white="\033[0;37m"
 whiteb="\033[1;37m"
 red="\033[0;31m"
 redb="\033[1;31m"
 green="\033[0;32m"
 greenb="\033[1;32m"
 yellow="\033[0;33m"
 yellowb="\033[1;33m"
 blue="\033[0;34m"
 blueb="\033[1;34m"
 purple="\033[0;35m"
 purpleb="\033[1;35m"
 lightblue="\033[0;36m"
 lightblueb="\033[1;36m"

 function black {
   echo -e "${black}${1}${end}"
 }

 function blackb {
   echo -e "${blackb}${1}${end}"
 }

 function white {
   echo -e "${white}${1}${end}"
 }

 function whiteb {
   echo -e "${whiteb}${1}${end}"
 }

 function red {
   echo -e "${red}${1}${end}"
 }

 function redb {
   echo -e "${redb}${1}${end}"
 }

 function green {
   echo -e "${green}${1}${end}"
 }

 function green_ne {
   echo -ne "${green}${1}${end}"
 }

 function greenb {
   echo -e "${greenb}${1}${end}"
 }

 function yellow {
   echo -e "${yellow}${1}${end}"
 }

 function yellowb {
   echo -e "${yellowb}${1}${end}"
 }

 function blue {
   echo -e "${blue}${1}${end}"
 }

 function blueb {
   echo -e "${blueb}${1}${end}"
 }

 function purple {
   echo -e "${purple}${1}${end}"
 }

 function purpleb {
   echo -e "${purpleb}${1}${end}"
 }

 function lightblue {
   echo -e "${lightblue}${1}${end}"
 }

 function lightblueb {
   echo -e "${lightblueb}${1}${end}"
 }

 function colors {
   black "black"
   blackb "blackb"
   white "white"
   whiteb "whiteb"
   red "red"
   redb "redb"
   green "green"
   greenb "greenb"
   yellow "yellow"
   yellowb "yellowb"
   blue "blue"
   blueb "blueb"
   purple "purple"
   purpleb "purpleb"
   lightblue "lightblue"
   lightblueb "lightblueb"
 }
 ########################################################################
 #   Dependencies                                                       #
 ########################################################################
 _installed_check(){
   _next
 	yellow "Lets look what is installed an what is needed"
 	type -p "openssl" >/dev/null && { ISopenssl=1;	green "openssl......installed (YES)"; }||{ red "openssl......installed (NO) (NOT NEEDED NOW)"; }
 	type -p "wget" >/dev/null && 	{ ISwget=1;		green "wget.........installed (YES)"; }||{ red "wget.........installed (NO)"; }
  type -p "wput" >/dev/null && 	{ ISwput=1;		green "wput.........installed (YES)"; }||{ red "wput.........installed (NO)"; }
  type -p "curl" >/dev/null && 	{ IScurl=1;		green "curl.........installed (YES)"; }||{ red "curl.........installed (NO)"; }
  type -p "dialog" >/dev/null && 	{ ISdialg=1;		green "dialog.......installed (YES)"; }||{ red "dialog.......installed (NO) (NOT NEEDED WHEN USING PROMT)"; }
 	type -p "ioping" >/dev/null &&	{ ISioping=1;	green "ioping.......installed (YES)"; }||{ red "ioping.......installed (NO)"; }
 	type -p "hdparm" >/dev/null &&	{ IShdparm=1;	green "hdparm.......installed (YES)"; }||{ red "hdparm.......installed (NO) (NOT NEEDED NOW)"; }
  type -p "bc" >/dev/null &&	{ ISbc=1;	green "bc...........installed (YES)"; }||{ red "bc.......installed (NO)"; }
 }
 _instaled_running_check(){
   type -p "openssl" >/dev/null && { ISopenssl=1; }
   type -p "wget" >/dev/null && 	{ ISwget=1; }
   type -p "wput" >/dev/null && 	{ ISwput=1; }
   type -p "curl" >/dev/null && 	{ IScurl=1;	}
   type -p "dialog" >/dev/null && 	{ ISdialg=1; }
   type -p "ioping" >/dev/null &&	{ ISioping=1; }
   type -p "hdparm" >/dev/null &&	{ IShdparm=1; }
   type -p "bc" >/dev/null &&	{ ISbc=1; }
 }
########################################################################
#   Dependencies Check                                                 #
########################################################################
function _show_missing() {
  _installed_check
  if [[ $ISopenssl = 1  ]]; then
    if [[ $ISwget = 1 ]]; then
      if [[ $IScurl = 1 ]]; then
        if [[ $ISdialg = 1 ]]; then
          if [[ $ISwput = 1 ]]; then
            if [[ $ISioping = 1 ]]; then
              if [[ $ISbc = 1 ]]; then
                if [[ $IShdparm = 1 ]]; then
                AllInstalled="True"
              else
                AllInstalled="False"
              fi
              else
                AllInstalled="False"
              fi
            else
              AllInstalled="False"
            fi
          else
            AllInstalled="False"
          fi
        else
          AllInstalled="False"
        fi
      else
        AllInstalled="False"
      fi
    else
      AllInstalled="False"
    fi
  else
    AllInstalled="False"
  fi
  if [[ $AllInstalled = True ]]; then
    _next
  fi
  if [[ $AllInstalled = "False" ]]; then
    green "Do you wish to install missing programs??"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) _install_binarys ; break;;
            No ) red "some scripts would not work!"; break;;
        esac
    done
  fi
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
#   Systeminformation                                                  #
########################################################################
function _systeminformation() {

    cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
    cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
    freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
    tram=$( free -m | awk 'NR==2 {print $2}' )
    swap=$( free -m | awk '/Swap/ {print $2}' )
    uswap=$( free -m | awk '/Swap/ {print $3}' )
    up=$(uptime|awk '{ $1=$2=$(NF-6)=$(NF-5)=$(NF-4)=$(NF-3)=$(NF-2)=$(NF-1)=$NF=""; print }')
    load_avarage=$( uptime | awk -F'[a-z]:' '{ print $2}' )
    vendor=$( cat /sys/class/dmi/id/chassis_vendor )

}
function _proc_define()
 {
		# Physical sockets
	sockets=$(grep "physical id" /proc/cpuinfo | sort -u | wc -l)

        # Physical Cores
        if [[ $CPU == "x86" ]] ; then
                procs=$(grep "physical id" /proc/cpuinfo | sort -u | wc -l)
                pcores=$(grep "cpu cores" /proc/cpuinfo |sort -u |cut -d":" -f2)
                cores=$((procs*pcores))
        elif [[ $CPU == "ARM" ]] ; then
                cores=$(grep "processor" /proc/cpuinfo | wc -l)
        else
                echo "Unknown CPU"
        fi

	# Virtual Cores (include threads)
	vcores=$(grep "processor" /proc/cpuinfo | wc -l)
	threads=$vcores
	nproc=$vcores

 }
function _get_opsy() {
    [ -f /etc/redhat-release ] && awk '{print ($1,$3~/^[0-9]/?$3:$4)}' /etc/redhat-release && return
    [ -f /etc/os-release ] && awk -F'[= "]' '/PRETTY_NAME/{print $3,$4,$5}' /etc/os-release && return
    [ -f /etc/lsb-release ] && awk -F'[="]+' '/DESCRIPTION/{print $2}' /etc/lsb-release && return
}
########################################################################
#   Networkspeedtest                                                   #
########################################################################
function _netspeeddialog() {
  until [ $netspeed -gt 0 ]
  do
    ((netspeed++))
    if [ $do_network = 1 ]; then

    #OVH (DE)
    if [ $network_1 = 1 ]
    then
      result1=$( wget -O /dev/null http://proof.ovh.net/files/100Mb.dat 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
      echo -e "\033[36mOVH(FR) - \033[33m100MB Testfile \033[0m: $result1" > /dev/null
      echo "OVH-FR%20100MB:%20$result1§" >> net.tmp
    fi

    #IP Projects (DE)
    if [ $network_2 = 1 ]
    then
      result2=$( wget -O /dev/null http://lg.ip-projects.de/100MB.test 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
      echo -e "\033[36mIP-Projects(DE) - \033[33m100MB Testfile \033[0m: $result2" > /dev/null
      echo "IP-Project-DE%20100MB:%20$result2§" >> net.tmp
    fi

    #combahton (DE)
    if [ $network_3 = 1 ]
    then
      result3=$( wget -O /dev/null http://lg.combahton.net/100MB.test 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
      echo -e "\033[36mcombahton(DE) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
      echo "combahton-DE%20100MB:%20$result§" >> net.tmp
    fi

    #meerfabig (DE)
    if [ $network_4 = 1 ]
    then
      result4=$( wget -O /dev/null http://mirror.meerfarbig.io/testfiles/1G 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
      echo -e "\033[36mmeerfabig(DE) - \033[33m1GB Testfile \033[0m: $result" > /dev/null
      echo "mmeerfabig-DE%201GB:%20$result§" >> net.tmp
    fi

    #myloc (DE)
    if [ $network_5 = 1 ]
    then
      result=$( wget -O /dev/null http://speed.myloc.de/100MB.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
      echo -e "\033[36mmyloc(DE) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
      echo "myloc-DE%20100MB:%20$result§" >> net.tmp
    fi

    #FSIT (CH)
    if [ $network_6 = 1 ]
    then
      result=$( wget -O /dev/null http://fsit.ch/speed/100mebibyte.dat 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
      echo -e "\033[36mFSIT(CH) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
      echo "FSIT-CH%20100MB:%20$result§" >> net.tmp
    fi

    #Leaseweb (DE)
    if [ $network_7 = 1 ]
    then
      result=$( wget -O /dev/null http://mirror.de.leaseweb.net/speedtest/100mb.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
      echo -e "\033[36mLeaseweb(DE) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
      echo "Leaseweb-DE%20100MB:%20$result§" >> net.tmp
    fi

    #Leaseweb (US)
    if [ $network_8 = 1 ]
    then
      result=$( wget -O /dev/null http://mirror.us.leaseweb.net/speedtest/100mb.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
      echo -e "\033[36mLeaseweb(US) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
      echo "Leaseweb-US%20100MB:%20$result§" >> net.tmp
    fi

    #Leaseweb (NL)
    if [ $network_9 = 1 ]
    then
      result=$( wget -O /dev/null http://mirror.nl.leaseweb.net/speedtest/100mb.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
      echo -e "\033[36mLeaseweb(NL) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
      echo "Leaseweb-NL%20100MB:%20$result§" >> net.tmp
    fi

    #Leaseweb (SG)
    if [ $network_10 = 1 ]
    then
      result=$( wget -O /dev/null http://mirror.sg.leaseweb.net/speedtest/100mb.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
      echo -e "\033[36mLeaseweb(SG) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
      echo "Leaseweb-SG%20100MB:%20$result§" >> net.tmp
    fi

    #Softlayer (NL)
    if [ $network_11 = 1 ]
    then
      result=$( wget -O /dev/null http://speedtest.ams01.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
      echo -e "\033[36mSoftlayer(NL) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
      echo "Softlayer-NL%20100MB:%20$result§" >> net.tmp
    fi

    #Softlayer (CN)
    if [ $network_12 = 1 ]
    then
      result=$( wget -O /dev/null http://speedtest.hkg02.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
      echo -e "\033[36mSoftlayer(CN) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
      echo "Softlayer-CN%20100MB:%20$result§" >> net.tmp
    fi

    #Softlayer (GB)
    if [ $network_13 = 1 ]
    then
      result=$( wget -O /dev/null http://speedtest.lon02.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
      echo -e "\033[36mSoftlayer(GB) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
      echo "Softlayer-GB%20100MB:%20$result§" >> net.tmp
    fi

    #Softlayer (JP)
    if [ $network_14 = 1 ]
    then
      result=$( wget -O /dev/null http://speedtest.tok02.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
      echo -e "\033[36mSoftlayer(JP) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
      echo "Softlayer-JP%20100MB:%20$result§" >> net.tmp
    fi

    #Softlayer (US)
    if [ $network_15 = 1 ]
    then
      result=$( wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
      echo -e "\033[36mSoftlayer(US) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
      echo "Softlayer-US%20100MB:%20$result§" >> net.tmp
    fi

    #Softlayer (CA)
    if [ $network_16 = 1 ]
    then
      result=$( wget -O /dev/null http://speedtest.tor01.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
      echo -e "\033[36mSoftlayer(CA) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
      echo "Softlayer-CA%20100MB:%20$result§" >> net.tmp
    fi

    #Softlayer (DE)
    if [ $network_17 = 1 ]
    then
      result=$( wget -O /dev/null http://speedtest.fra02.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
      echo -e "\033[36mSoftlayer(DE) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
      echo "Softlayer-DE%20100MB:%20$result§" >> net.tmp
    fi

    #EDIS (AT)
    if [ $network_18 = 1 ]
    then
      result=$( wget -O /dev/null http://at.edis.at/100MB.test 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
      echo -e "\033[36mEDIS(AT) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
      echo "EDIS-AT%20100MB:%20$result§" >> net.tmp
    fi

    #Linode Frankfurt (DE)
    if [ $network_19 = 1 ]
    then
      result=$( wget -O /dev/null http://speedtest.frankfurt.linode.com/100MB-frankfurt.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
      echo -e "\033[36mLinode Frankfurt(DE) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
      echo "Linode-DE%20100MB:%20$result§" >> net.tmp
    fi

    #CacheFly CDN
    if [ $network_20 = 1 ]
    then
      result=$( wget -O /dev/null http://cachefly.cachefly.net/100mb.test 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
      echo -e "\033[36mCacheFly CDN - \033[33m100MB Testfile \033[0m: $result" > /dev/null
      echo "ChacheFly-CND%20100MB:%20$result§" >> net.tmp
    fi

    #Cloudflare CDN
    if [ $network_21 = 1 ]
    then
      result=$( wget -O /dev/null http://fr-cdn.7x2.win/funny.jpg 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
      echo -e "\033[36mCloudflare CDN - \033[33m100MB Testfile \033[0m: $result" > /dev/null
      echo "Cloudflare-CDN%20100MB:%20$result§" >> net.tmp
    fi

    #Mocis 100MB
    if [ $network_22 = 1 ]; then
      result=$( wget -O /dev/null http://100mb.mocis.sh/100MB.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
      echo -e "\033[36mMocis DE - \033[33m100MB Testfile \033[0m: $result" > /dev/null
      echo "Mocis-DE%20100MB:%20$result§" >> net.tmp
    fi

    #Mocis 1GB
    if [ $network_23 = 1 ]; then
      result=$( wget -O /dev/null http://1gb.mocis.sh/1GB.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
      echo -e "\033[36mMocis DE - \033[33m1GB Testfile \033[0m: $result" > /dev/null
      echo "Mocis-DE%201GB:%20$result§" >> net.tmp
    fi
  fi

  done
}
function _speed_test_v4() {
    local speedtest=$(wget -4O /dev/null -T300 $1 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}')
    local nodeName=$2
    lightblue "${nodeName} ${speedtest}"
}
function _speed_v4() {
  _speed_test_v4 'http://cachefly.cachefly.net/100mb.test' 'CacheFly'
  _speed_test_v4 'http://fsit.ch/speed/100mebibyte.dat' 'Fsit, Zurich, CH'
  _speed_test_v4 'http://speedtest.tokyo.linode.com/100MB-tokyo.bin' 'Linode, Tokyo, JP'
  _speed_test_v4 'http://speedtest.singapore.linode.com/100MB-singapore.bin' 'Linode, Singapore, SG'
  _speed_test_v4 'http://speedtest.london.linode.com/100MB-london.bin' 'Linode, London, UK'
  _speed_test_v4 'http://speedtest.frankfurt.linode.com/100MB-frankfurt.bin' 'Linode, Frankfurt, DE'
  _speed_test_v4 'http://speedtest.dal05.softlayer.com/downloads/test100.zip' 'Softlayer, Dallas, TX'
  _speed_test_v4 'http://speedtest.sea01.softlayer.com/downloads/test100.zip' 'Softlayer, Seattle, WA'
  _speed_test_v4 'http://speedtest.fra02.softlayer.com/downloads/test100.zip' 'Softlayer, Frankfurt, DE'
  _speed_test_v4 'http://speedtest.sng01.softlayer.com/downloads/test100.zip' 'Softlayer, Singapore, SG'
  _speed_test_v4 'http://speedtest.hkg02.softlayer.com/downloads/test100.zip' 'Softlayer, HongKong, CN'
  _speed_test_v4 'http://100mb.mocis.sh/100MB.zip' 'StoreHost, Germany, DE'
}
function _speed_v4_EU() {
    _speed_test_v4 'http://cachefly.cachefly.net/100mb.test' 'CacheFly'
    _speed_test_v4 'http://fsit.ch/speed/100mebibyte.dat' 'Fsit, Zurich, CH'
    _speed_test_v4 'http://100mb.mocis.sh/100MB.zip' 'StoreHost, Germany, DE'
    _speed_test_v4 'http://speedtest.london.linode.com/100MB-london.bin' 'Linode, London, UK'
    _speed_test_v4 'http://speedtest.frankfurt.linode.com/100MB-frankfurt.bin' 'Linode, Frankfurt, DE'
    _speed_test_v4 'http://speedtest.fra02.softlayer.com/downloads/test100.zip' 'Softlayer, Frankfurt, DE'
}
function _speed_v4_US() {
  _speed_test_v4 'http://speedtest.singapore.linode.com/100MB-singapore.bin' 'Linode, Singapore, SG'
  _speed_test_v4 'http://speedtest.london.linode.com/100MB-london.bin' 'Linode, London, UK'
  _speed_test_v4 'http://speedtest.dal05.softlayer.com/downloads/test100.zip' 'Softlayer, Dallas, TX'
  _speed_test_v4 'http://speedtest.sea01.softlayer.com/downloads/test100.zip' 'Softlayer, Seattle, WA'
  _speed_test_v4 'http://speedtest.sng01.softlayer.com/downloads/test100.zip' 'Softlayer, Singapore, SG'
}
function _speed_test_v6() {
    local speedtest=$(wget -6O /dev/null -T300 $1 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}')
    local nodeName=$2
    lightblue "${nodeName} ${speedtest}"
}
function _speed_v6() {
    _speed_test_v6 'http://speedtest.atlanta.linode.com/100MB-atlanta.bin' 'Linode, Atlanta, GA'
    _speed_test_v6 'http://fsit.ch/speed/100mebibyte.dat' 'Fsit, Zurich, CH'
    _speed_test_v6 'http://speedtest.dallas.linode.com/100MB-dallas.bin' 'Linode, Dallas, TX'
    _speed_test_v6 'http://speedtest.newark.linode.com/100MB-newark.bin' 'Linode, Newark, NJ'
    _speed_test_v6 'http://speedtest.singapore.linode.com/100MB-singapore.bin' 'Linode, Singapore, SG'
    _speed_test_v6 'http://speedtest.tokyo.linode.com/100MB-tokyo.bin' 'Linode, Tokyo, JP'
    _speed_test_v6 'http://speedtest.sjc03.softlayer.com/downloads/test100.zip' 'Softlayer, San Jose, CA'
    _speed_test_v6 'http://speedtest.wdc01.softlayer.com/downloads/test100.zip' 'Softlayer, Washington, WA'
    _speed_test_v6 'http://speedtest.par01.softlayer.com/downloads/test100.zip' 'Softlayer, Paris, FR'
    _speed_test_v6 'http://speedtest.sng01.softlayer.com/downloads/test100.zip' 'Softlayer, Singapore, SG'
    _speed_test_v6 'http://speedtest.tok02.softlayer.com/downloads/test100.zip' 'Softlayer, Tokyo, JP'
}
#################################
#   Network upload speedtest    #
#################################
function _ul_speed_v4() {
  local speedtest=$(wput −−no−directories -u --basename=/tmp/ 100MB.zip /tmp/100MB.zip $1 2>&1 | awk ' {speed=$8} END {gsub(/\(|\)/,"",speed); print speed}')
  local nodeName=$2
  lightblue "${nodeName} ${speedtest}"
}
function _ul_v4() {
#  _ul_speed_v4  'ftp://mocis_public:public@88.99.220.42/' 'StoreHost, Germany, DE'
#  _ul_speed_v4  'ftp://speedtest.tele2.net/upload/' 'Tele2, Germany, DE'
  _ul_speed_v4  'ftp://ams-speedtest-1.tele2.net/upload/' 'Tele2, Netherlands, NL'
  _ul_speed_v4  'ftp://kst5-speedtest-1.tele2.net/upload/' 'Tele2, Sweden, SE'
}
########################################################################
#   API Calls                                                          #
########################################################################
function _geoip() {
  curl -s ip-api.com/ > /tmp/asnet
  isp=$( curl -s https://ipapi.co/$ipv4/org/ )
  asnetwork=$( curl -s https://ipapi.co/$ipv4/asn/ )
}
function _dl_speedtest_v4() {
  location=$( curl -s https://ipapi.co/$ipv4/country/ )
  if [[ $location == DE ]]; then
    _speed_v4_EU
  elif [[ $location == CH ]]; then
    _speed_v4_EU
  elif [[ $location == AT ]]; then
    _speed_v4_EU
  elif [[ $location == NL ]]; then
    _speed_v4_EU
  elif [[ $location == US ]]; then
    _speed_v4_US
  else
    _speed_v4
  fi
}
########################################################################
#   Storgage speed test                                                #
########################################################################
function _datatestdd() {
        io1=$( ( dd if=/dev/zero of=io-test bs=16k count=64k conv=fdatasync && rm -f io-test ) 2>&1 | awk -Fs, '{io=$NF} END { print io}' )
        echo -e "${yellow}I/O Performance 16K/64k [1]:${greenb} $io1"
        io2=$( ( dd if=/dev/zero of=io-test bs=16k count=64k && rm -f io-test ) 2>&1 | awk -Fs, '{io=$NF} END { print io}' )
        echo -e "${yellow}I/O Performance 16K/64k [2]:${greenb} $io2"
        io3=$( ( dd if=/dev/zero of=io-test bs=64k count=16k conv=fdatasync && rm -f io-test ) 2>&1 | awk -Fs, '{io=$NF} END { print io}' )
        echo -e "${yellow}I/O Performance 64K16k  [3]:${greenb} $io3"
        io4=$( ( dd if=/dev/zero of=io-test bs=64k count=16k && rm -f io-test ) 2>&1 | awk -Fs, '{io=$NF} END { print io}' )
        echo -e "${yellow}I/O Performance 64K/16k [4]:${greenb} $io4"
        red "Clear Cache..."
        /sbin/sysctl -w vm.drop_caches=3 > /dev/null
        io5=$( ( dd if=/dev/zero of=io-test bs=1M count=8k && rm -f io-test ) 2>&1 | awk -Fs, '{io=$NF} END { print io}' )
        echo -e "${yellow}I/O Performance 1M/8k Cleared Cache   [5]:${greenb} $io5"
        io6=$( ( dd if=/dev/zero of=io-test bs=1M count=16k && rm -f io-test ) 2>&1 | awk -Fs, '{io=$NF} END { print io}' )
        echo -e "${yellow}I/O Performance 1M/16k Cleared Cache  [6]:${greenb} $io6"
}
function _datatestdialogdd1() {
        io1=$( ( dd if=/dev/zero of=io-test bs=16k count=64k conv=fdatasync && rm -f io-test ) 2>&1 | awk -Fs, '{io=$NF} END { print io}' )
        echo -e "Performance [1]: $io1"
        io2=$( ( dd if=/dev/zero of=io-test bs=16k count=64k && rm -f io-test ) 2>&1 | awk -Fs, '{io=$NF} END { print io}' )
        echo -e "Performance [2]: $io2"
        io3=$( ( dd if=/dev/zero of=io-test bs=64k count=16k conv=fdatasync && rm -f io-test ) 2>&1 | awk -Fs, '{io=$NF} END { print io}' )
        echo -e "Performance [3]: $io3"
        io4=$( ( dd if=/dev/zero of=io-test bs=64k count=16k && rm -f io-test ) 2>&1 | awk -Fs, '{io=$NF} END { print io}' )
        echo -e "Performance [4]: $io4"

}
function _datatestdialogdd2() {
        echo "clearing cache"
        /sbin/sysctl -w vm.drop_caches=3 > /dev/null
        io5=$( ( dd if=/dev/zero of=io-test bs=1M count=8k && rm -f io-test ) 2>&1 | awk -Fs, '{io=$NF} END { print io}' )
        echo -e "Performance 1M/8k Cleared Cache   [5]: $io5"
        /sbin/sysctl -w vm.drop_caches=3 > /dev/null
        io6=$( ( dd if=/dev/zero of=io-test bs=1M count=16k && rm -f io-test ) 2>&1 | awk -Fs, '{io=$NF} END { print io}' )
        echo -e "Performance 1M/16k Cleared Cache  [6] $io6"
}
function _calc_disk() {
    local total_size=0
    local array=$@
    for size in ${array[@]}
    do
        [ "${size}" == "0" ] && size_t=0 || size_t=`echo ${size:0:${#size}-1}`
        [ "`echo ${size:(-1)}`" == "K" ] && size=0
        [ "`echo ${size:(-1)}`" == "M" ] && size=$( awk 'BEGIN{printf "%.1f", '$size_t' / 1024}' )
        [ "`echo ${size:(-1)}`" == "T" ] && size=$( awk 'BEGIN{printf "%.1f", '$size_t' * 1024}' )
        [ "`echo ${size:(-1)}`" == "G" ] && size=${size_t}
        total_size=$( awk 'BEGIN{printf "%.1f", '$total_size' + '$size'}' )
    done
    echo ${total_size}
}
function _iocalc() {
    if [[ $ISioping = 1 ]]; then
      ioping -c 10 /tmp > $ioFilename
      sed '11,15d' $ioFilename && _next
      rm $ioFilename
    fi
  return 0
}
function _IOping() {
  _iocalc
}
########################################################################
#   CPU Test                                                           #
########################################################################
function _cputest() {
  green "CPU Benchmark"
  if [[ -z $ISbc ]]; then
    red "not performed tests.... test needs bc installed"
  else
    time echo "scale=4000; a(1)*4" | erg=$(bc -l)
    _next
  fi
}
function _cpursa() {
  yellow "Test openSSL speeds (openssl signatures speed)...."
  if [[ -z $ISopenssl ]]; then
	   red "not performed tests.... test needs openssl installed"
  else
	openssl speed rsa | _log
fi
}
########################################################################
#   CURL Transfer                                                      #
########################################################################
function _upload() {
  curlresponse=$(curl https://api.tjbn.de/imggen/?text=This%20Benchmark%20is%20generated%20by%20Mocis\.sh§§'*'CPU-Benchmark§§Processor:%20$CPUNAME§Cores:%20$cores§MHz:%20$CPUFREQ§Memory:%20$tram%20MB§CPU-bench:%20$cpubenchresult§§'*'Network%20Benchmark§§$networking§'*'Data%20Benchmark§§$IOTEST1§$IOTEST2§$IOTEST3§$IOTEST4) > /dev/null
}
########################################################################
#   Menu related !do not touch!                                        #
########################################################################
opsy=$( _get_opsy )
kernel=$( uname -r )
disk_size1=($( LANG=C df -hPl | grep -wvE '\-|none|tmpfs|devtmpfs|by-uuid|chroot|Filesystem' | awk '{print $2}' ))
disk_size2=($( LANG=C df -hPl | grep -wvE '\-|none|tmpfs|devtmpfs|by-uuid|chroot|Filesystem' | awk '{print $3}' ))
disk_total_size=$( _calc_disk ${disk_size1[@]} )
disk_used_size=$( _calc_disk ${disk_size2[@]} )
########################################################################
#   Dialog Menu                                                        #
########################################################################
function _dialogmsgbox() {
  dialog --clear --backtitle "[ M.O.C.I.S ]" \
  --title "[ Benchmark Suite ]" --no-lines \
  --msgbox "$DIALOGMSGBOX" 0 0
}
function _dialogyn() {
  dialog --clear --backtitle "[ M.O.C.I.S ]" \
  --title "[ Benchmark Suite ]" --no-lines \
  --yesno "$YNMSG" 0 0
}
function _dialoggauge() {
  (
      items=2
      processed=0
      while [ $processed -le $items ]; do
          pct=$(( $processed * 100 / $items ))
          echo "XXX"
          apt-get update -y > /dev/null && echo "Updating the System"
          processed=$((processed+1))
          apt-get upgrade -y > /dev/null && echo "Upgrading the System"
          processed=$((processed+1))
          echo "XXX"
          echo "$pct"
          sleep 0.1
      done
  ) | dialog --title "[ Benchmark Suite ]" --backtitle "[ M.O.C.I.S ]" --no-lines --gauge "Wait please..." 10 60 0
}
function _dialoginfo() {
  dialog --clear --backtitle "[ M.O.C.I.S ]" \
  --title "[ Benchmark Suite ]" --no-lines \
  --info "$INFOMSG" 0 0
}
function _dialogmenu() {
  DIALOGMSGBOX="There is only about 10% implemted!! We recommend the Shell version!!" && _dialogmsgbox
  DIALOGMSGBOX="Hello and Welcome to the Benchmark Suite from Mocis." && _dialogmsgbox
  _systeminformation
  DIALOGMSGBOX="CPU Name: $cname \nDistro: $opsy \nKernel: $kernel \nUptime: $up \nCPU Cores: $cores \nCPU Freq: $freq \nRAM: $tram MB \nSwap: $swap" && _dialogmsgbox
  DIALOGMSGBOX="Total Disk space: $disk_total_size GB \nTotal Disk Used: $disk_used_size GB" && _dialogmsgbox
  (   items=2
      processed=0
      while [ $processed -le $items ]; do
          pct=$(( $processed * 100 / $items ))
          echo "XXX"
          processed=$((processed+1))
          echo "XXX"
          processed=$((processed+1))
          _datatestdialogdd1
          processed=$((processed+1))
          _datatestdialogdd2
          echo "XXX"
          echo "$pct"
      done
  ) | dialog --title "[ Benchmark Suite ]" --backtitle "[ M.O.C.I.S ]" --no-lines --clear --gauge "Wait please..." 20 60 0 && sleep 2
  DIALOGMSGBOX="Disk Latency ${_iocalc}" && _dialogmsgbox
}
########################################################################
#   Command Promt Menu                                                 #
########################################################################
function _commandmenu() {
  clear
  _printPoweredBy | _log
  echo " "  | _log
  green "Gathering system information" | _log
  _next | _log
  _systeminformation
  _geoip
  yellow "CPU Name   ${greenb}   $cname" | _log
  yellow "Distribution: ${greenb} $opsy" | _log
  yellow "Kernel:      ${greenb}  $kernel" | _log
  yellow "Uptime:    ${greenb}  $up" | _log
  yellow "Load:      ${greenb}   $load_avarage" | _log
  yellow "CPU Cores:  ${greenb}   $cores" | _log
  yellow "CPU Freq:  ${greenb}   $freq MHz" | _log
  yellow "RAM:       ${greenb}    $tram MB" | _log
  yellow "Swap:     ${greenb}     $swap MB" | _log
  yellow "Swap used:  ${greenb}   $uswap MB" | _log
  yellow "Vendor:     ${greenb}   $vendor" | _log
  yellow "IPv4          ${greenb} $ipv4"
  yellow "IPv6          ${greenb} $ipv6"
  yellow "ISP          ${greenb}  $isp" | _log
  yellow "ASNetwork:   ${greenb}  $asnetwork" | _log
  ###################################################################### Diskspace
  echo " " | _log
  green "Calc Diskspace" | _log
  _next
  yellow "Total Disk Space:${greenb} $disk_total_size ${yellow}GB ${PLAIN}" | _log
  yellow "Total Disk Used:${greenb}  $disk_used_size ${yellow}GB Used" | _log
  echo " "
  green "Disk Latency" && _next | _log
  _IOping & _spin | _log
  green "Disk Write Read test" && _next | _log
  _datatestdd | _log
  ###################################################################### RSA Test
  echo " "
  green "Performing RSA test" | _log
  _next
  #_cpursa | _log
  red "We skip this for now...." | _log
  #_cputest | _log
  ###################################################################### IPv4 Speedtest
  echo " "
  green "Performing IPv4 Downloadtest" && _next | _log
  lightblue "Node Name | Download Speed" | _log
  _dl_speedtest_v4 | _log
  _next
  echo " "
  if [[ "$ISwput" != "" ]]; then
    green "Performing IPv4 Uploadtest" && _next | _log
    lightblue "Node Name | Upload Speed" | _log
    _ul_v4 | _log
    _next
  else
    red "wput is not installed, skipping..."
  fi
  ###################################################################### IPv6 Speedtest
  if [[ "$ipv6" = "not found" ]]; then
    red "Skipping no address found"
  else
      echo " "
      green "Performing IPv6 Downloadtest" && _next | _log
      lightblue "Node Name | Download Speed" | _log
      _speed_v6 && _next | _log
  fi
  echo " "
  red "A copy of the benchmark has been saved under $logfile"
  green "Thank you for using our Benchmark script."
  lightblueb "Twitter us @mocis_sh or @Store_Host"
}
########################################################################
# The command line help                                                #
########################################################################
_display_help() {
    echo "Usage: $0 " >&2
    _printPoweredBy
    _helptxt
    echo
    echo "   -c,        --command               Command Line Benchmark"
    echo "   -d,        --dialog                Dialog Benchmark "
    echo "   -fs,       --free-space            Calculate the free Space on the Server"
    echo "   -h,        --help                  Help"
    echo "   -i,        --install               Install to System"
    echo "   -m,        --missing               Shows missing Dependencies"
    echo "   -speed-v4, --speed-test-v4         Performing IPv4 Speedtest"
    echo "   -speed-v6, --speed-test-v6         Performing IPv6 Speedtest"
    echo "   -u,        --update                Update to the newest Version"
    echo "              --upload-test-v4        Performing IPv4 Uploadspeedtest"
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

      -m | --missing)
          _show_missing
          exit 0
          ;;
      -c | --command)
          _instaled_running_check
          _commandmenu
          exit 0
          ;;

      -d | --dialog)
          _dialogmenu
          exit 0
          ;;

      -fs | --free-space)
          green "Calc Diskspace" | _log
          #_calc_disk
          _next
          yellow "Total Disk Space:${greenb} $disk_total_size ${yellow}GB ${PLAIN}"
          yellow "Total Disk Used:${greenb}  $disk_used_size ${yellow}GB Used"
          exit 0
          ;;


      -speed-v4 | --speed-test-v4)
          green "Performing IPv4 Downloadtest" | _next
          lightblue "Node Name | Download Speed"
          _dl_speedtest_v4
          exit 0
          ;;

      -speed-v6 | --speed-test-v6)
          if [[ "$ipv6" != "" ]]; then
              echo " "
              green "Performing IPv6 Downloadtest" & _next
              lightblue "Node Name | Download Speed"
              _speed_v6 & _next
            else
              red "we cant find any IPv6 address on this System"
          fi
          exit 0
          ;;


      -sys | --systeminfo)
          green "Gathering system information" | _log
          _next | _log
          _systeminformation
          _geoip
          yellow "CPU Name   ${greenb}   $cname" | _log
          yellow "Distribution: ${greenb} $opsy" | _log
          yellow "Kernel:      ${greenb}  $kernel" | _log
          yellow "Uptime:    ${greenb}  $up" | _log
          yellow "Load:      ${greenb}   $load_avarage" | _log
          yellow "CPU Cores:  ${greenb}   $cores" | _log
          yellow "CPU Freq:  ${greenb}   $freq MHz" | _log
          yellow "RAM:       ${greenb}    $tram MB" | _log
          yellow "Swap:     ${greenb}     $swap MB" | _log
          yellow "Swap used:  ${greenb}   $uswap MB" | _log
          yellow "Vendor:     ${greenb}   $vendor" | _log
          yellow "IPv4          ${greenb} $ipv4"
          yellow "IPv6          ${greenb} $ipv6"
          yellow "ISP          ${greenb}  $isp" | _log
          yellow "ASNetwork:   ${greenb}  $asnetwork" | _log
          exit 0
          ;;

      -u | --update)
          green "getting the newest version..."
          _update
          exit 0
          ;;

      --upload-test-v4)
          green "Performing IPv4 Uploadtest" && _next
          lightblue "Node Name | Upload Speed"
          echo ""
          _ul_v4
          exit 0
          ;;

      -v | --version)
          echo "Version $benchverion is installed"
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
 _printPoweredBy
 green "Welcome to the Benchmark"
# _installed_check
_show_missing
green "Do you want continue on command promt or dialog?"
 select yn in "Shell" "Dialog" "Exit"; do
     case $yn in
         Shell ) overlay=1 ; break;;
         Dialog ) overlay=2; break;;
         Exit ) red "Stopping!!" ; exit;;
     esac
 done
 _next
if [[ $overlay = 1 ]]; then
  green "continue in the commandpromt"
  clear
  _commandmenu
elif [[ $overlay = 2 ]]; then
  clear
  _dialogmenu
else
  red "That went wrong! Cancel Benchmark!"
fi
