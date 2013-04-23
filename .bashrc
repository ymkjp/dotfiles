# Color
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad

# Language
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8
export LC_MESSAGES='ja_JP.UTF-8'
export LC_ALL='ja_JP.UTF-8'

# http://qiita.com/items/9dd797f42e7bea674705
if [ -e ~/.rbenv ] ; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

[[ -s "$HOME/.pythonbrew/etc/bashrc" ]] && source "$HOME/.pythonbrew/etc/bashrc"

# set prompt
PS1="\u@\h:\W\\$ "

# nvm{{{
. ~/.nvm/nvm.sh
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion
#}}}

# tmux{{{
# To show the current branch by tmux
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

#}}}

