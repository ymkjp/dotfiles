# test -f is ordinary file
# test -s has over 0 size
# test -e is to exist
# test -r is able to read

# Source user specific
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# Source environment specific
[ -f ~/.bash_sec ] && . ~/.bash_sec
[ -f ~/.bash_dep ] && . ~/.bash_dep

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

# AUTOJUMP
export AUTOJUMP_IGNORE_CASE=1
export AUTOJUMP_AUTOCOMPLETE_CMDS='cp vim'

PS1="\u@\h:\W\$ "

# Language
export LANG=en_US.UTF-8
export LESSCHARSET=utf-8
export LC_ALL='en_US.UTF-8'

stty stop undef

# tmux
# To show the current branch by tmux
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && . ~/.autojump/etc/profile.d/autojump.sh
