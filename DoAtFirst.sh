#!/bin/sh

# ref. http://www.aise.ics.saitama-u.ac.jp/~gotoh/IntroOfGitOnMacOSX.html#toc8


# Command Line Toolsのインストール
xcode-select --install

#HomeBrewのインストール
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#インストールできたかチェック
brew help

#gitのインストール
brew install git

#git のバージョンを表示
git --version

#zshのインストール
brew install zsh zsh-autosuggestions zsh-completions zsh-syntax-highlighting colordiff reattach-to-user-namespace tmux
