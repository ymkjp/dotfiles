#!/bin/bash

ROOT_PATH="${HOME}/dotfiles"
DOT_FILES=$(find ${ROOT_PATH} -name "*" ! -name '*.sh' ! -path '*/.git/*' ! -path '*/.vim/backups/*' ! -path '*/.vim/bundle/*' ! -path '*/.config/karabiner/assets/*')
LOCAL_DOT_FILES=$(find ${ROOT_PATH} -maxdepth 1 -name '*.local')

function message
{
    echo -e "\n[Recommended tools]"
    echo -e "autojump"
}

function installPecoLinux
{
    PECO_BIN_URL="https://github.com/peco/peco/releases/download/v0.3.5/peco_linux_386.tar.gz"
    PECO_ROOT_DIR="~/bin/peco_linux_386"
    if type peco > /dev/null 2>&1; then
        return 0
    else
        curl -SL ${PECO_BIN_URL} | tar xvz -C ~/bin \
            && ln -s ${PECO_ROOT_DIR}/peco ~/bin
    fi
}

function installPecoDarwin
{
    brew install peco
}

function createDirsAndFiles
{
  touch .gitconfig.local .zshrc.local
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
        curl -LS "${GIT_CONTRIB_URL}" -o ${GIT_CONTRIB_BIN} \
            && chmod +x ${GIT_CONTRIB_BIN}
    fi
}

[[ ! -d ~/bin ]] && mkdir -p ~/bin
[[ ! -d ~/tmp ]] && mkdir -m 777 -p ~/tmp

for FILE in ${DOT_FILES[@]}
do
    ln -is ${FILE} ${HOME}
done

for FILE in ${LOCAL_DOT_FILES[@]}
do
    TARGET=$(basename ${FILE})
    [[ ! -e "${HOME}/${TARGET}" ]] && cp ${FILE} ${HOME}
done

if type zsh > /dev/null 2>&1; then
    # Install oh-my-zsh
    [[ ! -d ~/.oh-my-zsh ]] && git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    [[ ! -d ~/.zsh/antigen ]] && git clone https://github.com/zsh-users/antigen.git ~/.zsh/antigen
    # Create symlink for tmux
    [[ ! -s ~/bin/zsh ]] && ln -s "$(which zsh)" ~/bin/zsh
fi

case "${OSTYPE}" in
# MacOSX
darwin*)
    installPecoDarwin
    ;;
# Linux
linux*)
    installPecoLinux
    ;;
esac

installGitContrib
installNeobundleVim
message

# Delete trailing whitespace by git pre-commit hooks
# http://qiita.com/k0kubun/items/8f6d7eded1d833187449
# In .git/hooks/pre-commit
# . .git_hooks/delete_trailing_whitespace
