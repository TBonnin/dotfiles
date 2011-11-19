#export EDITOR=/opt/local/bin/emacs
export EDITOR=vim
set -o vi

alias ls='ls -FG'
alias ll='ls -lFG'
alias la='ls -AFG'
alias lla='ls -lAFG'
alias ..='cd ..'
alias ~='cd ~'
alias .='echo $PWD'
alias htdocs='cd /Applications/MAMP/htdocs/'
alias chx='sudo chmod +x'
alias dev='htdocs; mate .'
alias pdev='htdocs; mvim .'
alias sb='cd /Users/Thomas//.Sandbox/'
alias xcp='cd /Users/Thomas/Documents/XCodeProjects/'
alias lbin='cd /usr/local/bin/'
alias pmac='cd /Users/Thomas/Documents/XCodeProjects/Producteev/ProducteevMac'
alias piphone='cd /Users/Thomas/Documents/XCodeProjects/Producteev/ProducteeviPhonev5'
alias pengine='cd /Users/Thomas/Documents/XCodeProjects/Producteev/ProducteevCocoaEngine'
alias gae='cd ~/Documents/GAE'
alias | sed -E "s/^alias ([^=]+)='(.*)'$/alias \1 \2 \$*/g; s/'\\\''/'/g;" >~/.eshell/alias
