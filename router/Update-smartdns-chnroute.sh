#! /bin/sh
#
# Update Chnroute

INPUT_FILE=$(mktemp)
CONFIG_FLODER="/etc/smartdns"
WHITELIST="$CONFIG_FLODER/whitelist-chnroute.conf"
BLACKLIST="$CONFIG_FLODER/blacklist-chnroute.conf"
URL="https://ispip.clang.cn/all_cn.txt"

if [ "$1" != "" ]; then
	URL="$1"
fi

wget -O $INPUT_FILE $URL
if [ $? -eq 0 ]
then
	echo "Download successful, updating..."
  mkdir -p $CONFIG_FLODER
	cat /dev/null > $WHITELIST
  cat /dev/null > $BLACKLIST

	cat $INPUT_FILE | while read line
	do
		echo "whitelist-ip $line" >> $WHITELIST
		echo "blacklist-ip $line" >> $BLACKLIST
	done
fi

rm $INPUT_FILE