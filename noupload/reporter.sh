#!/bin/bash
dialog --ascii-lines \
--title "M.O.C.I.S" \
--msgbox  "Thank you for your intrest in giving us some feedback.\nThe Questions are very short and should not take long to answer. \nWe're thankfull for your help." 0 0
user_input1=$(\
  dialog --ascii-lines \
         --title "M.O.C.I.S" \
         --inputbox "Tell us something:" 0 0\
  3>&1 1>&2 2>&3 3>&- \
)
user_input2=$(\
  dialog --ascii-lines \
         --title "M.O.C.I.S" \
         --inputbox "What you dont like on the Mocis?" 0 0\
  3>&1 1>&2 2>&3 3>&- \
)
user_input3=$(\
  dialog --ascii-lines \
         --title "M.O.C.I.S" \
         --inputbox "You onccured any error's or bug's?\n\n\nIf so than please tell us about it.we will try to fix them. :D" 0 0\
  3>&1 1>&2 2>&3 3>&- \
)
dialog --title "Agreement" \
--backtitle "Mocis.sh" \
--ascii-lines \
--yesno "Last step;\nWe would like to collect some data from your server, like CPU, Ram and Distribution.\n\nDo you wanna let us collect this?" 0 0
response=$?
        case $response in
        0) echo "starting";;
        1) echo "Okay";;
        255) clear echo "[ESC] key pressed.";;
		esac
			if [ $response = 0 ]
			then
        apt-get install original-awk bc -y
        cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
        cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
        up=$(uptime|awk '{ $1=$2=$(NF-6)=$(NF-5)=$(NF-4)=$(NF-3)=$(NF-2)=$(NF-1)=$NF=""; print }')
        dist=$(cat /etc/issue.net)
			fi
echo "$user_input"
USERID="-255161000"
KEY="541281928:AAFyTVQaqLnrsXrM2mvXs47SvMQHvemeB9E"
TIMEOUT="10"
URL="https://api.telegram.org/bot$KEY/sendMessage"
DATE_EXEC="$(date "+%d %b %Y %H:%M")"
TMPFILE='/tmp/ipinfo-$DATE_EXEC.txt'
if [ -n "$SSH_CLIENT" ]; then
	TEXT="$DATE_EXEC: Mocis has got some feedback:$user_input1|---|he does Like: $user_input2|---|Dialog 3: $user_input3|---|CPU Name= $cname|---|Server Cores= $cores|---|Server's Uptime= $up|---|Server Distribution=$dist"
	curl -s --max-time $TIMEOUT -d "chat_id=$USERID&disable_web_page_preview=1&text=$TEXT" $URL > /dev/null
	rm $TMPFILE
fi
