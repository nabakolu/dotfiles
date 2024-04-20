#!/bin/sh
sed -i "s/$(echo -ne '\u200b')//g" $1
