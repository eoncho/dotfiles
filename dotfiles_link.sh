#!/bin/bash

set -u
set -o

if [ ! -d ~/.vim/bundle ]; then
  mkdir -p ~/.vim/bundle
fi
# install app
if [ $# -gt 0 ]; then
  CONFS=()
  CONFS+=( .zshrc )
  CONFS+=( .vimrc  )
  CONFS+=( .gitconfig )
  CONFS+=( .bash_profile )

  if [ $1 = "mac" ]; then
    echo "mac settings start"
    CONFS+=( .vimperatorrc  )
    CONFS+=( .vrapperrc )
    CONFS+=( .tmux.conf )

    # setting for vimperator
    if [ ! -e ~/.vimperator ]; then
      mkdir ~/.vimperator
    else
      cd ~/.vimperator
      if [ ! -e ~/.vimperator/vimppm ]; then
        mkdir vimppm
        cd vimppm
        git clone git://github.com/cd01/vimppm
      fi
    fi
    if ! which brew > /dev/null ; then
      echo ‘brew install !!’
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    brew update
    brew upgrade
    TAPS=(homebrew/versions homebrew/dupes homebrew/science phinze/homebrew-cask)
    for t in ${TAPS[@]}; do
      brew tap $t
    done
    brew install rbenv
    brew install rbenv-gem-rehash
    brew install rbenv-gemset
    brew install ruby-build

    # ruby setting
    if ! rbenv versions | grep 2.1.0 > /dev/null; then
      rbenv install 2.1.0
      rbenv global 2.1.0
    fi
    GEMS=()
    GEMS+=( bundler )
    GEMS+=( pry )
    GEMS+=( twterm )

    for g in ${GEMS[@]}; do
      if ! gem list | grep $g > /dev/null; then
        gem install $g
      fi
    done

    brew install brew-cask
    brew install pyenv-virtualenv
    brew install tmux
    brew install zsh
    brew install zsh-completions
    brew install wget
    brew install nmap
    brew install freetype 
    brew install libpng
    brew install vim
    brew install nkf
    brew install expect
    brew install automake
    brew install p7zip
    brew install reattach-to-user-namespace
    brew install unrar

    brew cask install iterm2
    brew cask install firefox
    brew cask install dropbox
    brew cask install slack
    brew cask install opera
    brew cask install freemind
    brew cask install kindle
    brew cask install multifirefox
    brew cask install typora

    if [ $# -gt 1 ]; then
      if [ $2 = "dev" ]; then
        brew install ctags
        brew install mongodb
        brew install mecab
        brew install mecab-ipadic
        brew install scala
        brew install sbt
        brew install android-sdk
        brew install libxml2 libxslt libiconv
        brew link --force libxml2
        brew link --force libxslt
        brew install ant
        brew install terraform
        brew install packer
        brew install w3m
        brew install gsl
        brew install r
        brew install e2fsprogs
        brew install go
        brew install tinysvm
        brew install direnv
        brew install libiomp
        brew install clang-omp
        brew install coreutil
        brew install phamtomjs
        brew install docker
        brew install docker-machine
        brew install mono
        brew install opencv
        brew install git-flow-avh
        brew install postgis
        brew install igraph
        brew install wine
        brew install zenity
        brew install apache-spark
        brew install snappy

        brew cask install osxfuse
        brew cask install java
        brew cask install eclipse-java
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
        brew cask install microsoft-office
        brew cask install sophos-anti-virus-home-edition
        brew cask install inkscape
        brew cask install google-chrome
        brew cask install latexit
        brew cask install mactex
        brew cask install haskell-platform
        brew cask install pg-commander
        brew cask install mindnode-pro
        brew cask install anaconda
        brew cask install postico
        brew cask install julia
        brew cask install cuda
        brew cask install unity
        brew cask install pgadmin4
        brew cask install atom
        brew cask install intellij-idea-ce 
        brew cask install netbeans
        
        brew unlink mysql-connector-c
        brew install https://raw.github.com/mroonga/homebrew/master/mroonga.rb --use-homebrew-mysql 
  
        # node setting
        if ! which nodebrew > /dev/null ; then
          curl https://raw.githubusercontent.com/hokaccha/nodebrew/master/nodebrew | perl - setup
          echo 'export PATH=$HOME/.nodebrew/current/bin:$PATH' >> ~/.zshrc
          source ~/.zshrc
          nodebrew install latest
          nodebrew use latest
        fi
        npm i -g archy
        npm i -g yo generator-hubot
        npm i --save-dev gulp
  
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
        if ! gem list | grep nokogiri > /dev/null; then
          gem install nokogiri -- --use-system-libraries --with-iconv-dir="$(brew --prefix libiconv)" --with-xml2-config="$(brew --prefix libxml2)/bin/xml2-config" --with-xslt-config="$(brew --prefix libxslt)/bin/xslt-config"
        fi
        # for pyenv
        if ! pyenv versions | grep miniconda > /dev/null ; then
          pyenv install miniconda-latest
        fi
        # embulk setting
        if ! which embulk > /dev/null ; then
          curl --create-dirs -o ~/.embulk/bin/embulk -L https://bintray.com/artifact/download/embulk/maven/embulk-0.6.1.jar
          chmod +x ~/.embulk/bin/embulk
        fi
        # for rust
        if ! which rustup > /dev/null ; then
          curl https://sh.rustup.rs -sSf | sh      
        fi
        # clang update
        if ! ls /usr/bin/clang-apple > /dev/null ; then
          if ls /usr/local/bin/clang-omp > /dev/null ; then
            sudo mv /usr/bin/clang /usr/bin/clang-apple
            sudo ln -fs /usr/local/bin/clang-omp /usr/bin/clang
            sudo cp /usr/local/lib/libiomp5.dylib /usr/lib/
          fi 
        fi

        if ! ls /usr/bin/clang++-apple > /dev/null ; then
          if ls /usr/local/bin/clang-omp++ > /dev/null ; then
            sudo mv /usr/local/bin/clang++ /usr/bin/clang++-apple
            sudo ln -fs /usr/bin/clang-omp++ /usr/bin/clang++
          fi
          if ! /usr/bin/clang++ > /dev/null ; then
            sudo ln -fs /usr/bin/clang /usr/bin/clang++
          fi
        fi
      fi
    fi 

    # vim update
    if ! vim --version | grep "+clipboard" > /dev/null; then
      sudo mv /usr/bin/vim /usr/bin/old_vim
      sudo ln /usr/local/Cellar/vim/`ls /usr/local/Cellar/vim/`/bin/vim /usr/bin
    fi

    if ! cat ~/.tmux.conf | grep reattach-to-user-namespace ? /dev/null; then
      echo 'set-option -g default-command "reattach-to-user-namespace -l bash"' >> ~/.tmux.conf
    fi
    #  nfsd setting
    if ! sudo nfsd status | grep "enable" ; then
      sudo nfsd enable
      sudo touch /etc/exports
    fi
  elif [ $1 = "ubuntu" ]; then 
    echo "----***---- ubuntu setting start ----***----"
    if [ $# -gt 1 ]; then
      if [ $2 = "dev" ]; then
        # for rust
        if ! which rustup > /dev/null ; then
          curl https://sh.rustup.rs -sSf | sh      
        fi
        # for scalaenv
        if ! which scalaenv > /dev/null ; then
          git clone git://github.com/mazgi/scalaenv.git ~/.scalaenv
        fi
      fi
    fi
    sudo apt install zsh
  fi
  for e in ${CONFS[@]}; do
    ln -sf `pwd`"/"${e} ~/${e}
  done
fi

# shell to zsh
if ! sudo cat /etc/shells | grep /usr/local/bin/zsh > /dev/null ; then
  sudo bash -c "echo '/usr/local/bin/zsh' >> /etc/shells"
  chsh -s /usr/local/bin/zsh
fi

# vim setting
if [ ! -d ~/.vim/bundle/neobundle.vim ]; then
  git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi
