# Homebrew provided bin before system provided ones
export PATH=/usr/local/bin:~/.local/bin:$PATH

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="minimal"

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
plugins=(git github history-substring-search fzf-tab zsh-vi-mode)

source $ZSH/oh-my-zsh.sh
source $HOME/.zshrc.local

# disable zsh correct feature
unsetopt correct_all

ZVM_VI_INSERT_ESCAPE_BINDKEY=jj
ZVM_VI_EDITOR=nvim

function zvm_after_init() {
  # autojump (brew installed)
  [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
  bindkey '^o' fzf-history-widget
  FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border'

  source $ZSH/custom/plugins/fzf-tab/fzf-tab.zsh

  export GPG_TTY=$(tty)
}
