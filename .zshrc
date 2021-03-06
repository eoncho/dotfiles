## env setting ##

SHELL=/usr/local/bin/zsh
# vim key bind
bindkey -v

#zshプロンプトにモード表示
function zle-line-init zle-keymap-select {
  case $KEYMAP in
    vicmd)
    PROMPT="%{$fg[red]%}[%{$reset_color%}%n/%{$fg_bold[red]%}NOR%{$reset_color%}%{$fg[red]%}]%#%{$reset_color%} "
    ;;
    main|viins)
    PROMPT="%{$fg[red]%}[%{$reset_color%}%n/%{$fg_bold[cyan]%}INS%{$reset_color%}%{$fg[red]%}]%#%{$reset_color%} "
    ;;
  esac
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# color
autoload -Uz colors
colors

# History setting
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

## zsh option ##
setopt nobeep

# prompt color?

# background job tify
setopt no_tify

setopt hist_ignore_dups

setopt auto_pushd

setopt auto_cd

## path setting ##

typeset -U path cdpath fpath manpath

path=(
    $HOME/bin(N-/)
    $HOME/.rbenv/bin(N-/)
    $HOME/.pyenv/bin(N-/)
    $HOME/.embulk/bin(N-/)
    $HOME/.scalaenv/bin(N-/)
    $HOME/.goenv/bin(N-/)
    /usr/bin(N-/)
    /usr/local/bin(N-/)
    /usr/local/sbin(N-/)
    /usr/local/cuda/bin(N-/)
    /usr/local/opt/coreutils/libexec/gnubin(N-/)
    $path
)

## Completion setting ##
# completion on
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -Uz compinit
compinit -u

# 補完 大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../で今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろはコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin 

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

## vcs info setting ##
autoload -Uz vcs_info
#autoload -Uz add-zsh-hook
setopt prompt_subst


zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '%F{green}{%S}-{%b}%f'
zstyle ':vcs_info:*' actionformats '%F{red}{%S}-{%b|%a}%f'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '%F{yellow}!'
zstyle ':vcs_info:git:*' unstagedstr '%F{red}+'

function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT=$RPROMPT'${vcs_info_msg_0}'
}
precmd() { vcs_info }
#add-zsh-hook precmd _update_vcs_info_msg
RPROMPT=$RPROMPT'${vcs_info_msg_0}'

## alias ##
alias ls="ls -G"
alias la="ls -la"
alias ll="ls -l"

alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias knife="bundle exec knife"
alias berks="bundle exec berks"
alias time=/usr/bin/time
alias docker-start="docker-machine start default && eval ""$(docker-machine env default)"""

## others ##

# auto ls after change dir
function chpwd() { ls -l }

# change iTerms2 tab name
function title {
    echo -ne "\033]0;"$*"\007"
}

# rbenv init
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
# pyenv init
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
# pyenv-virtualenv init
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
# direnv
if which direnv > /dev/null; then eval "$(direnv hook zsh)"; fi
# scalaenv
if which scalaenv > /dev/null; then eval "$(scalaenv init -)"; fi
# goenv
if which goenv > /dev/null; then eval "$(goenv init -)"; fi

# ssh-agent-foward
SSH_AGENT_FILE="$HOME/.ssh-agent-info"
test -f $SSH_AGENT_FILE && source $SSH_AGENT_FILE
if ! ssh-add -l >& /dev/null ; then
  ssh-agent > $SSH_AGENT_FILE
  source $SSH_AGENT_FILE
  ssh-add
fi
# Caqrgo
if ! which rustc > /dev/null ; then source ~/.cargo/env; fi
 
# for android
export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PARH=$ANDROID_HOME/sdk/tools/bin:$PATH
# for flutter
export PATH=$HOME/develop/flutter/bin:$PATH
# for gohome
export GOPATH=$HOME/work/go
# for nodebrew
export PATH=$GOPATH/bin:$HOME/.nodebrew/current/bin:$HOME/Library/Haskell/bin:$PATH
# for sphinx
export LC_ALL=en_US.UTF-8
# for python
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
# cask-room
#export HOMEBREW_CASK_OPTS=--caskroom=/opt/homebrew-cask/Caskroom
# dor direnv
export EDITOR=vim

# for spark
export SPARK_HOME=

export PATH=$HOME/.nodebrew/current/bin:$PATH

# for jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
