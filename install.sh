#!/bin/sh

if [[ `uname` == "Darwin" ]]; then
    #HomeBrew
    if ! which brew >/dev/null 2>&1 ; then
        echo "==> Downloading HomeBrew ..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    # Brewfileを使ってもろもろインストール
    brew bundle  --file $HOME/dotfiles/Brewfile
fi

make_symlink() {
    if [ $# -ne 1 ]; then
      echo "Usage: make_symlink <filename>" 1>&2
    fi    
    local FILE_PATH=$1
    local FILE_NAME=${FILE_PATH##*/}
    echo "    ln -sf $FILE_PATH $HOME/$FILE_NAME"
    ln -sf $FILE_PATH $HOME/$FILE_NAME
}

echo "==> dotfiles/git/"
for f in git/.??*
do
    # symlinkを貼りたくないファイルを以下に書いておく
    [[ "$f" == ".gitignore_global" ]] && continue
    [[ "$f" == ".commit_template" ]] && continue

    make_symlink $(realpath $f)
done

echo "==> dotfiles/zsh/"
if [[ `uname` == "Darwin" ]]; then
    make_symlink $HOME/dotfiles/zsh/macOS/.zshenv
    make_symlink $HOME/dotfiles/zsh/macOS/.zshrc
elif [[ `uname` == "Linux" ]]; then
    make_symlink $HOME/dotfiles/zsh/Linux/.zshenv
    make_symlink $HOME/dotfiles/zsh/Linux/.zshrc
fi

echo "==> dotfiles/bash/"
for f in bash/.??*
do
    make_symlink $(realpath $f)
done

echo "==> dotfiles/vim/"
for f in vim/.??*
do
    make_symlink $(realpath $f)
done

echo "==> dotfiles/"
for f in .??*
do
    # symlinkを貼りたくないファイルを以下に書いておく
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".gitmodules" ]] && continue
    [[ "$f" == ".spacemacs" ]] && continue
    [[ "$f" == ".tmux.conf" ]] && continue

    make_symlink $(realpath $f)
done

if [ ! -d ~/.zsh/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

echo "✅ Done"
