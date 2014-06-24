#!/bin/bash

ROOT_PATH="${HOME}/dotfiles"
DOT_FILES=`cat ${ROOT_PATH}/.gitignore | awk '$1 ~ /^\!/ { print $1 }' | sed -e "s/\!\///g"`
TARGET_FILES=`echo -e "${DOT_FILES}" | sed -e "/setup.sh/d" -e "/git_hooks/d" | tr '\n' ' '`
LOCAL_DOT_FILES=".zshrc.local .gitconfig.local"

for FILE in ${TARGET_FILES[@]}
do
    ln -is ${ROOT_PATH}/${FILE} ${HOME}
done

for FILE in ${LOCAL_DOT_FILES[@]}
do
    [[ ! -e ${ROOT_PATH}/${FILE} ]] && touch ${ROOT_PATH}/${FILE}
    ln -is ${ROOT_PATH}/${FILE} ${HOME}
done

if type zsh > /dev/null 2>&1; then
    # Install oh-my-zsh
    [[ ! -d ~/.oh-my-zsh ]] && git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

# Delete trailing whitespace by git pre-commit hooks
# http://qiita.com/k0kubun/items/8f6d7eded1d833187449
# In .git/hooks/pre-commit
# . .git_hooks/delete_trailing_whitespace
