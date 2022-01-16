#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# source only if file exists
include () {
    [[ -f "$1" ]] && source "$1"
}

# enable vi mode
set -o vi

#aliases
alias alsamixer="alsamixer -g"
alias handymount="sudo curlftpfs -f 192.168.178.26:2211 /media/handy/ -o user=lukas,allow_other"
alias handysdmount="sudo curlftpfs -f 192.168.178.26:2211 /media/handy/ -o user=lukas2,allow_other"
alias ytaudio="youtube-dl -x -f bestaudio/bestdl"
alias dotfiles='git --git-dir=$HOME/packages/dotfiles/ --work-tree=$HOME' 
alias webdav='mount https://webdav.mailo.com'
alias diff="diff --color=auto"
alias se="vim \$(fzf)"

source ~/.config/git_prompt.sh
export PS1='\[\033[32m\]\w\[\033[35m\]$(__git_ps1 " (%s)") \[\033[31m\]$ \[\033[38;5;15m\]'

export FZF_DEFAULT_COMMAND='find .'

#check if tty
if [$(tty | grep tty) == ""]
then
	alias ls='lsd'
	alias l='ls -1'
	alias ll='ls -l'
	alias la='ls -a'
	alias lla='ls -l -a'
else
	alias ranger='ranger --cmd="set use_preview_script!"; clear'
	alias ls='ls --color=auto -F'
	alias ll='ls --color=auto -Fl'
	alias l='ls -1'
	alias la='ls -a'
	alias lla='ls -l -a'
fi

#bash completion
complete -cf sudo
complete -c man
include /usr/share/bash-completion/completions/ssh
include /usr/share/bash-completion/completions/git
include /usr/share/bash-completion/completions/arduino
[[ -f /usr/share/blesh/ble.sh ]] && source /usr/share/blesh/ble.sh
__git_complete dotfiles __git_main

