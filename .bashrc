#!/bin/bash
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

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ];
then
	export PS1='\[\033[38;5;2m\]\u\[$(tput sgr0)\]@\[$(tput sgr0)\]\[\033[38;5;1m\]\H\[$(tput sgr0)\] \[\033[32m\]\w \[\033[31m\]$ \[\033[38;5;15m\]'
else
	include ~/.config/git_prompt.sh && export PS1=' \[\033[32m\]\w \[\033[34m\]$(__git_ps1 "%s ")\[\033[31m\]$ \[\033[38;5;15m\]' || export PS1=' \[\033[32m\]\w \[\033[31m\]$ \[\033[38;5;15m\]'
fi

export FZF_DEFAULT_COMMAND='find .'

export PATH="$PATH:$(go env GOBIN):$(go env GOPATH)/bin:~/.local/bin"
export PATH="/home/lukas/.perl5/bin${PATH:+:${PATH}}"; export PATH;
export PERL5LIB="/home/lukas/.perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
export PERL_LOCAL_LIB_ROOT="/home/lukas/.perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
export PERL_MB_OPT="--install_base \"/home/lukas/.perl5\""; export PERL_MB_OPT;
export PERL_MM_OPT="INSTALL_BASE=/home/lukas/.perl5"; export PERL_MM_OPT;

#aliases
alias ytaudio="yt-dlp -x -f bestaudio/bestdl"
alias dotfiles='git --git-dir=$HOME/packages/dotfiles/ --work-tree=$HOME' 
alias diff="diff --color=auto"
alias se="nvim \$(fzf)"

[[ $(type -P lsd) ]] && [ -z $(tty | grep tty) ] && alias ls='lsd' || alias ls='ls --color=auto -F'
alias ll='ls -l'
alias l='ls -1'
alias la='ls -a'
alias lla='ls -l -a'
alias bc='BC_ENV_ARGS=<(echo "scale=10") \bc'

#dotfiles completion
include /usr/share/bash-completion/completions/git && __git_complete dotfiles __git_main

