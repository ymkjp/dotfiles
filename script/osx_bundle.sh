#!/usr/bin/env bash

xcode-select --install || exit 1
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

brew update || exit 1
brew upgrade || exit 1

brew install apple-gcc42
brew install atool
brew install autoconf
brew install autojump
brew install automake
brew install bash
brew install bash-completion
brew install bison
brew install brew-gem
brew install bsdmake
brew install cairo
brew install cloog
brew install cloog018
brew install coreutils
brew install ctags
brew install fontconfig
brew install fontforge
brew install freetype
brew install gcc
brew install gdbm
brew install gettext
brew install ghc
brew install git
brew install glib
brew install gmp
brew install gmp4
brew install gobject-introspection
brew install grep
brew install harfbuzz
brew install htop-osx
brew install hub
brew install icu4c
brew install imagemagick
brew install isl
brew install isl011
brew install jenkins
brew install jpeg
brew install jq
brew install libevent
brew install libffi
brew install libgpg-error
brew install libksba
brew install libmpc
brew install libmpc08
brew install libpng
brew install libtiff
brew install libtool
brew install libxml2
brew install libyaml
brew install little-cms2
brew install mobile-shell
brew install mpfr
brew install mpfr2
brew install mysql
brew install nkf
brew install node
brew install openjpeg
brew install openssl
brew install ossp-uuid
brew install pango
brew install pcre
brew install pixman
brew install pkg-config
brew install poppler
brew install proctools
brew install protobuf
brew install pstree
brew install pypy
brew install python
brew install r
brew install rbenv
brew install readline
brew install reattach-to-user-namespace
brew install rsense
brew install ruby-build
brew install sam2p
brew install sqlite
brew install sshuttle
brew install tig
brew install tmux
brew install tree
brew install unixodbc
brew install wget
brew install xz
brew install z
brew install zlib
brew install zsh

# cask
brew install caskroom/cask/brew-cask || exit 1
brew cask install alfred
brew cask install iterm2
brew cask install java
brew cask install google-chrome
brew cask install virtualbox
brew cask install vagrant
brew cask install bettertouchtool
brew cask install caffeine
brew cask install clipmenu
brew cask install dash
brew cask install dropbox
brew cask install gyazo
brew cask install lastfm
brew cask install sublime
brew cask install skitch
brew cask install sequel-pro
brew cask install karabiner
brew cask install phpstorm
brew cask install unity3d
brew cask install mysqlworkbench
brew cask install google-japanese-ime

