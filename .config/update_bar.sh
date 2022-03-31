
#volstat=$(amixer get Master | grep %)
#volstat=$(amixer -c 2 get Speaker | grep % | grep Left)
pulse=true

if [ "$(lsblk | grep -E '(sdc|sdd)')" != "" ]
#if [ "$(lsblk | grep -E '(sda|sdc|sdd)')" != "" ] # depending on amount if internal drives, adjust the amount of sdb/sdc/sdd/...
then
    usbicon=" 禍"
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

case $(xset q | grep LED | tail -c 2) in
	"0") lock="";;
	"1") lock=" וּ ";;
	"2") lock="  ";;
	"3") lock=" וּ   ";;
esac

if [ "$(cat /sys/class/net/wlp8s0/operstate)" = "down" ]
then
    wifiicon="睊"
else
    wifiicon="直"
fi


/bin/ls /sys/class/power_supply/BAT0 > /dev/null && battery="$(cat /sys/class/power_supply/BAT0/capacity)" && batteryicon=" "

xsetroot -name "          $lock$batteryicon$battery$usbicon  $volicon$vol%  $wifiicon   $(date +'%a %d %b %Y')   $(date +'%T')"
