alias e='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'
alias ee='/Applications/Emacs.app/Contents/MacOS/Emacs &'
alias ls='gls --color=auto'

#for bash_completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  source $(brew --prefix)/etc/bash_completion
fi
