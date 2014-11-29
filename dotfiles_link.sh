#!/bin/bash

ln -sf ~/my_git/dotfiles/.zshrc ~/.zshrc
ln -sf ~/my_git/dotfiles/.vimrc ~/.vimrc
ln -sf ~/my_git/dotfiles/.vimperatorrc ~/.vimperatorrc
ln -sf ~/my_git/dotfiles/.vrapperrc ~/.vrapperrc

if [ -e ~/.vim/bundle ]; then
    mkdir -p ~/.vim/bundle
fi
if [ -f ~/.vim/bundle/neobundle.vim ]; then
    git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi
