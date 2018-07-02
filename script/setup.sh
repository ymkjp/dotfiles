#!/bin/bash

function main
{
  set -eu
  [[ ! -d ~/bin ]] && mkdir -p ~/bin
  [[ ! -d ~/tmp ]] && mkdir -p ~/tmp

  deployDotfiles

  case "${OSTYPE}" in
  # MacOSX
  darwin*)
      checkDarwinDependencies
      installBrewKegs
      # Requires restart
      # defaults delete -g KeyRepeat
      # defaults delete -g InitialKeyRepeat
#      defaults write NSGlobalDomain InitialKeyRepeat -int 12
#      defaults write NSGlobalDomain KeyRepeat -int 1
      defaults write NSGlobalDomain AppleShowAllExtensions -bool true
      defaults write com.apple.finder AppleShowAllFiles -boolean true
      defaults write com.apple.desktopservices DSDontWriteNetworkStores true
      defaults write com.apple.ImageCapture disableHotPlug -bool NO
      ;;
  # Linux
  linux*)
      installPecoLinux
      ;;
  esac

  setupShell
  installGitContrib
  installNeobundleVim
}

function deployDotfiles
{
  ROOT_PATH="${HOME}/dotfiles"
  DOT_FILES=$(find "${ROOT_PATH}" -name "*" ! -name '*.sh' ! -path '*/.git/*' ! -path '*/.vim/backups/*' ! -path '*/.vim/bundle/*' ! -path '*/.config/karabiner/assets/*')
  LOCAL_DOT_FILES=$(find "${ROOT_PATH}" -maxdepth 1 -name '*.local')

  for FILE in "${DOT_FILES[@]}"
  do
      ln -is "${FILE}" "${HOME}"
  done

  for FILE in "${LOCAL_DOT_FILES[@]}"
  do
      TARGET="$(basename "${FILE}")"
      [[ ! -e "${HOME}/${TARGET}" ]] && cp "${FILE}" "${HOME}"
  done
}

function checkDarwinDependencies
{
  if which brew > /dev/null; then
    brew --version
  else
    echo 'Install Homebrew at http://brew.sh/'
    exit 1
  fi
}

function installPecoLinux
{
    PECO_BIN_URL="https://github.com/peco/peco/releases/download/v0.3.5/peco_linux_386.tar.gz"
    PECO_ROOT_DIR="${HOME}/bin/peco_linux_386"
    if type peco > /dev/null 2>&1; then
        return 0
    else
        curl -SL "${PECO_BIN_URL}" | tar xvz -C ~/bin \
            && ln -s "${PECO_ROOT_DIR}/peco" ~/bin
    fi
}

function installBrewKegs
{
  brew install --with-default-name coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt

  brew install zsh vim jq nkf tmux reattach-to-user-namespace wget z ssh-copy-id \
    gibo tcptraceroute peco

  brew cask install \
    karabiner-elements iterm2 bettertouchtool vagrant google-chrome dropbox \
    visual-studio-code charles imageoptim docker bartender
}

function setupShell
{
    if type zsh > /dev/null 2>&1; then
      # Install oh-my-zsh
      [[ ! -d ~/.oh-my-zsh ]] && git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
      [[ ! -d ~/.zsh/antigen ]] && git clone https://github.com/zsh-users/antigen.git ~/.zsh/antigen
      # Create symlink for tmux
      [[ ! -s ~/bin/zsh ]] && ln -s "$(which zsh)" ~/bin/zsh
  fi
}

function installNeobundleVim
{
    NEOBUNDLE_INSTALL_URL="https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh"
    NEOBUNDLE_ROOT_DIR="${HOME}/.vim/bundle/neobundle.vim"
    [[ ! -d "${NEOBUNDLE_ROOT_DIR}" ]] && curl -LS ${NEOBUNDLE_INSTALL_URL} | sh > /dev/null
}

function installGitContrib
{
    GIT_CONTRIB_URL="https://raw.github.com/git/git/master/contrib/diff-highlight/diff-highlight"
    GIT_CONTRIB_BIN="${HOME}/bin/diff-highlight"
    if type diff-highlight > /dev/null 2>&1; then
        return 0
    else
        curl -LS "${GIT_CONTRIB_URL}" -o "${GIT_CONTRIB_BIN}" \
            && chmod +x "${GIT_CONTRIB_BIN}"
    fi
}

main
