#!/bin/bash

# not tested, but these are roughly the commands to set up all dotfiles

sudo apt update # make sure packages are available to install

sudo apt install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo apt install neovim
sudo apt install fzf
sudo apt install ripgrep
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
curl -L git.io/antigen > $HOME/antigen.zsh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# create dotfiles
cd $HOME
ln -s dotfiles/.zshrc
ln -s dotfiles/.vimrc
ln -s dotfiles/.vim
ln -s dotfiles/.gitconfig
cp dotfiles/.gitconfig.local.example .gitconfig.local # update if needed
ln -s dotfiles/.gitignore_global
ln -s dotfiles/.p10k.zsh

mkdir -p .config/nvim
cd .config/nvim
ln -s $HOME/dotfiles/init.vim

