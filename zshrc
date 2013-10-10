# Homebrew provided bin before system provided ones
export PATH=/usr/local/bin:$PATH

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(vi-mode git github history-substring-search autojump)

source $ZSH/oh-my-zsh.sh

# disable zsh correct feature
unsetopt correct_all

# Customize to your needs...

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:$HOME/Code/adt-bundle-mac-x86_64-20130729/sdk/platform-tools

alias l='ls -l'
alias la='ls -la'
alias .='echo $PWD'
alias lbin='/usr/local/bin/'
alias dotfiles='~/.dotfiles'
alias devbox='cd ~/Code/Livestream/platform/firestorm_web && vagrant ssh'
alias todo='vim ~/Dropbox/Livestream/todo.txt'

cssh() ( tmux-cssh $(host $@ | awk '{if (NR!=1) {printf $4 " "}}'); )

# Sweep a git submodule out of the working copy
git_remove_submodule() {
  SMD_PATH=$1
  if [ ! -d $SMD_PATH ]; then
    echo "$SMD_PATH does not exist"
    return 1
  fi
 
  git config -f .git/config --remove-section submodule.$SMD_PATH
  git config -f .gitmodules --remove-section submodule.$SMD_PATH
  git rm --cached $SMD_PATH
  rm -rf $SMD_PATH
  rm -rf .git/modules/$SMD_PATH
}

bindkey -M viins 'jj' vi-cmd-mode
