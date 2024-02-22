#!/usr/bin/env bash
# test -f is ordinary file
# test -s has over 0 size
# test -e is to exist
# test -r is able to read

# Source user specific
[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/".bashrc-$(hostname).sh" ] && ~/".bashrc-$(hostname).sh"

# Color
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad

# Not to override files
set -o noclobber
# Autofix typo
shopt -s cdspell

# History
HISTSIZE=99999
HISTFILESIZE=99999999
export HISTCONTROL=ignoreboth
export HISTIGNORE=?:??:???:exit

PS1="\u@\h:\W\$ "

# PATH
export PATH="${HOME}/bin:${PATH}"

# Language
export LANG=en_US.UTF-8
export LESSCHARSET=utf-8
export LC_ALL='en_US.UTF-8'

stty stop undef

# Atlassian security config
shopt -s histappend
export HISTFILESIZE=1048576
export HISTSIZE=1048576
export HISTTIMEFORMAT="%s "
export PROMPT_COMMAND="history -a; history -c; history -r"
