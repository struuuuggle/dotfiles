SHELL := /bin/zsh

COMMON_FLAGS := -euo pipefail

.PHONY: flag brwe git zsh bash vim misc source zsh-autosuggestions

all: flag brew git zsh bash vim misc source zsh-autosuggestions

flag:
	@set $(COMMON_FLAGS)

brew: flag
	bin/brew.sh

git: flag
	@ln -sf $(realpath git/.gitconfig) ~
	@if [ -f git/.gitconfig.local ]; then \
		ln -sf $(realpath git/.gitconfig.local) ~; \
	fi
	@git config --file ~/.gitconfig.local core.excludesfile $(realpath git/.gitignore_global)
	@git config --file ~/.gitconfig.local commit.template $(realpath git/.commit_template)

zsh: flag
	@ln -sf $(realpath zsh/$(shell uname)/.zshenv) ~
	@ln -sf $(realpath zsh/$(shell uname)/.zshrc) ~

bash: flag
	@ln -sf $(realpath bash/.bash_profile) ~
	@ln -sf $(realpath bash/.bashrc) ~

vim: flag
	@ln -sf $(realpath vim/.vimrc) ~

emacs: flag
	@ln -sf $(realpath .emacs.d) ~

source: flag
	@source ~/.zshenv && source ~/.zshrc

brew: flag
	@if [[ `uname` == "Darwin" ]]; then \
		if ! which brew >/dev/null 2>&1 ; then \
			/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
		fi; \
		brew bundle --file Brewfile; \
	fi

zsh-autosuggestions: flag zsh
	@if [ ! -d ~/.zsh/zsh-autosuggestions ]; then \
			git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions; \
	fi
	@source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

compile:
	@emacs --batch -l .emacs.d/init.el
	@emacs --batch -f batch-byte-compile-if-not-done .emacs.d/early-init.el .emacs.d/init.el .emacs.d/mine/init.el
