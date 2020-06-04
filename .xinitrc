# set german keyboardlayout
setxkbmap -layout de -variant basic
# set standard monitorlayout
sh ~/.screenlayout/default.sh
# start desktop notification daemon
dunst &
# set a wallpaper
nitrogen --random ~/.config/wallpapers --set-zoom-fill
# start custom user daemon, for e.g. status bar
sh /home/lukas/.config/daemon.sh &
# wait for 3 seconds, then start compositor, for blurry transparency
(sleep 3;picom --experimental-backends) &
# start unclutter, to remove mouse, when unused
unclutter &
# start blueman-applet, to automatically connect to bluetooth devices etc.
blueman-applet &
# start dwm
exec /usr/local/bin/dwm
