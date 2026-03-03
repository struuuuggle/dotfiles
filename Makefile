SHELL := /bin/zsh

.SHELLFLAGS := -euo pipefail -c
.DEFAULT_GOAL := help

UNAME_S := $(shell uname)
STOW := stow
STOW_TARGET ?= $(HOME)
STOW_VERBOSE ?= 1
STOW_FLAGS = --verbose=$(STOW_VERBOSE) --target=$(STOW_TARGET)

.PHONY: help symlink stow stow-dry unstow macos debian zsh-autosuggestions compile-emacs reinstall-emacs

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'

symlink: stow ## Create symbolic links (alias of stow)

stow: ## Create symbolic links via GNU Stow
	@if ! command -v $(STOW) >/dev/null 2>&1; then \
		echo "GNU Stow (stow) not found."; \
		echo "macOS: brew install stow (or run: make macos)"; \
		echo "Debian/Ubuntu: sudo apt-get install stow (or run: make debian)"; \
		exit 1; \
	fi

	# Common packages (stow dir: repo root)
	$(STOW) --dir=. $(STOW_FLAGS) --restow git vim tmux

	# OS-specific packages (stow dir: each top-level folder)
	@if [ -d "zsh/$(UNAME_S)" ]; then \
		$(STOW) --dir=zsh $(STOW_FLAGS) --restow $(UNAME_S); \
	fi
	@if [ -d "bash/$(UNAME_S)" ]; then \
		$(STOW) --dir=bash $(STOW_FLAGS) --restow $(UNAME_S); \
	fi

	# Keep these as manual links for now
	ln -sf $(realpath .emacs.d) ~

	@if [[ "$(UNAME_S)" == "Darwin" ]]; then \
		mkdir -p "$$HOME/Library/Application Support/com.mitchellh.ghostty"; \
		ln -sf $(realpath ghostty/config) "$$HOME/Library/Application Support/com.mitchellh.ghostty/config"; \
	fi

	# Git local config (portable: rely on symlinks under HOME)
	git config --file ~/.gitconfig.local core.excludesfile ~/.gitignore_global
	git config --file ~/.gitconfig.local commit.template ~/.commit_template

stow-dry: ## Dry-run stow (no changes)
	@STOW_VERBOSE=2 $(MAKE) STOW_VERBOSE=2 stow STOW_FLAGS="--verbose=2 --target=$(STOW_TARGET) --no"

unstow: ## Remove symbolic links created by stow (git, zsh, bash, vim, tmux)
	@if ! command -v $(STOW) >/dev/null 2>&1; then \
		echo "GNU Stow (stow) not found."; \
		exit 1; \
	fi
	$(STOW) --dir=. $(STOW_FLAGS) --delete git vim tmux
	@if [ -d "zsh/$(UNAME_S)" ]; then \
		$(STOW) --dir=zsh $(STOW_FLAGS) --delete $(UNAME_S); \
	fi
	@if [ -d "bash/$(UNAME_S)" ]; then \
		$(STOW) --dir=bash $(STOW_FLAGS) --delete $(UNAME_S); \
	fi

macos: ## Set up macOS
	@if [[ `uname` == "Darwin" ]]; then \
		@if ! which brew >/dev/null 2>&1 ; then \
			/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
		fi; \
		brew bundle --file Brewfile; \
	fi

debian: ## Install minimum tools on Debian
	@if [[ `uname` != "Linux" ]]; then \
		echo "This target is for Debian-based Linux."; \
		exit 0; \
	fi
	@if ! command -v apt-get >/dev/null 2>&1; then \
		echo "apt-get not found. This target supports Debian/Ubuntu."; \
		exit 1; \
	fi
	@packages=(fzf git ghq gh emacs-nox stow); \
	missing_packages=(); \
	for pkg in $${packages[@]}; do \
		if ! dpkg -s "$$pkg" >/dev/null 2>&1; then \
			missing_packages+=("$$pkg"); \
		fi; \
	done; \
	if (( $${#missing_packages[@]} > 0 )); then \
		sudo apt-get update; \
		sudo apt-get install -y --no-install-recommends $${missing_packages[@]}; \
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
