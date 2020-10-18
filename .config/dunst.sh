#!/bin/bash

source "${HOME}/.cache/wal/colors.sh"

/usr/bin/dunst \
    -lb "${color0:-#F0F0F0}" \
    -nb "${color0:-#F0F0F0}" \
    -cb "${color0:-#F0F0F0}" \
    -lf "${color1:=#000000}" \
    -cf "${color1:=#000000}" \
    -nf "${color1:=#000000}" &
disown
