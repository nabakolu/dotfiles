~/.config/dunst.sh
# start custom user daemon, for e.g. status bar
sh /home/lukas/.config/daemon.sh &
# wait for 3 seconds, then start compositor, for blurry transparency
(sleep 5;picom) &
# start unclutter, to remove mouse, when unused
unclutter &
# start blueman-applet, to automatically connect to bluetooth devices etc.
blueman-applet &
