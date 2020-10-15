#!/bin/sh

case "$1" in
	*.mp3|*.mp4|*.wav|*.opus|*.ogg|*.mkv) mediainfo "$1";;
	*.png|*.jpg|*.jpeg) chafa "$1";;
	*.zip) zipinfo -2 -h "$1";;
	*.gz) tar -ztf "$1";;
	*.bz2) tar -jtf "$1";;
	*.tar) tar -tf "$1";;
	*.pdf) pdftotext "$1" -;;
	*) less "$1";;
esac
