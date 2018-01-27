#!/bin/bash
# save it as /etc/profile.d/ssh-telegram.sh
# use jq to parse JSON from ipinfo.io
# get jq from here http://stedolan.github.io/jq/
USERID="364033552"
KEY="505966832:AAF61v4MWnGvnITWoQEwMZyMrQIAIUV5A6g"
TIMEOUT="10"
URL="https://api.telegram.org/bot$KEY/sendMessage"
DATE_EXEC="$(date "+%d %b %Y %H:%M")"
TMPFILE='/tmp/ipinfo-$DATE_EXEC.txt'
if [ -n "$SSH_CLIENT" ]; then
	curl http://ipinfo.io/$IP -s -o $TMPFILE
	COUNTRY=$(cat $TMPFILE | jq '.country' | sed 's/"//g')
	TEXT="$DATE_EXEC: Mocis has been installed in the $COUNTRY. One more we got."
	curl -s --max-time $TIMEOUT -d "chat_id=$USERID&disable_web_page_preview=1&text=$TEXT" $URL > /dev/null
	rm $TMPFILE
fi
