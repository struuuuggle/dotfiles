SHELL              := /bin/bash
.SHELLFLAGS        := -euo pipefail -c
.DEFAULT_GOAL      := help

GREEN              := \033[32m
RED                := \033[31m
RESET              := \033[0m

OS                 := $(shell uname)
MACOS              := $(if $(filter Darwin,$(OS)),1)
DEBIAN             := $(if $(filter Linux,$(OS)),1)

GHOSTTY_CONFIG_DIR := $(HOME)/Library/Application Support/com.mitchellh.ghostty
EMACS_APP          := /Applications/Emacs.app
EMACSCLIENT_APP    := /Applications/Emacs Client.app

.PHONY: help symlink git zsh bash vim .emacs.d ghostty \
        zsh-autosuggestions emacs-compile emacs-restart \
        macos brewfile emacs-reinstall debian


##################################################
# common


# Show this help (only targets with ## comments are listed)
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "$(GREEN)%-20s$(RESET) %s\n", $$1, $$2}'

symlink: git zsh bash vim .emacs.d $(if $(MACOS),ghostty) ## Link dotfiles into $HOME

git:
	ln -sf $(realpath git/.gitconfig) ~
	@if [ -f git/.gitconfig.local ]; then \
		ln -sf $(realpath git/.gitconfig.local) ~; \
	fi
	git config --file \
    ~/.gitconfig.local core.excludesfile \
    $(realpath git/.gitignore_global)
	git config --file ~/.gitconfig.local \
    commit.template \
    $(realpath git/.commit_template)

zsh:
	ln -sf $(realpath zsh/$(OS))/.zshenv   ~
	ln -sf $(realpath zsh/$(OS))/.zshrc    ~
	ln -sf $(realpath zsh/$(OS))/.zprofile ~
	[ -d ~/.zsh/zsh-autosuggestions ] \
		|| git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

bash:
	ln -sf $(realpath bash/$(OS))/.bashrc       ~
	ln -sf $(realpath bash/$(OS))/.bash_profile ~

vim:
	ln -sf $(realpath vim/.vimrc) ~

.emacs.d:
	ln -sf $(realpath .emacs.d) ~

ghostty: guard-MACOS
	mkdir -p "$(GHOSTTY_CONFIG_DIR)"
	ln -sf \
    $(realpath ghostty/config) \
    "$(GHOSTTY_CONFIG_DIR)/config"

emacs-compile: .emacs.d/init.el ## Build Emacs config from init.org

emacs-restart: .emacs.d/init.el ## Restart Emacs daemon with the latest config
	emacsclient -e "(kill-emacs)" 2>/dev/null; emacs --daemon

.emacs.d/init.el: .emacs.d/init.org
	emacs -Q --batch \
		--eval "(require 'ob-tangle)" \
		--eval "(org-babel-tangle-file \".emacs.d/init.org\")"
	emacs --batch \
		--eval "(byte-recompile-directory \".emacs.d\" 0)"


##################################################
# macOS


macos: guard-MACOS ## Set up macOS
	@if ! command -v brew >/dev/null 2>&1; then \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	fi
	brew bundle --file Brewfile

brewfile: guard-MACOS ## Dump Brewfile
	brew bundle dump --no-vscode --no-go --file Brewfile -f

emacs-reinstall: guard-MACOS ## Reinstall Emacs via homebrew-emacs-plus
	@rm -rf "$(EMACS_APP)" "$(EMACSCLIENT_APP)"
	@brew uninstall --cask emacs-plus-app && brew install --cask emacs-plus-app


##################################################
# Debian


debian: guard-DEBIAN ## Install minimum tools on Debian
	@if ! dpkg -s zsh >/dev/null 2>&1; then \
		sudo apt-get update; \
		sudo apt-get install -y --no-install-recommends zsh; \
	fi
	@packages=(fzf git gh emacs-nox); \
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
	fi; \
	target_user="$${SUDO_USER:-$$(id -un)}"; \
	zsh_path="$$(command -v zsh)"; \
	current_shell="$$(getent passwd "$$target_user" | cut -d: -f7)"; \
	if [[ -n "$$zsh_path" && "$$current_shell" != "$$zsh_path" ]]; then \
		if [[ "$$(id -u)" -eq 0 ]]; then \
			chsh -s "$$zsh_path" "$$target_user"; \
		else \
			chsh -s "$$zsh_path"; \
		fi; \
	fi

##################################################
# misc

export GUARD_ERROR_MACOS
define GUARD_ERROR_MACOS
  $(RED)This target requires macOS.$(RESET)
  Current OS: $(OS)
endef

export GUARD_ERROR_DEBIAN
define GUARD_ERROR_DEBIAN
  $(RED)This target is for Debian-based Linux.$(RESET)
  Current OS: $(OS)
endef

guard-%:
	@if [ -z "$($(*))" ]; then \
		echo -e "$$GUARD_ERROR_$*" >&2; \
		exit 1; \
	fi
