if [ -f ~/.bashrc ] ; then
    . ~/.bashrc
fi
if [ -f ~/.bash_secret ] ; then
    . ~/.bash_secret
fi
if [ -f ~/.bash_aliases ] ; then
    . ~/.bash_aliases
fi
export PATH=/Applications/MacVim.app/Contents/MacOS:/Users/keso/pear/bin:/usr/X11/bin:/usr/local/bin:$PATH
