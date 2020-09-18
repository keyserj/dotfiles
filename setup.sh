#!/bin/bash

# not tested, but these are roughly the commands to set up all dotfiles

cd $HOME
ln -s dotfiles/.zshrc
ln -s dotfiles/.tmux.conf
ln -s dotfiles/.vimrc
ln -s dotfiles/.vim
ln -s dotfiles/.gitconfig

mkdir -p .config/nvim
cd .config/nvim
ln -s $HOME/dotfiles/init.vim
