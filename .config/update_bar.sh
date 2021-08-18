
#volstat=$(amixer get Master | grep %)
#volstat=$(amixer -c 2 get Speaker | grep % | grep Left)
pulse=true

if [ "$(lsblk | grep -E '(sdc|sdd)')" != "" ]
#if [ "$(lsblk | grep -E '(sda|sdc|sdd)')" != "" ] # depending on amount if internal drives, adjust the amount of sdb/sdc/sdd/...
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
	if [ "$(pamixer --list-sinks | grep bluez)" != "" ]
	then
		volicon=""
	fi
	if [ "$(pamixer --get-mute)" = "true" ]
		then
		volicon="婢"
		if [ "$(pamixer --list-sinks | grep bluez)" != "" ]
		then
			volicon=""
		fi
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

if [ "$(cat ~/.config/mutt/newmail)" = "1" ]
then
	mailicon=""
fi


xsetroot -name " $mailicon$usbicon $volicon$vol% $wifiicon $(date)"
