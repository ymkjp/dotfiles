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
    installGitContrib
  }

  function createFileTree
  {
    mkdir -p ~/bin ~/tmp ~/src
    touch ~/.zshrc.local ~/.gitconfig.local
  }

  function deployDotfiles
  {
    for FILE in $(find "${PWD}" -type f -name '.*' ! -name '.travis*' ! -name '.*.local' !   -name '.gitignore')
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
  }

  function setupMac
  {
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true
    defaults write com.apple.finder AppleShowAllFiles -boolean true
    defaults write com.apple.desktopservices DSDontWriteNetworkStores true
    defaults write com.apple.ImageCapture disableHotPlug -bool NO
    defaults write com.apple.systempreferences TMShowUnsupportedNetworkVolumes 1
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
    brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt

    brew install git zsh vim jq nkf tmux reattach-to-user-namespace wget z ssh-copy-id \
        gibo tcptraceroute ghq peco \
        pyenv-virtualenv nvm watch direnv
  }

  function installBrewCasks
  {
    brew cask install \
        karabiner-elements iterm2 bettertouchtool vagrant google-chrome google-japanese-ime dropbox \
        visual-studio-code charles imageoptim docker bartender alfred dash virtualbox keycastr

    brew tap homebrew/cask-versions
    brew cask install adoptopenjdk8
  }

  function setupShell
  {
    if type zsh > /dev/null 2>&1; then
      # Install oh-my-zsh
      [[ ! -d ~/.oh-my-zsh ]] && git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
      [[ ! -d ~/.zsh/antigen ]] && git clone https://github.com/zsh-users/antigen.git ~/.zsh/antigen
      # Create symlink for tmux
      [[ ! -s ~/bin/zsh ]] && ln -s "$(command -v zsh)" ~/bin/zsh
    fi
    if type tmux > /dev/null 2>&1; then
      git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi
  }

  function installGitContrib
  {
    GIT_CONTRIB_URL="https://raw.githubusercontent.com/git/git/v2.12.5/contrib/diff-highlight/diff-highlight"
    GIT_CONTRIB_BIN="${HOME}/bin/diff-highlight"
    if type diff-highlight > /dev/null 2>&1; then
        return 0
    else
        curl -LS "${GIT_CONTRIB_URL}" -o "${GIT_CONTRIB_BIN}" \
            && chmod +x "${GIT_CONTRIB_BIN}"
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
