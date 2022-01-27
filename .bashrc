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

source ~/.config/git_prompt.sh && export PS1='\[\033[32m\]\w\[\033[35m\]$(__git_ps1 " (%s)") \[\033[31m\]$ \[\033[38;5;15m\]' || export PS1='\[\033[32m\]\w \[\033[31m\]$ \[\033[38;5;15m\]'

export FZF_DEFAULT_COMMAND='find .'

#aliases
alias ytaudio="youtube-dl -x -f bestaudio/bestdl"
alias dotfiles='git --git-dir=$HOME/packages/dotfiles/ --work-tree=$HOME' 
alias diff="diff --color=auto"
alias se="vim \$(fzf)"

[[ $(type -P lsd) ]] && alias ls='lsd' || alias ls='ls --color=auto -F'
alias ll='ls -l'
alias l='ls -1'
alias la='ls -a'
alias lla='ls -l -a'

#dotfiles completion
include /usr/share/bash-completion/completions/git && __git_complete dotfiles __git_main
