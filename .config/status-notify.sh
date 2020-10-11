
#volstat=$(amixer get Master | grep %)
#volstat=$(amixer -c 2 get Speaker | grep % | grep Left)
pulse=true

if [ "$(lsblk | grep -E '(sdb|sdc|sdd)')" != "" ]
then
    usbicon="禍"
fi


if [ $pulse ]
	then
	vol=$(pamixer --get-volume)
	if [ "$vol" -gt "70" ]; then
		volicon="墳"
	elif [ "$vol" -lt "30" ]; then
		volicon="奄"
	else
		volicon="奔"
	fi
	if [ "$(pamixer --get-mute)" = "true" ]
		then
		volicon="婢"
	fi
elif [ "$(echo "$volstat" | grep off)" = "" ]
		then
    	vol=$(echo "$volstat" | grep -o "\[[0-9]\+%\]" | sed 's/[^0-9]*//g')
		if [ "$vol" -gt "70" ]; then
			volicon="墳"
		elif [ "$vol" -lt "30" ]; then
			volicon="奄"
		else
			volicon="奔"
		fi
else
    	volicon="婢"
fi


if [ "$(cat /sys/class/net/wlp8s0/operstate)" = "down" ]
then
    wifiicon="睊"
else
    wifiicon="直"
fi



notify-send  " $usbicon $volicon$vol% $wifiicon $(date)"
