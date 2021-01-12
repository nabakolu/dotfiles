# set german keyboardlayout
setxkbmap -layout de -variant basic

# set keyboard rate
xset r rate 400 60

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

# start clipmenu daemon
clipmenud &

exec /usr/local/bin/dwm
