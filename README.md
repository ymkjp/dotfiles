dotfiles
========
[![Build Status](https://travis-ci.org/ymkjp/dotfiles.svg?branch=master)](https://travis-ci.org/ymkjp/dotfiles)


## Supported OS and Dependencies
* Mac OSX
  * `xcode-select --install`
  * [Homebrew](http://brew.sh/) 
* Debian GNU/Linux, Ubuntu, CentOS

## Usage
```
git clone https://github.com/ymkjp/dotfiles.git ${HOME}
bash ${HOME}/dotfiles/setup.sh

# [Mac] Reboot to apply OS settings
shutdown -r now "Rebooting for $0"
```

## Local settings
Set up local settings for your own
 * `.zshrc.local`
 * `.gitconfig.local`

```
[user]
    name  = YOUR_NAME
    email = example@example.com
```
