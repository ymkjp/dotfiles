# test -s has over 0 size
# test -r is able to read
# test -e is to exist

# Source global definitions
[ -f /etc/bashrc ]      && . /etc/bashrc

# Source environment specific
[ -f ~/.bash_private ]  && . ~/.bash_private

# Source user specific
[ -f ~/.bash_aliases ]  && . ~/.bash_aliases
[ -f ~/.bashrc ]        && . ~/.bashrc

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
