#!/bin/bash

ln -sf ~/my_git/dotfiles/.zshrc ~/.zshrc
ln -sf ~/my_git/dotfiles/.vimrc ~/.vimrc
ln -sf ~/my_git/dotfiles/.vimperatorrc ~/.vimperatorrc

mkdir -p .vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
