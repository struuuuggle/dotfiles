SHELL := /bin/zsh

COMMON_FLAGS := -euo pipefail

.PHONY: flag brwe git zsh bash vim misc source zsh-autosuggestions

all: flag brew git zsh bash vim misc source zsh-autosuggestions

flag:
	set $(COMMON_FLAGS)

brew: flag
	bin/brew.sh

git: flag
	$(call make_symlink, $(realpath git/.gitconfig))
	$(call make_symlink, $(realpath git/.gitconfig.local))
	git config --file ~/.gitconfig.local core.excludesfile $(realpath git/.gitignore_global)
	git config --file ~/.gitconfig.local commit.template $(realpath git/.commit_template)

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

zsh-autosuggestions: flag zsh
	bin/zsh-autosuggestions.sh


compile:
	emacs --batch -f batch-byte-compile ~/.emacs.d/early-init.el ~/.emacs.d/init.el ~/.emacs.d/mine/init.el

define make_symlink
	ln -sf $1 ~
endef
