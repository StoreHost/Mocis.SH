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
#   Translation 													   #
########################################################################
if [[ ${LANG:0:2} == "de" ]]; then
cu_gateringsysinfo="Sammel System Informationen"
cu_uptime="Online seit"
cu_calcdisk="Kalkuliere Festplatten Speicher"
cu_totalfree="Totaler Speicherplatz"
cu_totalused="Aktuell verbraucher Speicher"
cu_whatsinstalled="Schauen wir, was an Software Fehlt"
cu_openssl_in="openssl....installiert (Ja)"
cu_openssl_unin="openssl.....installiert (Nein)"
cu_wget_in="wget.......installiert (Ja)"
cu_wget_unin="wget.......installiert (Nein)"
cu_wput_in="wput.......installiert (Ja)"
cu_wput_unin="wput.......installiert (Ja)"
cu_curl_in="curl.......installiert (Ja)"
cu_curl_unin="curl.......installiert (Nein)"
cu_dialog_in="dialog.....installiert (Ja)"
cu_dialog_unin="dialog.....installiert (Nein)"
cu_iop_in="ioping.....installiert (Ja)"
cu_iop_unin="ioping.....installiert (Nein)"
cu_hdparm_in="hdparm.....installiert (Ja)"
cu_hdparm_unin="hdparm.....installiert (Nein)"
cu_bc_in="bc.........installiert (Ja)"
cu_bc_unin="bc.........installiert (Nein)"
cu_welcome="Willkommen zum Mocis Benchmark"
cu_install_promt="Moechten Sie fortfahren?"
cu_in_missing="Moechten Sie die fehlenden Programme Installieren?"
cu_in_wouldnt_work="Einige Abfragen werden nicht Funktionieren"
cu_unknown="Unbekannter"
cu_cputest="BC ist nicht Installiert... Ueberspringe..."
cu_test_openssl="OpenSSL Speedtest (Signaturspeedtest)..."
cu_test_not_performed="OpenSSl ist nicht installiert... Ueberspringe..."
cu_cpu_calc="Starte Rechnungs Test"
cu_dl_start="Starte IPv4 Downloadtest"
cu_up_start="Starte IPv4 Uploadtest"
cu_mis_wput="WPUT ist nicht installiert... Ueberspringe..."
cu_no_ipv6="Keine IPv6 Adresse gefunden... Ueberspringe..."
cu_start_ipv6="Starte IPv6 Downloadtest"
cu_yes="Ja"
cu_no="Nein"
cu_failed="Felgeschlagen"
cu_start="Start Benchmark"
cu_free_space="Freier Speicherplatz anzeigen"
cu_help="Hilfe"
cu_install="Lokal installieren"
cu_show_missing="Zeige fehlende Programme an"
else 
cu_gateringsysinfo="Gathering System information"
cu_calcdisk="Calculate Diskspace"
cu_uptime="uptime"
cu_totalfree="Total Disk Space   "
cu_totalused="Total used Diskspace"
cu_whatsinstalled="Lets look what is installed an what is needed"
cu_openssl_in="openssl......installed (YES)"
cu_openssl_unin="openssl......installed (NO)"
cu_wget_in="wget.........installed (YES)"
cu_wget_unin="wget.........installed (NO)"
cu_wput_in="wput.........installed (YES)"
cu_wput_unin="wput.........installed (NO)"
cu_curl_in="curl.........installed (YES)"
cu_curl_unin="curl.........installed (NO)"
cu_dialog_in="dialog.......installed (YES)"
cu_dialog_unin="dialog.......installed (NO)"
cu_iop_in="ioping.......installed (YES)"
cu_iop_unin="ioping.......installed (NO)"
cu_hdparm_in="hdparm.......installed (YES)"
cu_hdparm_unin="hdparm.......installed (NO)"
cu_bc_in="bc...........installed (YES)"
cu_bc_unin="bc...........installed (NO)"
cu_welcome="Welcome to the Mocis Benchmark"
cu_install_promt="Do you want to continue?"
cu_in_missing="Do you wish to install missing programs?"
cu_in_wouldnt_work="some scripts would not work!"
cu_unknown="Unknown"
cu_cputest="not performed tests.... test needs bc installed"
cu_test_openssl="Test openSSL speeds (openssl signatures speed)..."
cu_test_not_performed="not performed tests.... test needs openssl installed"
cu_cpu_calc="Performing CPU Calc test"
cu_dl_start="Performing IPv4 Downloadtest"
cu_up_start="Performing IPv4 Uploadtest"
cu_mis_wput="wput is not installed, skipping..."
cu_no_ipv6="No IPv6 address found... skipping..."
cu_start_ipv6="Performing IPv6 Downloadtest"
cu_yes="Yes"
cu_no="No"
cu_failed="failed"
cu_start="Start Benchmarking"
cu_free_space="Show free space"
cu_help="Help"
cu_install="Install to System"
cu_show_missing="Shows missing Dependencies"
fi
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
  redb " [$cu_failed]"
