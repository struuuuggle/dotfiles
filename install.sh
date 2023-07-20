#!/bin/zsh

set -euo pipefail

make_symlink() {
    if [ $# -ne 1 ]; then
      echo "Usage: make_symlink <filename>" 1>&2
    fi    
    local FILE_PATH=$1
    local FILE_NAME=${FILE_PATH##*/}
    echo "    ln -sf $FILE_PATH $HOME/$FILE_NAME"
    ln -sf $FILE_PATH $HOME/$FILE_NAME
}

############################################################
# symlink

for f in git/.??*
do
    # symlinkを貼りたくないファイルを以下に書いておく
    [[ "$f" == ".gitignore_global" ]] && continue
    [[ "$f" == ".commit_template" ]] && continue

    make_symlink $(realpath $f)
done

make_symlink "$(realpath zsh/$(uname)/.zshenv)"
make_symlink "$(realpath zsh/$(uname)/.zshrc)"

for f in bash/.??*
do
    make_symlink $(realpath $f)
done

for f in vim/.??*
do
    make_symlink $(realpath $f)
done

for f in .??*
do
    # symlinkを貼りたくないファイルを以下に書いておく
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".gitmodules" ]] && continue
    [[ "$f" == ".tmux.conf" ]] && continue

    make_symlink $(realpath $f)
done

############################################################
# PATHを通しておく

source ~/.zshenv && source ~/.zshrc

############################################################
# HomeBrew

if [[ `uname` == "Darwin" ]]; then
    #HomeBrew
    if ! which brew >/dev/null 2>&1 ; then
        echo "==> Downloading HomeBrew ..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    # Brewfileを使ってもろもろインストール
    brew bundle  --file $(realpath Brewfile)
fi

############################################################
# zsh-autosuggestions

if [ ! -d ~/.zsh/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
