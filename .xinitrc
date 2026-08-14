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

export XDG_SESSION_TYPE=x11
export XDG_CURRENT_DESKTOP=Awesome

systemctl --user import-environment DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE
dbus-update-activation-environment --systemd DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE

exec awesome
