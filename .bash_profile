#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export TERM="alacritty"
export EDITOR="micro"

if [ $(tty) == "/dev/tty1" ]
then
	startx
fi
