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
alias vi='mvim --remote-tab-silent'
alias less="/usr/share/vim/vim73/macros/less.sh"
alias ctags='/Applications/MacVim.app/Contents/MacOS/ctags "$@"'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a | grep -o 'inet6\? \(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sed -e 's/inet6* //'"

# Skype
alias skype2='su guest -c /Applications/Skype.app/Contents/MacOS/Skype'

# XAMP
alias xamp='cd /Applications/XAMPP/htdocs/'

