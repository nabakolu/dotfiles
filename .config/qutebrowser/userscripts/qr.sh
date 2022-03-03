#!/bin/sh
qrencode --size 30 -o - "$@" | feh -x --title "site: $@" -g +200+200 -
