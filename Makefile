SHELL := /bin/zsh

COMMON_FLAGS := -euo pipefail

.PHONY: flag git zsh bash vim misc source brew zsh-autosuggestions

all: flag git zsh bash vim misc source brew zsh-autosuggestions

flag:
	set $(COMMON_FLAGS)

git: flag
	git config --global core.excludesfile $(realpath git/.gitignore_global)
	git config --global commit.template $(realpath git/.commit_template)
	$(call make_symlink, $(realpath git/.gitconfig))

zsh: flag
	$(call make_symlink, $(realpath zsh/$(shell uname)/.zshenv))
	$(call make_symlink, $(realpath zsh/$(shell uname)/.zshrc))

bash: flag
	$(call make_symlink, $(realpath bash/.bash_profile))
	$(call make_symlink, $(realpath bash/.bashrc))

vim: flag
	$(call make_symlink, $(realpath vim/.vimrc))

emacs: flag
	$(call make_symlink, $(realpath .emacs.d))

source: flag
	source ~/.zshenv && source ~/.zshrc

brew: flag
	bin/brew.sh

zsh-autosuggestions: flag zsh
	bin/zsh-autosuggestions.sh


compile:
	emacs --batch -f batch-byte-compile ~/.emacs.d/early-init.el ~/.emacs.d/init.el ~/.emacs.d/mine/init.el

define make_symlink
	ln -sf $1 ~
endef
