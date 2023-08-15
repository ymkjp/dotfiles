dotfiles
========
[![Build Status](https://travis-ci.org/ymkjp/dotfiles.svg?branch=master)](https://travis-ci.org/ymkjp/dotfiles)

## Supported OS and Dependencies
* Mac OSX
  * `xcode-select --install`
  * [Homebrew](http://brew.sh/) 
* Arch Linux, Debian GNU/Linux, Ubuntu, CentOS

## Usage
```
cd ${HOME}
git clone https://github.com/ymkjp/dotfiles.git
cd ./dotfiles
bash ./script/setup.sh init

# [Mac] Reboot to apply OS settings
shutdown -r now "Rebooting for $0"
```

Backup:

```bash
sudo bash ./script/backup.bash start
sudo bash ./script/backup.bash stop
```

## Local settings
Set up local settings for your own
 * `.zshrc.local.sh`
 * `.gitconfig.local`

```
[user]
    name  = YOUR_NAME
    email = example@example.com
```

## Network settings

(Optional) to turn off IPv6:

```bash
networksetup -listallnetworkservices
networksetup -setv6off Wi-Fi
````
