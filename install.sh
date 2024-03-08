#!/bin/zsh

install() {
  ln -sf $(pwd)/$1 $HOME/$1
}

install .zshrc
install .theme.zsh
install .gitconfig
