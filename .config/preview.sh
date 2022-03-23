#!/bin/bash

case "$1" in
	*.mp3|*.mp4|*.wav|*.opus|*.ogg|*.mkv) 
		str=$(mediainfo "$1")
		echo "${str//                          /}";;
	*.png|*.jpg|*.jpeg) chafa "$1";;
	*.zip) zipinfo -2 -h "$1";;
	*.gz) tar -ztf "$1";;
	*.bz2) tar -jtf "$1";;
	*.tar) tar -tf "$1";;
	*.pdf) pdfinfo "$1"; echo ""; pdftotext "$1" -;;
	*) bat --color always "$1" || cat "$1";;
esac
