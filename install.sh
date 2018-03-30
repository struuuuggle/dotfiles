#!/bin/sh

# Usage: sh install.sh

for f in .??*
do
    # symlinkを貼りたくないファイルを以下に書いておく
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".emacs.d.bak" ]] && continue

    ln -s $HOME/dotfiles/$f $HOME/$f
done

# Command Line Toolsのインストール
xcode-select --install

# Powerline fonts
## clone
git clone https://github.com/powerline/fonts.git --depth=1
## install
cd fonts
./install.sh
## clean-up a bit
cd ..
rm -rf fonts

#HomeBrewのインストール
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Brewfileを使ってもろもろインストール
brew tap Homebrew/bundle
brew bundle

message=$(cat <<-EOF
################################################################
# To Use Homebrew Zsh, type the commands below!


# Open /etc/shells and add '/usr/local/bin/zsh'
\$ sudo emacs /etc/shells

# Change the shell
\$ chsh -s /usr/local/bin/zsh

################################################################
# Then you will have to setup .gitconfig and .gitignore_global

# .gitconfig ###################################################
[user]
  name = <YOUR NAME>
  email = <YOUR EMAIL ADDRESS>
[core]
  excludesfile = $HOME/.gitignore_global

# .gitignore_global ############################################
.DS_Store

EOF
   )

echo $message
