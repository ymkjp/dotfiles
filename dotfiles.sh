#!/bin/sh

[[ -e ~/.dotfiles ]] || git clone git@github.com:ymkjp/.dotfiles.git ~/.dotfiles
pushd ~/.dotfiles

git submodule init
git submodule update
for i in `ls -a`
do
  [ $i = "." ] && continue
  [ $i = ".." ] && continue
  [ $i = ".git" ] && continue
  [ $i = "README.md" ] && continue
  ln -s ~/.dotfiles/$i ~/
done
vim -c ':BundleInstall!' -c ':q!' -c ':q!'
if [ `uname` = "Darwin" ]; then
  pushd ~/.dotfiles/.vim/bundle/vimproc
  make -f make_mac.mak
  popd
fi

popd
