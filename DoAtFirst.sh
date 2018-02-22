#!/bin/sh

# ref. http://www.aise.ics.saitama-u.ac.jp/~gotoh/IntroOfGitOnMacOSX.html#toc8

# シンボリックリンクを貼る
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile
ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.emacs.d ~/.emacs.d
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.spacemacs ~/.spacemacs

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

#ログインシェルをzshに変更
chsh -s /bin/zsh
