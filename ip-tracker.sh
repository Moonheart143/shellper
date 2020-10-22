#!/bin/sh
echo "Input your network (x.x.x)"
read NETWORK_ID
echo "Input your range (1 to 254)"
echo "Starting point"
read RANGE_FIRST
echo "Ending point"
read RANGE_LAST
echo "Input desired ammount of free IPs"
read BREAKING_POINT
echo "Input your list name (single work preferably)"
read LIST_NAME

touch "$LIST_NAME.txt"
echo "PINGING SESSION $(date)" >> "$LIST_NAME.txt"

while [ $RANGE_FIRST -le $RANGE_LAST ]
do
	ping -c 1 $NETWORK_ID.$RANGE_FIRST
	if [ $? -ne 0 ]
	then
		echo "$NETWORK_ID.$RANGE_FIRST" >> "$LIST_NAME.txt"
		BREAKING_POINT=$((BREAKING_POINT-1))
	fi
	RANGE_FIRST=$((RANGE_FIRST+1))
	if [ $BREAKING_POINT -eq 0 ]
	then break
	fi
	
done
