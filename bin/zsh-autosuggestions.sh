#!/bin/zsh

if [ ! -d ~/.zsh/zsh-autosuggestions ]; then
		git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
