#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export TERMINAL="st"
export EDITOR="micro"

if [ $(tty) == "/dev/tty1" ]
then
	startx
fi
