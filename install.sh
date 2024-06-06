#!/bin/zsh

install() {
  if [ -f $HOME/$1 ]; then
    cp $HOME/$1 $HOME/$1.bak
    rm $HOME/$1
  fi
  ln -sf $(pwd)/$1 $HOME/$1
  if [ -f $HOME/$1.bak ]; then
    cat $HOME/$1.bak > $HOME/$1
    rm $HOME/$1.bak
  fi
}

install .gitconfig
install .gitignore
install .theme.zsh
install .zshrc
