#!/bin/zsh

if [[ `uname` == "Darwin" ]]; then
		if ! which brew >/dev/null 2>&1 ; then
				/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		fi
		brew bundle --file Brewfile
fi
