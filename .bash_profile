# Source environment specific
if [ -f ~/.bash_private ] ; then
    . ~/.bash_private
fi

# Source user specific
if [ -f ~/.bash_aliases ] ; then
    . ~/.bash_aliases
fi
if [ -f ~/.bashrc ] ; then
    . ~/.bashrc
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

