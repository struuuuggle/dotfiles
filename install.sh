#!/bin/sh

for f in .??*
do
    # symlinkを貼りたくないファイルを以下に書いておく
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".gitmodules" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".emacs.d.bak" ]] && continue

    if echo "$f" | grep ".zsh" >/dev/null; then
        if [[ `uname` == "Darwin" ]]; then
            ln -s $HOME/dotfiles/$f $HOME/${f%%.darwin}
        elif [[ `uname` == "Linux" ]]; then
            ln -s $HOME/dotfiles/$f $HOME/${f%%.linux}
        fi
    fi

done

exit 0
# Command Line Toolsのインストール
if ! which xcode-select --install >/dev/null 2>&1 ; then
    xcode-select --install
fi

# Powerline fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
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

# spacemacs
git clone https://github.com/syl20bnr/spacemacs.git ./.emacs.d

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
