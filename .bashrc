#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#aliases
alias alsamixer="alsamixer -g"
alias nav="source ranger"
alias handymount="sudo curlftpfs -f 192.168.178.42:2211 /media/handy/ -o user=lukas,allow_other"
alias handysdmount="sudo curlftpfs -f 192.168.178.42:2211 /media/handy/ -o user=lukas2,allow_other"
alias marvin="ssh nabakols@marvin.informatik.uni-stuttgart.de"
alias uberspace="ssh nabakolu@westphal.uberspace.de"
alias ut="sudo ntpdate 0.pool.ntp.org"
alias ytaudio="youtube-dl -x -f bestaudio/bestdl"
alias ardu="sudo bash -c 'export _JAVA_AWT_WM_NONREPARENTING=1; arduino; exit'"
alias dotfiles='/usr/bin/git --git-dir=$HOME/packages/dotfiles/ --work-tree=$HOME' 

#check if tty
if [$(tty | grep tty) == ""]
then
	alias ls='lsd'
	alias l='ls -1'
	alias ll='ls -l'
	alias la='ls -a'
	alias lla='ls -l -a'
	#PS1
	eval "$(starship init bash)"
	# wal -R -e -q
else
    alias ranger='ranger --cmd="set use_preview_script!"; clear'
    alias ls='ls --color=auto -F'
    alias ll='ls --color=auto -Fl'
    alias l='ls -1'
    alias la='ls -a'
    alias lla='ls -l -a'
	# PS1
	export PS1="\[\033[38;5;202m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;6m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;2m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \\$ \[$(tput sgr0)\]"
fi


#bash completion
complete -cf sudo
complete -c man



