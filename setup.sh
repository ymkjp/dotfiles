#!/bin/bash

DOT_FILES_PATH="${HOME}/dotfiles"
DOT_FILES=`cat ${DOT_FILES_PATH}/.gitignore | awk '$1 ~ /^\!/ { print $1 }' | sed -e "s/\!\///g" | sed -e "/setup.sh/d" | tr '\n' ' '`
LOCAL_DOT_FILES=".zshrc.local .gitconfig.local"

for FILE in ${DOT_FILES[@]}
do
    ln -is ${DOT_FILES_PATH}/${FILE} ${HOME}
done

for FILE in ${LOCAL_DOT_FILES[@]}
do
    [[ ! -e ${DOT_FILES_PATH}/${FILE} ]] && touch ${DOT_FILES_PATH}/${FILE}
    ln -is ${DOT_FILES_PATH}/${FILE} ${HOME}
done

if type zsh > /dev/null 2>&1; then
    # Install oh-my-zsh
    [[ ! -d ~/.oh-my-zsh ]] && git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    . ${DOT_FILES_PATH}/.zshrc
fi

