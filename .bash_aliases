#!/usr/bin/env bash

# User specific aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias ll='ls -laF'
alias la='ls -aF'
alias cp='cp -iv'
alias rm='rm -iv'
alias mv='mv -iv'
alias sc='screen -D -RR'

# IRC irssi
alias irssi='env TERM=screen-256color irssi'

# Functions
mc () {
    mkdir -p "$1" && cd "$1" || return
}

tm () {
  if [[ $# = 0 ]]; then
    tmux attach || tmux new
  else
    ssh -t "$@" "tmux attach || tmux new";
  fi
}

# IP addresses
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'
alias localip='ipconfig getifaddr en1'
alias ips='ifconfig -a'
