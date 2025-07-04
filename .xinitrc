# set german keyboardlayout
setxkbmap -layout de -variant nodeadkeys -option lv3:caps_switch

# set keyboard rate
xset r rate 400 60

# set screensaver timeout to 1 hour
xset s 3600 3600

# set standard monitorlayout
sh ~/.screenlayout/default.sh

# restore pywal settings
wal -R

# start unclutter, to remove mouse, when unused
unclutter &

# start clipmenu daemon
clipmenud &

# start picom
toggle_p.sh

# start xss-lock to lock screen on power events
xss-lock -- lock &

export GTK_USE_PORTAL=1
/usr/lib/xdg-desktop-portal-termfilechooser -r &

keepassxc --minimized &

exec /usr/bin/awesome
