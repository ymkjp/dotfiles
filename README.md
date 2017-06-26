dotfiles
========
.bashrc, .vimrc, .gitconfg, ...etc


## Support environments
* Debian GNU/Linux, Ubuntu, CentOS
* Mac OSX


## Main Dependency
* zsh
* Git version 1.8 or newer
 * Add PATH git/contrib/diff-highlight/diff-highlight
* Vim version 7.3 or newer


## Usage
```
cd ${HOME} && git clone https://github.com/ymkjp/dotfiles.git && bash dotfiles/setup.sh
```

## Local settings
#### Add local settings for specific environment
 * `.zshrc.local`
 * `.gitconfig.local`

```
[user]
    name  = YOUR_NAME
    email = example@example.com
```

# OS Sierra settings
Install Karabinar from https://github.com/wwwjfy/Karabiner-Elements/releases

```
# Requires restart
defaults write NSGlobalDomain InitialKeyRepeat -int 12
defaults write NSGlobalDomain KeyRepeat -int 1
```
