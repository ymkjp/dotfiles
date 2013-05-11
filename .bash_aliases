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
alias tree='tree -CFa'
alias diff='diff -bB'
alias sc='screen -D -RR'
alias grep='grep --color'

# Vim
vim_version=`vim --version | head -1 | sed 's/^.*\ \([0-9]\)\.\([0-9]\)\ .*$/\1\2/'`
[ -f /usr/share/vim/vim${vim_version}/macros/less.sh ] && alias less="/usr/share/vim/vim${vim_version}/macros/less.sh"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a"