fi

green_ne "Install curl:   "  && $pmgr -y install curl >/dev/null &&
RESULT=$?
if [ $RESULT -eq 0 ]; then
yellowb  " [Ok]"
else
redb " [$cu_failed]"
fi

green_ne "Install wget:   "  && $pmgr -y install wget >/dev/null &&
RESULT=$?
if [ $RESULT -eq 0 ]; then
  yellowb  " [Ok]"
else
  redb " [$cu_failed]"
fi

green_ne "Install wput:   "  && $pmgr -y install wput >/dev/null &&
RESULT=$?
if [ $RESULT -eq 0 ]; then
  yellowb  " [Ok]"
else
  redb " [$cu_failed]"
fi

  green_ne "Install openssl:"  && $pmgr -y install openssl >/dev/null &&
RESULT=$?
if [ $RESULT -eq 0 ]; then
  yellowb  " [Ok]"
else
  redb " [$cu_failed]"
fi

green_ne "Install hdparm: "  && $pmgr -y install hdparm >/dev/null &&
RESULT=$?
if [ $RESULT -eq 0 ]; then
  yellowb  " [Ok]"
else
  redb " [$cu_failed]"
fi

green_ne "Install ioping: "  && $pmgr -y install ioping >/dev/null &&
RESULT=$?
if [ $RESULT -eq 0 ]; then
  yellowb  " [Ok]"
else
  redb " [$cu_failed]"
fi

green_ne "Install bc:     "  && $pmgr -y install bc >/dev/null &&
RESULT=$?
if [ $RESULT -eq 0 ]; then
  yellowb  " [Ok]"
