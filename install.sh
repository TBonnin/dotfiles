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
exit 0

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install git
brew install gh

brew install --cask iterm2

brew install autojump
brew install bat
brew install ripgrep
brew install gpg

brew install fzf && $(brew --prefix)/opt/fzf/install -y
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
git clone https://github.com/jeffreytse/zsh-vi-mode ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode

curl https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Medium/complete/JetBrains%20Mono%20Medium%20Nerd%20Font%20Complete%20Mono.ttf -L > ~/Desktop/f.ttf && open ~/Desktop/f.ttf

brew install neovim && nvim -c ":lua require 'plugins' require('packer').sync()"

