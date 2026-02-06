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

brew: ## Set up HomeBrew
	@if [[ `uname` == "Darwin" ]]; then \
		@if ! which brew >/dev/null 2>&1 ; then \
			/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
		fi; \
		brew bundle --file Brewfile; \
	fi

zsh-autosuggestions: ## Set up zsh-autosuggestions
	@if [ ! -d ~/.zsh/zsh-autosuggestions ]; then \
		git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions; \
	fi

tangle-emacs: ## Tangle .emacs.d/init.org into .emacs.d/init.el
	@emacs -Q --batch \
		--eval "(require 'org)" \
		--eval "(org-babel-tangle-file \".emacs.d/init.org\" \"init.el\" \"emacs-lisp\")"

compile-emacs: tangle-emacs ## Compile init.el(s)
	@emacs --batch -l .emacs.d/init.el
	@emacs --batch -f batch-byte-compile-if-not-done .emacs.d/early-init.el .emacs.d/init.el

reinstall-emacs: ## Reinstall emacs via homebrew-emacs-plus
	@brew list --formula emacs-plus >/dev/null 2>&1 && brew uninstall emacs-plus || true
	@if [[ -e /Applications/Emacs.app ]]; then rm -rf /Applications/Emacs.app; fi
	@if [[ -e /Applications/Emacs\ Client.app ]]; then rm -rf /Applications/Emacs\ Client.app; fi
	brew install --cask emacs-plus-app