else
  redb " [$cu_failed]"
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
 	yellow "$cu_whatsinstalled"
 	type -p "openssl" >/dev/null && { ISopenssl=1;	green "$cu_openssl_in"; }||{ red "$cu_openssl_unin"; }
 	type -p "wget" >/dev/null && 	{ ISwget=1;		green "$cu_wget_in"; }||{ red "$cu_wget_unin"; }
    type -p "wput" >/dev/null && 	{ ISwput=1;		green "$cu_wput_in"; }||{ red "$cu_wput_unin"; }
    type -p "curl" >/dev/null && 	{ IScurl=1;		green "$cu_curl_in"; }||{ red "$cu_curl_unin"; }
    type -p "dialog" >/dev/null && 	{ ISdialg=1;		green "$cu_dialog_in"; }||{ red "$cu_dialog_unin"; }
 	type -p "ioping" >/dev/null &&	{ ISioping=1;	green "$cu_iop_in"; }||{ red "$cu_iop_unin"; }
 	type -p "hdparm" >/dev/null &&	{ IShdparm=1;	green "$cu_hdparm_in"; }||{ red "$cu_hdparm_unin"; }
    type -p "bc" >/dev/null &&	{ ISbc=1;	green "$cu_bc_in"; }||{ red "$cu_bc_unin"; }
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
    green "$cu_in_missing"
    select yn in "$cu_yes" "$cu_no"; do
        case $yn in
            $cu_yes ) _install_binarys ; break;;
            $cu_no ) red "$cu_in_wouldnt_work"; break;;
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
                echo "cu_unknown"
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
function _speed_test_v4() {
    local speedtest=$(wget -4O /dev/null -T300 $1 2>&1 | awk '/\/dev\/null/ {speed=$3 $4 } END {gsub(/\(|\)/,"",speed); print speed}')
    local nodeName=$2
    if [[ $nodeName = "CacheFly" ]] ; then
	   trail="\033[1;32m\033[0;31m..........................\033[0;35m"
	elif [[ $nodeName = "Fsit, Zurich, CH" ]] ; then
	   trail="\033[1;32m\033[0;31m..................\033[0;35m"
	elif [[ $nodeName = "StoreHost, Germany, DE" ]] ; then
	   trail="\033[1;32m\033[0;31m............\033[0;35m"
	elif [[ $nodeName = "Linode, London, UK" ]] ; then
	   trail="\033[1;32m\033[0;31m................\033[0;35m"
	elif [[ $nodeName = "Linode, Frankfurt, DE" ]] ; then
	   trail="\033[1;32m\033[0;31m.............\033[0;35m"
	elif [[ $nodeName = "Softlayer, Frankfurt, DE" ]] ; then
	   trail="\033[1;32m\033[0;31m..........\033[0;35m"
	else
	   trail=""
	fi
	lightblue "${nodeName} ${trail} ${speedtest}"
	
}
function _speed_v4() {
  _speed_test_v4 'http://cachefly.cachefly.net/100mb.test' 'CacheFly' 
  _speed_test_v4 'http://fsit.ch/speed/100mebibyte.dat' 'Fsit, Zurich,       CH'
  _speed_test_v4 'http://speedtest.tokyo.linode.com/100MB-tokyo.bin' 'Linode, Tokyo, JP'
  _speed_test_v4 'http://speedtest.singapore.linode.com/100MB-singapore.bin' 'Linode, Singapore, SG'
  _speed_test_v4 'http://speedtest.london.linode.com/100MB-london.bin' 'Linode, London, UK'
  _speed_test_v4 'http://speedtest.frankfurt.linode.com/100MB-frankfurt.bin' 'Linode, Frankfurt, DE'
  _speed_test_v4 'http://speedtest.dal05.softlayer.com/downloads/test100.zip' 'Softlayer, Dallas,    TX'
  _speed_test_v4 'http://speedtest.sea01.softlayer.com/downloads/test100.zip' 'Softlayer, Seattle,   WA'
  _speed_test_v4 'http://speedtest.fra02.softlayer.com/downloads/test100.zip' 'Softlayer, Frankfurt, DE'
  _speed_test_v4 'http://speedtest.sng01.softlayer.com/downloads/test100.zip' 'Softlayer, Singapore, SG'
  _speed_test_v4 'http://speedtest.hkg02.softlayer.com/downloads/test100.zip' 'Softlayer, HongKong,  CN'
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
    lightblue "${nodeName}             ${speedtest}"
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
        io1=$( ( dd if=/dev/zero of=./largefile bs=512k count=1024 conv=fdatasync) 2>&1 | awk -Fs, '{io=$NF} END { print io}' )
        echo -e "${yellow}I/O Performance 512kb/1K[1]:${greenb} $io1"
        io2=$( ( dd if=/dev/zero of=io-test bs=16k count=64k && rm -f io-test conv=fdatasync) 2>&1 | awk -Fs, '{io=$NF} END { print io}' )
        echo -e "${yellow}I/O Performance 16Kb/64k [2]:${greenb} $io2"
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
    red "$cu_cputest"
  else
    time echo "scale=2000; a(1)*4" | erg=$(bc -l)
    _next
  fi
}
function _cpursa() {
  yellow "cu_test_openssl"
  if [[ -z $ISopenssl ]]; then
	   red "cu_test_not_performed"
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
#   Command Promt Menu                                                 #
########################################################################
function _commandmenu() {
  clear
  _printPoweredBy | _log
  echo " "  | _log
  green "$gateringsysinfo" | _log
  _next | _log
  _systeminformation
  _geoip
  yellow "CPU Name   ${greenb}    $cname" | _log
  yellow "Distribution: ${greenb}  $opsy" | _log
  yellow "Kernel:      ${greenb}   $kernel" | _log
  yellow "$cu_uptime:${greenb}   $up" | _log
  yellow "Load:      ${greenb}    $load_avarage" | _log
  yellow "CPU Cores:  ${greenb}    $cores" | _log
  yellow "CPU Freq:  ${greenb}    $freq MHz" | _log
  yellow "RAM:       ${greenb}     $tram MB" | _log
  yellow "Swap:     ${greenb}      $swap MB" | _log
  yellow "Swap used:  ${greenb}    $uswap MB" | _log
  yellow "Vendor:     ${greenb}    $vendor" | _log
  yellow "IPv4          ${greenb}  $ipv4"
  yellow "IPv6          ${greenb}  $ipv6"
  yellow "ISP          ${greenb}   $isp" | _log
  yellow "ASNetwork:   ${greenb}   $asnetwork" | _log
  ###################################################################### Diskspace
  echo " " | _log
  green "$cu_calcdisk" | _log
  _next
  yellow "$cu_totalfree:${greenb} $disk_total_size ${yellow}GB ${PLAIN}" | _log
  yellow "$cu_totalused:${greenb}  $disk_used_size ${yellow}GB Used" | _log
  echo " "
  green "Disk Latency" && _next | _log
  _IOping & _spin | _log
  green "Disk Write Read test" && _next | _log
  _datatestdd | _log
  ###################################################################### RSA Test
  echo " "
  _next
  green "$cu_cpu_calc" | _log
  _cputest | _log
  ###################################################################### IPv4 Speedtest
  echo " "
  green "$cu_dl_start" && _next | _log
  lightblue "Node Name | Download Speed" | _log
  _dl_speedtest_v4 | _log
  _next
  echo " "
  if [[ "$ISwput" != "" ]]; then
    green "$cu_up_start" && _next | _log
    lightblue "Node Name | Upload Speed" | _log
    _ul_v4 | _log
    _next
  else
    red "$cu_mis_wput"
  fi
  ###################################################################### IPv6 Speedtest
  if [[ "$ipv6" = "not found" ]]; then
    red "$cu_no_ipv6"
  else
      echo " "
      green "$cu_start_ipv6" && _next | _log
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
    echo "   -s,        --start                 $cu_start"
    echo "   -fs,       --free-space            $cu_free_space"
    echo "   -h,        --help                  $cu_help"
    echo "   -i,        --install               $cu_install"
    echo "   -m,        --missing               $cu_show_missing"
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
      -s | --start)
          _instaled_running_check
          _commandmenu
          exit 0
          ;;

      -fs | --free-space)
          green "$cu_calcdisk" | _log
          #_calc_disk
          _next
          yellow "$cu_totalfree:${greenb} $disk_total_size ${yellow}GB ${PLAIN}"
          yellow "$cu_totalused:${greenb}  $disk_used_size ${yellow}GB"
          exit 0
          ;;


      -speed-v4 | --speed-test-v4)
          green "$cu_dl_start" | _next
          lightblue "Node Name | Download Speed"
          _dl_speedtest_v4
          exit 0
          ;;

      -speed-v6 | --speed-test-v6)
          if [[ "$ipv6" != "" ]]; then
              echo " "
              green "$cu_start_ipv6" & _next
              lightblue "Node Name | Download Speed"
              _speed_v6 & _next
            else
              red "$cu_no_ipv6"
          fi
          exit 0
          ;;


      -sys | --systeminfo)
          green "$gateringsysinfo" | _log
          _next | _log
          _systeminformation
          _geoip
          yellow "CPU Name:   ${greenb}  $cname" | _log
          yellow "Distribution: ${greenb} $opsy" | _log
          yellow "Kernel:      ${greenb}  $kernel" | _log
          yellow "$cu_uptime:${greenb} $up" | _log
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
          green "$cu_up_start" && _next
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
 green "$cu_welcome"
# _installed_check
_show_missing
green "$cu_install_promt"
 select yn in "$cu_yes" "$cu_no" "Exit"; do
     case $yn in
         $cu_yes ) overlay=1 ; break;;
         $cu_no ) exit;;
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
