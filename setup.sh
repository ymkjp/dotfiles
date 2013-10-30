#!/bin/bash

DOT_FILES=`cat ${HOME}/dotfiles/.gitignore | awk '$1 ~ /^\!/ { print $1 }' | sed -e "s/\!\///g" | sed -e "/setup.sh/d" | tr '\n' ' '`

for FILE in ${DOT_FILES[@]}
do
    ln -is ${HOME}/dotfiles/${FILE} ${HOME}
done

# install oh-my-zsh
[ ! -d ~/.oh-my-zsh ] && git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
