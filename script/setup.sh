#!/usr/bin/env bash

_setup () {
  set -u

  init () {
    createFileTree
    deployDotfiles
    setupMac
    checkDarwinDependencies
    installBrewKegs
    installBrewCasks
    setupShell
  }

  function createFileTree
  {
    mkdir -p ~/bin ~/tmp ~/src
    touch ~/.zshrc.local ~/.gitconfig.local
  }

  function deployDotfiles
  {
    for FILE in $(find "${PWD}" -type f -name '.*' ! -name '.travis*' ! -name '.*.local' ! -name '.gitignore*')
    do
        ln -is "${FILE}" "${HOME}"
    done

    for FILE in $(find "${PWD}" -type f -name '*.local')
    do
        TARGET="$(basename "${FILE}")"
        [[ ! -e "${HOME}/${TARGET}" ]] && cp "${FILE}" "${HOME}"
    done

    for DIR in $(find "${PWD}" -type d -name '.*' ! -name '.' ! -name '.git')
    do
        TARGET="$(basename "${DIR}")"
        [[ ! -e "${HOME}/${TARGET}" ]] && ln -is "${DIR}" "${HOME}"
    done

    mkdir -p "${HOME}/.config/git" && ln -is "${PWD}/.gitignore_global" "${HOME}/.config/git/ignore"
  }

  function setupMac
  {
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true
    defaults write com.apple.finder AppleShowAllFiles -boolean true
    defaults write com.apple.desktopservices DSDontWriteNetworkStores true
    defaults write com.apple.ImageCapture disableHotPlug -bool NO
    launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist
  }

  function checkDarwinDependencies
  {
    if command -v brew > /dev/null; then
        brew --version
    else
        echo 'Install Homebrew at http://brew.sh/'
        exit 1
    fi
  }

  function installBrewKegs
  {
    brew tap sdkman/tap
    brew install --formula -- $(cat $PWD/osx-packages/keg.txt)
  }

  function installBrewCasks
  {
    brew tap homebrew/cask-versions
    brew install --cask -- $(cat $PWD/osx-packages/cask.txt)
  }

  function setupShell
  {
    if type zsh > /dev/null 2>&1; then
      # Install oh-my-zsh
      [[ ! -d ~/.oh-my-zsh ]] && git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
      [[ ! -d ~/.zsh/antigen ]] && git clone https://github.com/zsh-users/antigen.git ~/.zsh/antigen
      # Create symlink for tmux
      [[ ! -s ~/bin/zsh ]] && ln -s "$(command -v zsh)" ~/bin/zsh
    fi
    if type tmux > /dev/null 2>&1; then
      git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi
  }

  _info () {
    MESSAGE="${1:-''}"
    echo "[$(basename "$0")] INFO: ${MESSAGE}"
  }

  _error () {
    MESSAGE="${1:-'Something went wrong.'}"
    echo "[$(basename "$0")] ERROR: ${MESSAGE}" >&2
    exit 1
  }

  _usage () {
    readonly SCRIPT_NAME=$(basename "$0")
    echo -e "${SCRIPT_NAME} -- dotfiles
    \\nUsage: ${SCRIPT_NAME} [arguments]
    \\nArguments:"
    declare -F | awk '{print "\t" $3}' | grep -v $'^\t_'
  }

  if [[ $# = 0 ]]; then
    _usage
  elif [[ "$(type -t "$1")" = "function" ]]; then
    $1
  else
    _usage && _error "Command '$1' not found."
  fi
}

_setup "$@"
