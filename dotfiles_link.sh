#!/bin/bash

CONFS=()
CONFS+=( .zshrc )
CONFS+=( .vimrc  )
CONFS+=( .vimperatorrc  )
CONFS+=( .vrapperrc )
CONFS+=( .tmux.conf )
CONFS+=( .gitconfig )

for e in ${CONFS[@]}; do
  ln -sf ~/my_git/dotfiles/${e} ~/${e}
done

APPCONF=( com.googlecode.iterm2.plist )
for a in ${APPCONF[@]}; do
  ln -sf ~/my_git/dotfiles/$a ~/Library/Preferences/$a
done

if [ ! -d ~/.vim/bundle ]; then
  mkdir -p ~/.vim/bundle
fi
if ! sudo cat /etc/shells | grep /usr/local/bin/zsh > /dev/null ; then
  sudo bash -c "echo '/usr/local/bin/zsh' >> /etc/shells"
  chsh -s /usr/local/bin/zsh
fi
# install app
if [ $# -gt 0 ]; then
  if [ $1 = "mac" ]; then
    if ! which brew > /dev/null ; then
      ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    fi
    brew update
    brew upgrade
    TAPS=(homebrew/versions homebrew/dupes homebrew/science phinze/homebrew-cask)
    for t in ${TAPS[@]}; do
      brew tap $t
    done
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
    brew install scala
    brew install sbt
    brew install android-sdk
    brew install libxml2 libxslt libiconv
    brew link --force libxml2
    brew link --force libxslt
    brew install gsl
    brew install nkf
    brew install r
    brew install expect

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
    brew cask install android-studio
    brew cask install genymotion
    brew cask install bettertouchtool
    brew cask install rstudio
    brew cask install skype
    brew cask install spectacle
    brew cask install google-hangouts
    brew cask install firefox
    brew cask install microsoft-office
    brew cask install sophos-anti-virus-home-edition
    brew cask install inkscape
    brew cask install google-chrome
      
  fi
fi
# vim setting
if [ ! -d ~/.vim/bundle/neobundle.vim ]; then
  git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi
if ! vim --version | grep "+clipboard" > /dev/null; then
  sudo mv /usr/bin/vim /usr/bin/old_vim
  sudo ln /usr/local/Cellar/vim/`ls /usr/local/Cellar/vim/`/bin/vim /usr/bin
fi
#  nfsd setting
if ! sudo nfsd status | grep "enable" ; then
  sudo nfsd enable
  sudo touch /etc/exports
fi
# vagrant setting
if which vagrant > /dev/null ; then
  if ! vagrant box list | grep centos64_dev_base > /dev/null; then
    vagrant box add centos64_dev_base ~/Vagrant/boxs/centos64_dev_base_20141229.box
  fi
  if ! vagrant plugin list | grep vagrant-omnibus > /dev/null; then
    vagrant plugin install vagrant-omnibus
  fi
  if ! vagrant plugin list | grep vagrant-berkshelf > /dev/null; then
    vagrant plugin install vagrant-berkshelf
  fi
fi
# ruby setting
if ! rbenv versions | grep 2.1.0 > /dev/null; then
  rbenv install 2.1.0
  rbenv global 2.1.0
fi
GEMS=()
GEMS+=( bundler )
GEMS+=( pry )
for g in ${GEMS[@]}; do
  if ! gem list | grep $g > /dev/null; then
    gem install $g
  fi
done
if ! gem list | grep nokogiri > /dev/null; then
  gem install nokogiri -- --use-system-libraries --with-iconv-dir="$(brew --prefix libiconv)" --with-xml2-config="$(brew --prefix libxml2)/bin/xml2-config" --with-xslt-config="$(brew --prefix libxslt)/bin/xslt-config"
fi
# embulk setting
if ! which embulk > /dev/null ; then
  curl --create-dirs -o ~/.embulk/bin/embulk -L https://bintray.com/artifact/download/embulk/maven/embulk-0.6.1.jar
  chmod +x ~/.embulk/bin/embulk
fi
