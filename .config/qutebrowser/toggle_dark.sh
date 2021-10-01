#!/bin/bash

FILE="/home/lukas/.config/qutebrowser/greasemonkey/dark.js"

if [ -e "$FILE" ]
then
	mv $FILE "$FILE.disabled"
else
	mv "$FILE.disabled" $FILE
fi
