# User specific aliases 
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias ls='ls -CFh'
alias la='ls -CFal'
alias cp='cp -iv'
alias rm='rm -iv'
alias mv='mv -iv'
alias sc='screen'
alias grep='grep --color'

# Vim
vim_version=`vim --version | head -1 | sed 's/^.*\ \([0-9]\)\.\([0-9]\)\ .*$/\1\2/'`
if [ -f /usr/share/vim/vim${vim_version}/macros/less.sh ] ; then
    alias less="/usr/share/vim/vim${vim_version}/macros/less.sh"
fi

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a"
