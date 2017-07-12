dotfiles
========
.bashrc, .vimrc, .gitconfg, ...etc


## Supported OS
* Mac OSX
* Debian GNU/Linux, Ubuntu, CentOS

## Dependencies
* Zsh
* Git version 1.8 or newer
 * Add PATH git/contrib/diff-highlight/diff-highlight
* Vim version 7.3 or newer
* [Homebrew](http://brew.sh/) 

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

# macOS (Sierra or newer) settings

```
# Install dependencies
xcode-select --install
brew install caskroom/cask/karabiner-elements caskroom/cask/hammerspoon

# Requires restart
defaults write NSGlobalDomain InitialKeyRepeat -int 12
defaults write NSGlobalDomain KeyRepeat -int 1
```
