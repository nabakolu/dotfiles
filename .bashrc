#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#aliases
alias alsamixer="alsamixer -g"
alias nav="source ranger"
alias handymount="sudo curlftpfs -f 192.168.178.26:2211 /media/handy/ -o user=lukas,allow_other"
alias handysdmount="sudo curlftpfs -f 192.168.178.26:2211 /media/handy/ -o user=lukas2,allow_other"
alias marvin="ssh nabakols@marvin.informatik.uni-stuttgart.de"
alias uberspace="ssh nabakolu@westphal.uberspace.de"
alias ubuntu-vm="ssh -p 2222 lukas@127.0.0.1"
alias ut="sudo ntpdate 0.pool.ntp.org"
alias ytaudio="youtube-dl -x -f bestaudio/bestdl"
alias ardu="sudo bash -c 'export _JAVA_AWT_WM_NONREPARENTING=1; arduino; exit'"
alias dotfiles='/usr/bin/git --git-dir=$HOME/packages/dotfiles/ --work-tree=$HOME' 
alias webdav='mount https://webdav.mailo.com'
# PS1
source ~/.config/git_prompt.sh
#export PS1="\[\033[38;5;202m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;2m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \\$ \[$(tput sgr0)\]"

#export PS1='\[\033[38;5;202m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;2m\]\w\[$(tput sgr0)\]\[\033[38;5;171m\]$(__git_ps1 " %s")\[\033[38;5;15m $(tput sgr0)\]\$ '
export PS1='\[\033[38;5;202m\]\u \[\033[38;5;2m\]\w\[\033[38;5;171m\]$(__git_ps1 " (%s)") \[\033[38;5;15m\]\$ '

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
source /usr/share/bash-completion/completions/git
__git_complete dotfiles _git


