#!/bin/zsh

install() {
  local src=$1 dest=${2:-$HOME/$1}
  mkdir -p ${dest:h}
  if [ -f $dest ]; then
    cp $dest $dest.bak
    rm $dest
  fi
  ln -sf $(pwd)/$src $dest
  if [ -f $dest.bak ]; then
    cat $dest.bak > $dest
    rm $dest.bak
  fi
}

install .gitconfig
install .gitignore
install .theme.zsh
install .zshrc
install ghostty $HOME/.config/ghostty/config
