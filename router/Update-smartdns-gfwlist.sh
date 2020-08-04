#! /bin/sh
#
# Update GFWList

INPUT_FILE=$(mktemp)
CONFIG_FLODER="/etc/smartdns"
OUTPUT_FILE="$CONFIG_FLODER/gfwlist.conf"
URL="https://cokebar.github.io/gfwlist2dnsmasq/gfwlist_domain.txt"

PROXYDNS_NAME="foreign"

if [ "$1" != "" ]; then
	PROXYDNS_NAME="$1"
fi

wget -O $INPUT_FILE $URL 
if [ $? -eq 0 ]
then
	echo "Download successful, updating..."
  mkdir -p $CONFIG_FLODER
	cat /dev/null > $OUTPUT_FILE

	cat $INPUT_FILE | while read line
	do
		echo "nameserver /$line/$PROXYDNS_NAME" >> $OUTPUT_FILE
	done
fi

rm $INPUT_FILE