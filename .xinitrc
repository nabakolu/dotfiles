# set german keyboardlayout
setxkbmap -layout de -variant basic

# set standard monitorlayout
sh ~/.screenlayout/default.sh

# restore pywal settings
wal -R
 
~/.config/dunst.sh

# start custom user daemon, for e.g. status bar
sh /home/lukas/.config/daemon.sh &

# start unclutter, to remove mouse, when unused
unclutter &

# start blueman-applet, to automatically connect to bluetooth devices etc.
blueman-applet &

# wait for 3 seconds, then start compositor
(sleep 5;picom) &

exec /usr/local/bin/dwm
