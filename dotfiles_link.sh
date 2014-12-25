#!/bin/bash

ln -sf ~/my_git/dotfiles/.zshrc ~/.zshrc
ln -sf ~/my_git/dotfiles/.vimrc ~/.vimrc
ln -sf ~/my_git/dotfiles/.vimperatorrc ~/.vimperatorrc
ln -sf ~/my_git/dotfiles/.vrapperrc ~/.vrapperrc

if [ ! -d ~/.vim/bundle ]; then
  mkdir -p ~/.vim/bundle
fi
if [ ! -d ~/.vim/bundle/neobundle.vim ]; then
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
    brew install mongodb
    brew install wget
    brew install nmap
    brew install mecab
    brew install mecab-ipadic
    brew install freetype 
    brew install libpng
    brew install vim

    brew cask install java
    brew cask install eclipse-java
    brew cask install iterm2
    brew cask install sourcetree
    brew cask install sequel-pro
    brew cask install vagrant
    brew cask install virtualbox
    brew cask install karabiner
    brew cask install chefdk
    brew cask install xquartz
  fi
fi
if ! vim --version | grep "+clipboard" > /dev/null; then
  sudo mv /usr/bin/vim /usr/bin/old_vim
  sudo ln /usr/local/Cellar/vim/`ls /usr/local/Cellar/vim/`/bin/vim /usr/bin
fi
if ! rbenv versions | grep 2.1.0 > /dev/null; then
  rbenv install 2.1.0
  rbenv global 2.1.0
fi
if ! sudo nfsd status | grep "enable" ; then
  sudo nfsd enable
  sudo touch /etc/exports
fi
if which vagrant > /dev/null ; then
  if ! vagrant box list | grep centos64 > /dev/null; then
    vagrant box add centos64 http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20131103.box
  fi
  if ! vagrant plugin list | grep vagrant-omnibus > /dev/null; then
    vagrant plugin install vagrant-omnibus
  fi
  if ! vagrant plugin list | grep vagrant-berkshelf > /dev/null; then
    vagrant plugin install vagrant-berkshelf
  fi
fi
