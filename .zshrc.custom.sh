# man zshoptions
autoload -Uz is-at-least

# Tokens
[[ -f ~/.ATLAS_TOKEN ]] && . ~/.ATLAS_TOKEN
[[ -f ~/.HOMEBREW_GITHUB_API_TOKEN ]] && . ~/.HOMEBREW_GITHUB_API_TOKEN

# === PATH ===
# -x: export SUDO_PATH, too
# -T: Synchronize SUDO_PATH and sudo_path
typeset -xT SUDO_PATH sudo_path
# Ignore duplicated path
typeset -U sudo_path
# (N-/): Ignore directory doesn't exist
#    PATH(...): Remain path match to ...
#            N: Set NULL_GLOB optigroup on, ignore path no glob mach, not exist
#            -: Ignore all except symlink
#            /: Ignore all except directory
sudo_path=({,/usr/pkg,/usr/local,/usr}/sbin(N-/))

export PATH=/usr/local/sbin:/usr/local/bin:$PATH
export PATH=${HOME}/bin:$PATH

# Env
if which direnv > /dev/null; then eval "$(direnv hook zsh)"; fi

if which pack > /dev/null; then
  . $(pack completion --shell zsh)
fi


# Golang
export GOPATH=$HOME

# Python (where BASH_ENV is not defined)
if [[ -e "$HOME/.pyenv" ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  alias python3=~/.pyenv/shims/python3
fi
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f "${HOME}/bin/google-cloud-sdk/path.zsh.inc" ]; then . "${HOME}/bin/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "${HOME}/bin/google-cloud-sdk/completion.zsh.inc" ]; then . "${HOME}/bin/google-cloud-sdk/completion.zsh.inc"; fi

# === Complement ===
# Git completion http://blog.qnyp.com/2013/05/14/zsh-git-completion/
fpath=(~/.zsh/completion $fpath)
autoload -U compinit && compinit -u
setopt auto_menu
# Tiny list
setopt list_packed
setopt list_types
setopt no_list_beep
# Find sub directories by command with /
setopt path_dirs
# Arranged in numberical order, not dictionary order
setopt numeric_glob_sort
# Don't ignore dot-atom
setopt globdots
# auto input blankets
setopt auto_param_keys
setopt mark_dirs
# Complete as cursol postion
setopt complete_in_word
# Auto expand history
setopt hist_expand

# http://www.clear-code.com/blog/2011/9/5.html
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:default' list-colors ""
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'
zstyle ':completion:*' use-cache yes

zstyle ':completion:*' completer _expand _complete _match _prefix _list _history
zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH"
# Ignore current directory after ../
zstyle ':completion:*' ignore-parents parent pwd ..


# Show current directory in tmux window name
autoload -Uz add-zsh-hook

rename_tmux_window () {
   tmux rename-window "$(basename ${PWD})"
}

add-zsh-hook precmd rename_tmux_window

# Language
# =====
export LANG=en_US.UTF-8
export LESSCHARSET=utf-8
export LC_ALL='en_US.UTF-8'
setopt print_eight_bit

# Ignore commands after hash
setopt interactive_comments

setopt noautoremoveslash
setopt nobeep
# Show PID with jobs command
setopt long_list_jobs

# Directory
# =====
# Change directory without cd
setopt auto_cd
# Add to directory stack by cd like pushd
setopt auto_pushd
setopt pushd_ignore_dups
# If there are no given directory, find from ~
cdpath=(~)
# Show directory stack after changed directory
chpwd_functions=($chpwd_functions dirs)

# Automatic correction
setopt correct
# To all params
unsetopt CORRECT_ALL

# Emacs like
bindkey -e

# === Prompt ===
setopt prompt_subst
setopt transient_rprompt
unsetopt promptcr
# https://linux.die.net/man/1/zshmisc
PROMPT="%F{8}%* %(?.%?.%S%?%s)%f ${PROMPT}"

# === History ===
# http://news.mynavi.jp/column/zsh/003/index.html
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
# share command history data
setopt share_history
# Ignore duplicated command
setopt hist_ignore_dups
# Ignore command start with space
setopt hist_ignore_space
# History search
bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward
if is-at-least 4.3.10; then
    bindkey '^R' history-incremental-pattern-search-backward
    bindkey '^S' history-incremental-pattern-search-forward
else
    bindkey '^R' history-incremental-search-backward
    bindkey '^S' history-incremental-search-forward
fi

# http://mokokko.hatenablog.com/entry/2013/03/14/133850
_SSH_AGENT="$HOME/.ssh/agent-$(whoami)@$(hostname)"
if [ -S "$_SSH_AGENT" ]; then
  export SSH_AUTH_SOCK=$_SSH_AGENT
elif [ ! -S "$SSH_AUTH_SOCK" ]; then
  export SSH_AUTH_SOCK=$_SSH_AGENT
elif [ ! -L "$SSH_AUTH_SOCK" ]; then
  ln -snf "$SSH_AUTH_SOCK" $_SSH_AGENT && export SSH_AUTH_SOCK=$_SSH_AGENT
fi

# PAGER
# ===
if [ "$PAGER" = "lv" ]; then
    export LV="-c -l"
else
    alias lv="$PAGER"
fi

if which vim > /dev/null; then
  export EDITOR="vim"
elif which vi > /dev/null; then
  export EDITOR="vi"
fi

case "${OSTYPE}" in
# MacOSX
darwin*)
    [ -f ~/.zshrc.osx.sh ] && . ~/.zshrc.osx.sh
    ;;
# Linux
linux*)
    [ -f ~/.zshrc.linux.sh ] && . ~/.zshrc.linux.sh
    ;;
esac

HOST_RC="${HOME}/.zshrc.$(hostname).sh"
[[ -f "${HOST_RC}" ]] && . "${HOST_RC}"

# alias
setopt complete_aliases
[ -f ~/.zshrc.alias.sh ] && . ~/.zshrc.alias.sh

# Local specific
[ -f ~/.zshrc.local.sh ] && . ~/.zshrc.local.sh

# Unique path
typeset -U path

# vim:set ft=zsh:
