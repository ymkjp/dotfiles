# Source environment specific
[ -f ~/.bash_private ]  && . ~/.bash_private

# Source user specific
[ -f ~/.bash_aliases ]  && . ~/.bash_aliases
[ -f ~/.bashrc ]        && . ~/.bashrc

# Source global definitions
[ -f /etc/bashrc ]      && . /etc/bashrc

