#!/usr/bin/env bash
set -o xtrace

# symbolic link dotfiles
DIR="$( cd "$( dirname "$0" )" && pwd )"
for source in "$DIR"/*
do
  basename=$(basename "$source")
  [ "$basename" = "README.md" ] && continue
  [ "$basename" = "install.sh" ] && continue
  target="$HOME/.$basename"
  [ ! -e "$target" ] && echo "Linking $basename" && ln -s "$source" "$target"
done

which -s brew
if [[ $? != 0 ]] ; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/thomas/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
    brew update
fi

# config
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 2

# install

brew install git
brew install gh # then: gh auth login
brew install pinentry-mac
brew install autojump
brew install bat
brew install ripgrep
brew install gpg
brew install starship
# brew install mos
brew install jq
brew install --cask iterm2
brew install --cask firefox
brew install --cask alfred
brew install --cask rectangle
brew install --cask 1password

brew install go
brew install gopls
brew install node
npm install -g typescript-language-server typescript

brew install --cask docker
# brew install kubectl
# brew install k9s
# brew install --cask google-chrome
# brew install --cask google-cloud-sdk
# brew install --cask slack
# brew install --cask zoom
# brew install --cask postico
# brew install libpq
# brew link --force libpq
brew install direnv
brew install entr
brew install stylua

brew install fzf && $(brew --prefix)/opt/fzf/install --all
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

curl https://hishtory.dev/install.py | python3 -

curl https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Medium/complete/JetBrains%20Mono%20Nerd%20Font%20Complete%20Mono%20Medium.ttf -L > ~/Desktop/f.ttf && open ~/Desktop/f.ttf

brew install neovim
