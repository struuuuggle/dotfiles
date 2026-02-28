SHELL := /bin/zsh

.SHELLFLAGS := -euo pipefail -c
.DEFAULT_GOAL := help

.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'

symlink: ## Create symbolic links(git, zsh, bash, vim, emacs)

	ln -sf $(realpath git/.gitconfig) ~
	@if [ -f git/.gitconfig.local ]; then \
		ln -sf $(realpath git/.gitconfig.local) ~; \
	fi
	git config --file ~/.gitconfig.local core.excludesfile $(realpath git/.gitignore_global)
	git config --file ~/.gitconfig.local commit.template $(realpath git/.commit_template)

	@if [ -f zsh/$(shell uname)/.zshenv ]; then \
		ln -sf $(realpath zsh/$(shell uname)/.zshenv) ~; \
	fi
	@if [ -f zsh/$(shell uname)/.zshrc ]; then \
		ln -sf $(realpath zsh/$(shell uname)/.zshrc) ~; \
	fi

	@if [ -f bash/$(shell uname)/.bashrc ]; then \
		ln -sf $(realpath bash/$(shell uname)/.bashrc) ~; \
	fi
	@if [ -f bash/$(shell uname)/.bash_profile ]; then \
		ln -sf $(realpath bash/$(shell uname)/.bash_profile) ~; \
	fi

	ln -sf $(realpath vim/.vimrc) ~

	ln -sf $(realpath .emacs.d) ~

	@if [[ `uname` == "Darwin" ]]; then \
		mkdir -p "$$HOME/Library/Application Support/com.mitchellh.ghostty"; \
		ln -sf $(realpath ghostty/config) "$$HOME/Library/Application Support/com.mitchellh.ghostty/config"; \
	fi

macos: ## Set up HomeBrew
	@if [[ `uname` == "Darwin" ]]; then \
		@if ! which brew >/dev/null 2>&1 ; then \
			/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
		fi; \
		brew bundle --file Brewfile; \
	fi

debian: ## Install minimum tools for zsh on Debian
	@if [[ `uname` != "Linux" ]]; then \
		echo "This target is for Debian-based Linux."; \
		exit 0; \
	fi
	@if ! command -v apt-get >/dev/null 2>&1; then \
		echo "apt-get not found. This target supports Debian/Ubuntu."; \
		exit 1; \
	fi
	@packages="fzf git ghq gh emacs-nox"; \
	missing_packages=""; \
	for pkg in $$packages; do \
		if ! dpkg -s "$$pkg" >/dev/null 2>&1; then \
			missing_packages="$$missing_packages $$pkg"; \
		fi; \
	done; \
	if [ -n "$$missing_packages" ]; then \
		sudo apt-get update; \
		sudo apt-get install -y --no-install-recommends $$missing_packages; \
	else \
		echo "Required packages are already installed."; \
	fi

zsh-autosuggestions: ## Set up zsh-autosuggestions
	@if [ ! -d ~/.zsh/zsh-autosuggestions ]; then \
		git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions; \
	fi

compile-emacs: ## Tangle init.org and byte-compile .emacs.d recursively
	@emacs -Q --batch \
		--eval "(require 'ob-tangle)" \
		--eval "(org-babel-tangle-file \".emacs.d/init.org\")"
	@emacs --batch --eval "(byte-recompile-directory \".emacs.d\" 0)"

reinstall-emacs: ## Reinstall emacs via homebrew-emacs-plus
	@brew list --formula emacs-plus >/dev/null 2>&1 && brew uninstall emacs-plus || true
	@if [[ -e /Applications/Emacs.app ]]; then rm -rf /Applications/Emacs.app; fi
	@if [[ -e /Applications/Emacs\ Client.app ]]; then rm -rf /Applications/Emacs\ Client.app; fi
	brew install --cask emacs-plus-app
