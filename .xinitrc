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

# restore wallpaper
sh ~/.fehbg

# start unclutter, to remove mouse, when unused
unclutter &

# start clipmenu daemon
clipmenud &

# start picom
toggle_p.sh

# start noisetorch
noisetorch -i

# start xss-lock to lock screen on power events
xss-lock -- betterlockscreen -l &

exec /usr/bin/awesome
