#!/bin/sh

for f in .??*
do
    # symlinkを貼りたくないファイルを以下に書いておく
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".gitmodules" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".emacs.d.bak" ]] && continue

    ln -s $HOME/dotfiles/$f $HOME/$f
done

# Command Line Toolsのインストール
if ! which xcode-select --install >/dev/null 2>&1 ; then
    xcode-select --install
fi
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
if ! which brew >/dev/null 2>&1 ; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
# Brewfileを使ってもろもろインストール
brew install caskroom/cask/brew-cask
brew tap Homebrew/bundle
brew bundle

# Add Add'/usr/local/bin/zsh' to /etc/shells
sudo echo "usr/local/bin/zsh" >> /etc/shells

# Change the shell
chsh -s /usr/local/bin/zsh

message=$(cat <<-EOF
################################################################
# Finally, you will have to setup .gitconfig

# .gitconfig ###################################################
[user]
    name = <YOUR NAME>
    email = <YOUR EMAIL ADDRESS>
[core]
    excludesfile = ~/.gitignore_global
[color]
	ui = true
EOF
   )

echo "$message"
