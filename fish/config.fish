#theme
set fish_theme bobthefish

# override some options of theme-bobthefish
set -g theme_display_cmd_duration no
set -g theme_display_date no
set -g theme_title_use_abbreviated_path no

# peco
function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
end

# エイリアス
alias la 'ls -a'
alias ll 'ls -l'
alias rm 'rm -i'
alias cp 'cp -i'
alias mv 'mv -i'
alias mkdir 'mkdir -p'
#lsコマンドをglsコマンドに置き換え
alias ls 'gls --color=auto'

# CUI Emacs
alias e '/Applications/Emacs.app/Contents/MacOS/Emacs -nw'
# GUI Emacs
alias ee '/Applications/Emacs.app/Contents/MacOS/Emacs'
# VS Code
alias vsc '/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code'
# ssh
alias ssh_s15ti032 'ssh s15ti032@zenith.edu.ics.saitama-u.ac.jp'
# git
alias gs 'git status'
alias gp 'git push'
alias gl 'git log'
alias ga 'git add'
alias gc 'git commit'
# sudo の後のコマンドでエイリアスを有効にする
alias sudo 'sudo '

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# python
set -gx PATH $PATH /Users/Polaris/.pyenv/versions/3.6.4/bin/
. (pyenv init - | psub)
