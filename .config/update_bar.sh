#!/bin/bash
/bin/ls /media/* && usbicon="  禍"

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
case $(xset q | grep LED | tail -c 2) in
	"0") lock="";;
	"1") lock=" וּ ";;
	"2") lock="  ";;
	"3") lock=" וּ   ";;
esac

[ "$(networkctl status 2> /dev/null | grep Address)" = "" ] && wifiicon="睊" || wifiicon="直"

date=" $(date +'%a %d %b %Y')"
time=" $(date +'%T')"
/bin/ls /sys/class/power_supply/BAT0 > /dev/null && battery="$(cat /sys/class/power_supply/BAT0/capacity)" && batteryicon=" "

status="$lock$batteryicon$battery$usbicon  $volicon$vol%  $wifiicon  $date  $time"
xsetroot -name "    $status"
