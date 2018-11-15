#!/bin/sh

if [[ `uname` == "Darwin" ]]; then
    # Command Line Tools
    if ! which xcode-select --install >/dev/null 2>&1 ; then
        echo "Downloading Command Line Tools ..."
        xcode-select --install
    fi

    #HomeBrew
    if ! which brew >/dev/null 2>&1 ; then
        echo "Downloading HomeBrew ..."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    # Brewfileを使ってもろもろインストール
    brew install caskroom/cask/brew-cask
    brew tap Homebrew/bundle
    brew bundle
fi

# Powerline fonts
echo "Downloading Powerline fonts ..."
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# spacemacs
echo "Installing spacemacs ..."
git clone https://github.com/syl20bnr/spacemacs.git ~/dotfiles/.emacs.d

# Zsh
echo "Change default SHELL to Zsh ..."
sudo echo "/usr/local/bin/zsh" >> /etc/shells
chsh -s /usr/local/bin/zsh

# Symbolic links
echo "Creating symbolic links ..."
for f in .??*
do
    # symlinkを貼りたくないファイルを以下に書いておく
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".gitmodules" ]] && continue
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
