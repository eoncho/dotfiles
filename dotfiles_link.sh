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

if [ $# -gt 0 ]; then
    if [ $1 = "mac" ]; then
        if ! which brew > /dev/null ; then
       	    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
        fi
        brew update
        brew upgrade
        brew tap homebrew/versions
        brew tap phinze/homebrew-cask
        brew install brew-cask
        brew install ctags
        brew install pyenv-virtualenv
        brew install rbenv
        brew install rbenv-gem-rehash
        brew install rbenv-gemset
        brew install ruby-build
       	brew install tmux
        brew install zsh
        brew install zsh-completions

        brew cask install java
        brew cask install eclipse-java
    fi
fi
