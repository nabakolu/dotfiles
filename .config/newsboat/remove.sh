#!/bin/sh
sed "s/$(echo -ne '\u200b')//g" | sed "s/ÜÜnewlineÜÜ/\n/g"
