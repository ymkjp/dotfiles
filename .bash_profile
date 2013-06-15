# test -f is ordinary file
# test -s has over 0 size
# test -e is to exist
# test -r is able to read

# Source global definitions
[ -f /etc/bashrc ] && . /etc/bashrc

# Source user specific
[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/.bashrc ] && . ~/.bashrc

# Source environment specific
[ -f ~/.bash_sec ] && . ~/.bash_sec
[ -f ~/.bash_dep ] && . ~/.bash_dep
