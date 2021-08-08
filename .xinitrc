# set german keyboardlayout
setxkbmap -layout de -variant nodeadkeys

# set keyboard rate
xset r rate 400 60

# set screensaver timeout to 1 hour
xset s 3600 3600

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

# start filemanager dbus daemon
python /home/.config/filemanager-dbus.py &

# start picom
picom --experimental-backends &

exec /usr/local/bin/dwm
