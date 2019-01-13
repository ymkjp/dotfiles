#!/usr/bin/env bash

__setup () {
  set -u

  init () {
    mkdir -p ~/bin ~/tmp ~/src
  }

  function deployDotfiles
  {
    DOT_FILES=$(find "${PWD}" -type f -name '.*' ! -name '.travis*' ! -name '.*.local' !   -name '.gitignore')
    LOCAL_DOT_FILES=$(find "${PWD}" -type f -name '*.local')
    DOT_DIRS=$(find "${PWD}" -type d -name '.*' ! -name '.' ! -name '.git')

    for FILE in ${DOT_FILES[@]}
    do
        ln -is "${FILE}" "${HOME}"
    done

    for FILE in ${LOCAL_DOT_FILES[@]}
    do
        TARGET="$(basename "${FILE}")"
        [[ ! -e "${HOME}/${TARGET}" ]] && cp "${FILE}" "${HOME}"
    done

    for DIR in ${DOT_DIRS[@]}
    do
        TARGET="$(basename "${DIR}")"
        [[ ! -e "${HOME}/${TARGET}" ]] && ln -is "${DIR}" "${HOME}"
    done
  }

  function setupMac
  {
    # defaults delete -g KeyRepeat
    # defaults delete -g InitialKeyRepeat
    #      defaults write NSGlobalDomain InitialKeyRepeat -int 12
    #      defaults write NSGlobalDomain KeyRepeat -int 1
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true
    defaults write com.apple.finder AppleShowAllFiles -boolean true
    defaults write com.apple.desktopservices DSDontWriteNetworkStores true
    defaults write com.apple.ImageCapture disableHotPlug -bool NO
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
      [[ ! -s ~/bin/zsh ]] && ln -s "$(command -v zsh)" ~/bin/zsh
    fi
    if type tmux > /dev/null 2>&1; then
      git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
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
    GIT_CONTRIB_URL="https://raw.githubusercontent.com/git/git/v2.12.5/contrib/diff-highlight/diff-highlight"
    GIT_CONTRIB_BIN="${HOME}/bin/diff-highlight"
    if type diff-highlight > /dev/null 2>&1; then
        return 0
    else
        curl -LS "${GIT_CONTRIB_URL}" -o "${GIT_CONTRIB_BIN}" \
            && chmod +x "${GIT_CONTRIB_BIN}"
    fi
  }

  @info () {
    MESSAGE="${1:-''}"
    echo "[$(basename "$0")] INFO: ${MESSAGE}"
  }

  @error () {
    MESSAGE="${1:-'Something went wrong.'}"
    echo "[$(basename "$0")] ERROR: ${MESSAGE}" >&2
    exit 1
  }

  @usage () {
    readonly SCRIPT_NAME=$(basename "$0")
    echo -e "${SCRIPT_NAME} -- dotfiles
    \\nUsage: ${SCRIPT_NAME} [arguments]
    \\nArguments:"
    declare -F | awk '{print "\t" $3}' | grep -v "${SCRIPT_NAME}"
  }

  if [ $# = 0 ]; then
    @usage
  elif [ "$(type -t "$1")" = "function" ]; then
    $1
  else
    @usage && @error "Command '$1' not found."
  fi
}

__setup "$@"
