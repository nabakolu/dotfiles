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


if [[ $(who am i) =~ \([-a-zA-Z0-9\.]+\)$ ]] ;
then
	export PS1='\[\033[38;5;2m\]\u\[$(tput sgr0)\]@\[$(tput sgr0)\]\[\033[38;5;1m\]\H\[$(tput sgr0)\] \[\033[32m\]\w \[\033[31m\]$ \[\033[38;5;15m\]'
else
	source ~/.config/git_prompt.sh && export PS1='\[\033[48;5;2m\] \w\[$(tput sgr0)\]\[\033[38;5;2m\]$(__git_ps1 "\[\033[38;5;2m\]\[\033[48;5;1m\]")$(__git_ps1 "\[$(tput sgr0)\]\[\033[48;5;1m\]%s\[$(tput sgr0)\]\[\033[38;5;1m\]")\[$(tput sgr0)\]' || export PS1='\[\033[48;5;2m\] \w\[$(tput sgr0)\]\[\033[38;5;2m\]\[$(tput sgr0)\]'
	[ -z $(tty | grep tty) ] || export PS1='\[\033[32m\]\w \[\033[31m\]$ \[\033[38;5;15m\]'
fi

export FZF_DEFAULT_COMMAND='find .'

#aliases
alias ytaudio="youtube-dl -x -f bestaudio/bestdl"
alias dotfiles='git --git-dir=$HOME/packages/dotfiles/ --work-tree=$HOME' 
alias diff="diff --color=auto"
alias se="vim \$(fzf)"

[[ $(type -P lsd) ]] && [ -z $(tty | grep tty) ] && alias ls='lsd' || alias ls='ls --color=auto -F'
alias ll='ls -l'
alias l='ls -1'
alias la='ls -a'
alias lla='ls -l -a'

#dotfiles completion
include /usr/share/bash-completion/completions/git && __git_complete dotfiles __git_main
