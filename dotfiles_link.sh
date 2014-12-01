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
    brew cask install iterm2
    brew cask install sourcetree
    brew cask install sequel-pro
    brew cask install vagrant
    brew cask install virtualbox
    brew cask install karabiner
    brew cask install chefdk
  fi
fi
if [ which vagrant > /dev/null ]; then
  if [ ! -d ~/Vagrant/CentOS64 ]; then
    vagrant box add centos64 http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20131103.box
    mkdir -p ~/Vagrant/CentOS64
    cd ~/Vagrant/CentOS64
    ln -sf ~/my_git/dotfiles/Vagrantfile ~/Vagrant/CentOS64/Vagrantfile
    ln -sf ~/my_git/dotfiles/Berksfile ~/Vagrant/CentOS64/Berksfile
    vagrant plugin install vagrant-omnibus
    vagrant plugin install vagrant-berkshelf

    if [ -d ~/Vagrant/CentOS64/site-cookbooks ]; then
      mkdir ~/Vagrant/CentOS64/site-cookbooks
      cd ~/Vagrant/CentOS64/site-cookbooks
      berks cookbook rbenv-ruby
      cat ~/my_git/dotfiles/rbenv-ruby_default.rb >> ~/Vagrant/CentOS64/site-cookbooks/rbenv-ruby/recipes/defauld.rb
    fi
  fi
fi
